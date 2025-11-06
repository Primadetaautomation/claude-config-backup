# Multi-Tenant Patterns - Detailed Implementation

## 📋 Table of Contents
1. [RLS Policy Patterns](#rls-policy-patterns)
2. [Public vs Authenticated Access](#public-vs-authenticated-access)
3. [Tenant Context Management](#tenant-context-management)
4. [Role-Based Access Control](#role-based-access-control)
5. [Migration Strategies](#migration-strategies)
6. [Performance Optimization](#performance-optimization)

---

## 🔒 RLS Policy Patterns

### Pattern 1: Basic Tenant Isolation

**Use Case:** Standard tenant-scoped access for authenticated users

```sql
-- Utility function to get current tenant
CREATE OR REPLACE FUNCTION get_current_tenant_id()
RETURNS UUID AS $$
BEGIN
  RETURN current_setting('app.current_tenant_id', true)::UUID;
EXCEPTION WHEN OTHERS THEN
  RETURN NULL;
END;
$$ LANGUAGE plpgsql STABLE;

-- Basic isolation policy
CREATE POLICY tenant_isolation_policy ON jobs
  FOR ALL
  USING (tenant_id = get_current_tenant_id());
```

**Security Level:** 🔒 High - Complete tenant isolation

---

### Pattern 2: Hybrid Public + Private Access

**Use Case:** Public can view OPEN resources, authenticated users see all their tenant's resources

```sql
CREATE POLICY hybrid_access_policy ON jobs
  FOR ALL
  USING (
    -- Authenticated users: Access their tenant's jobs
    (
      get_current_tenant_id() IS NOT NULL
      AND tenant_id = get_current_tenant_id()
    )
    OR
    -- Public users: Only OPEN jobs
    (
      get_current_tenant_id() IS NULL
      AND status = 'OPEN'
    )
  );
```

**Security Level:** 🔒 High - Controlled public access

**Key Points:**
- `get_current_tenant_id() IS NULL` detects unauthenticated users
- Status check ensures only approved content is public
- Authenticated users maintain full tenant isolation

---

### Pattern 3: Role-Based Tenant Access

**Use Case:** Different access levels within a tenant based on user role

```sql
-- Function to check if user has minimum role
CREATE OR REPLACE FUNCTION user_has_minimum_role(
  p_user_id UUID,
  p_tenant_id UUID,
  p_minimum_role TEXT
)
RETURNS BOOLEAN AS $$
DECLARE
  v_role_hierarchy JSONB := '{
    "VIEWER": 1,
    "MEMBER": 2,
    "MANAGER": 3,
    "ADMIN": 4,
    "OWNER": 5
  }';
  v_user_role TEXT;
  v_user_level INT;
  v_minimum_level INT;
BEGIN
  -- Get user's role in tenant
  SELECT role INTO v_user_role
  FROM tenant_memberships
  WHERE user_id = p_user_id
    AND tenant_id = p_tenant_id
    AND status = 'ACTIVE';

  IF v_user_role IS NULL THEN
    RETURN FALSE;
  END IF;

  -- Compare role levels
  v_user_level := (v_role_hierarchy->>v_user_role)::INT;
  v_minimum_level := (v_role_hierarchy->>p_minimum_role)::INT;

  RETURN v_user_level >= v_minimum_level;
END;
$$ LANGUAGE plpgsql STABLE;

-- Policy that enforces role requirements
CREATE POLICY role_based_access_policy ON sensitive_data
  FOR ALL
  USING (
    tenant_id = get_current_tenant_id()
    AND user_has_minimum_role(
      current_setting('app.current_user_id', true)::UUID,
      tenant_id,
      'MANAGER'  -- Minimum role required
    )
  );
```

**Security Level:** 🔒 High - Role-based + tenant isolation

---

### Pattern 4: Column-Level Access Control

**Use Case:** Hide sensitive columns from lower-tier roles

```sql
-- Create view with safe fields for public/low-privilege access
CREATE VIEW jobs_public AS
SELECT
  id,
  tenant_id,
  title,
  description,
  status,
  created_at,
  -- EXCLUDE: internal_notes, salary_range, applicant_count
FROM jobs
WHERE status = 'OPEN';

-- Grant access to view only
GRANT SELECT ON jobs_public TO authenticated, anon;
```

**Application-Level Alternative:**

```typescript
// Service layer controls field exposure
async getJobById(jobId: string, userRole: string) {
  const job = await db.query.jobs.findFirst({
    where: eq(jobs.id, jobId),
    // Select fields based on role
    columns: {
      id: true,
      title: true,
      description: true,
      // Only show salary for MANAGER and above
      ...(userRole === 'MANAGER' || userRole === 'ADMIN' ? {
        salaryRange: true,
      } : {}),
    },
  });
  return job;
}
```

**Security Level:** 🔐 Medium - Requires application enforcement

---

## 🌐 Public vs Authenticated Access

### Problem: INNER JOIN Failures with RLS

**Scenario:** Public user tries to view job with company info, but RLS blocks joined tables.

```typescript
// ❌ FAILS: INNER JOIN requires ALL tables to return rows
const result = await db
  .select({
    job: jobs,
    user: users,      // RLS blocks: user not in tenant
    tenant: tenants,  // RLS blocks: user not in tenant
  })
  .from(jobs)
  .innerJoin(users, eq(jobs.userId, users.id))      // Blocks here
  .innerJoin(tenants, eq(jobs.tenantId, tenants.id)) // Or here
  .where(eq(jobs.id, jobId));
// Result: 0 rows returned, even though job is OPEN
```

**Root Cause:**
- Jobs table RLS: ✅ Allows public access to OPEN jobs
- Users table RLS: ❌ Blocks access (no tenant membership)
- Tenants table RLS: ❌ Blocks access (no tenant membership)
- INNER JOIN: ❌ Returns 0 rows if ANY table is blocked

---

### Solution 1: Separate Queries (Recommended)

```typescript
async getJobById(jobId: string, tenantId?: string) {
  if (tenantId) {
    // Authenticated user: use INNER JOIN (RLS allows all)
    const [result] = await db
      .select({
        job: jobs,
        user: {
          id: users.id,
          name: users.name,
          email: users.email,
          companyName: users.companyName,
        },
        tenant: {
          id: tenants.id,
          name: tenants.name,
          slug: tenants.slug,
        },
      })
      .from(jobs)
      .innerJoin(users, eq(jobs.userId, users.id))
      .innerJoin(tenants, eq(jobs.tenantId, tenants.id))
      .where(and(
        eq(jobs.id, jobId),
        eq(jobs.tenantId, tenantId)
      ))
      .limit(1);

    return result;
  } else {
    // Public user: separate queries to avoid JOIN failures

    // Step 1: Get OPEN job
    const [job] = await db
      .select()
      .from(jobs)
      .where(and(
        eq(jobs.id, jobId),
        eq(jobs.status, 'OPEN')
      ))
      .limit(1);

    if (!job) {
      throw new Error('Job not found or not public');
    }

    // Step 2: Get user info (only safe fields)
    const [userData] = await db
      .select({
        id: users.id,
        name: users.name,
        companyName: users.companyName,
        // NO email, password, or sensitive data
      })
      .from(users)
      .where(eq(users.id, job.userId))
      .limit(1);

    // Step 3: Get tenant info (only safe fields)
    const [tenantData] = await db
      .select({
        id: tenants.id,
        name: tenants.name,
        slug: tenants.slug,
        // NO billing, API keys, or internal config
      })
      .from(tenants)
      .where(eq(tenants.id, job.tenantId))
      .limit(1);

    return {
      job,
      user: userData || { id: null, name: 'Anonymous', companyName: null },
      tenant: tenantData || { id: null, name: 'Unknown', slug: null },
    };
  }
}
```

**Benefits:**
- ✅ Avoids INNER JOIN failures
- ✅ Explicitly controls field exposure
- ✅ Provides fallback defaults if RLS blocks access
- ✅ Maintains different logic paths for auth vs public

**Trade-offs:**
- ⚠️ Multiple queries (slightly higher latency)
- ⚠️ More complex code (but more secure)

---

### Solution 2: Public RLS Policies (Alternative)

Update RLS policies to allow public SELECT on specific columns:

```sql
-- Allow public SELECT on users table (basic info only)
CREATE POLICY public_user_info_policy ON users
  FOR SELECT
  USING (true);  -- Allow all rows

-- ⚠️ WARNING: Application MUST only select safe fields
-- Example safe query:
-- SELECT id, name, company_name FROM users WHERE id = $1;
--
-- ❌ NEVER expose: email, password, phone, isAdmin, etc.

COMMENT ON POLICY public_user_info_policy ON users IS
  'Public can view basic user info. APPLICATION MUST select only safe fields (id, name, companyName)';
```

**Application responsibility:**

```typescript
// Good: Explicitly select safe fields
const user = await db
  .select({
    id: users.id,
    name: users.name,
    companyName: users.companyName,
  })
  .from(users)
  .where(eq(users.id, userId));

// ❌ BAD: Selects ALL columns (exposes sensitive data)
const user = await db.query.users.findFirst({
  where: eq(users.id, userId),
});
```

**Security Level:** 🔐 Medium - Requires strict application discipline

---

## 🔑 Tenant Context Management

### Middleware Pattern (Express/Hono)

```typescript
import { sql } from 'drizzle-orm';

async function tenantContextMiddleware(req, res, next) {
  try {
    // 1. Validate authentication
    const session = await validateSession(req);

    if (!session) {
      // Public access: no context needed
      return next();
    }

    const { userId, email } = session;

    // 2. Get user's tenants
    const memberships = await db.query.tenantMemberships.findMany({
      where: and(
        eq(tenantMemberships.userId, userId),
        eq(tenantMemberships.status, 'ACTIVE')
      ),
      with: {
        tenant: true,
      },
    });

    if (memberships.length === 0) {
      return res.status(403).json({
        error: 'No active tenant membership',
      });
    }

    // 3. Determine active tenant
    // Option A: From header/query param
    let tenantId = req.headers['x-tenant-id'] || req.query.tenantId;

    // Option B: Use first/default tenant
    if (!tenantId) {
      tenantId = memberships[0].tenantId;
    }

    // 4. Validate user belongs to requested tenant
    const membership = memberships.find(m => m.tenantId === tenantId);
    if (!membership) {
      return res.status(403).json({
        error: 'Access denied to this tenant',
      });
    }

    // 5. Set database context for RLS
    await db.execute(sql`SET app.current_user_id = ${userId}`);
    await db.execute(sql`SET app.current_tenant_id = ${tenantId}`);
    await db.execute(sql`SET app.current_user_email = ${email}`);

    // 6. Attach to request for use in handlers
    req.tenantContext = {
      userId,
      tenantId,
      role: membership.role,
      tenant: membership.tenant,
    };

    next();
  } catch (error) {
    console.error('Tenant context error:', error);
    res.status(500).json({ error: 'Failed to set tenant context' });
  }
}
```

---

### Transaction-Scoped Context

```typescript
async function executeInTenantContext<T>(
  db: Database,
  userId: string,
  tenantId: string,
  fn: (tx: Transaction) => Promise<T>
): Promise<T> {
  return await db.transaction(async (tx) => {
    // Set context for this transaction
    await tx.execute(sql`SET LOCAL app.current_user_id = ${userId}`);
    await tx.execute(sql`SET LOCAL app.current_tenant_id = ${tenantId}`);

    // Execute user function
    return await fn(tx);

    // Context automatically cleared when transaction ends
  });
}

// Usage:
const result = await executeInTenantContext(
  db,
  userId,
  tenantId,
  async (tx) => {
    // All queries in this block have tenant context
    const jobs = await tx.query.jobs.findMany();
    return jobs;
  }
);
```

---

## 👥 Role-Based Access Control

### Role Hierarchy

```typescript
export const ROLE_HIERARCHY = {
  VIEWER: 1,   // Read-only access
  MEMBER: 2,   // Basic CRUD operations
  MANAGER: 3,  // Team management
  ADMIN: 4,    // Full tenant configuration
  OWNER: 5,    // Billing + transfer ownership
} as const;

export type TenantRole = keyof typeof ROLE_HIERARCHY;

export function hasMinimumRole(
  userRole: TenantRole,
  requiredRole: TenantRole
): boolean {
  return ROLE_HIERARCHY[userRole] >= ROLE_HIERARCHY[requiredRole];
}
```

### Authorization Middleware

```typescript
function requireRole(minimumRole: TenantRole) {
  return (req, res, next) => {
    const { role } = req.tenantContext;

    if (!hasMinimumRole(role, minimumRole)) {
      return res.status(403).json({
        error: `Requires ${minimumRole} role or higher`,
      });
    }

    next();
  };
}

// Usage in routes:
router.post('/jobs', requireRole('MEMBER'), createJob);
router.delete('/jobs/:id', requireRole('MANAGER'), deleteJob);
router.patch('/tenant/settings', requireRole('ADMIN'), updateSettings);
```

---

## 🔄 Migration Strategies

### Phase 1: Add Tenant Infrastructure

```sql
-- 1. Create tenant management tables
CREATE TABLE tenants (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  status TEXT DEFAULT 'ACTIVE',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE tenant_memberships (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id),
  tenant_id UUID NOT NULL REFERENCES tenants(id),
  role TEXT NOT NULL DEFAULT 'MEMBER',
  status TEXT DEFAULT 'ACTIVE',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, tenant_id)
);

-- 2. Create default tenant for migration
INSERT INTO tenants (id, name, slug, status)
VALUES ('00000000-0000-0000-0000-000000000001', 'Default Tenant', 'default', 'ACTIVE');
```

### Phase 2: Add Tenant Columns

```sql
-- Add tenant_id to existing tables
ALTER TABLE jobs ADD COLUMN tenant_id UUID;

-- Set default tenant for existing data
UPDATE jobs
SET tenant_id = '00000000-0000-0000-0000-000000000001'
WHERE tenant_id IS NULL;

-- Make tenant_id required
ALTER TABLE jobs ALTER COLUMN tenant_id SET NOT NULL;

-- Add foreign key constraint
ALTER TABLE jobs
  ADD CONSTRAINT jobs_tenant_id_fkey
  FOREIGN KEY (tenant_id) REFERENCES tenants(id);

-- Update unique constraints to be tenant-scoped
ALTER TABLE jobs
  DROP CONSTRAINT IF EXISTS jobs_user_id_title_key;

ALTER TABLE jobs
  ADD CONSTRAINT jobs_tenant_id_user_id_title_key
  UNIQUE (tenant_id, user_id, title);
```

### Phase 3: Enable RLS

```sql
-- Enable RLS
ALTER TABLE jobs ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY tenant_isolation_policy ON jobs
  FOR ALL
  USING (tenant_id = get_current_tenant_id());
```

### Phase 4: Migrate User Memberships

```sql
-- Create tenant membership for all existing users
INSERT INTO tenant_memberships (user_id, tenant_id, role, status)
SELECT
  id,
  '00000000-0000-0000-0000-000000000001',
  CASE
    WHEN is_admin THEN 'ADMIN'
    ELSE 'MEMBER'
  END,
  'ACTIVE'
FROM users
WHERE NOT EXISTS (
  SELECT 1 FROM tenant_memberships
  WHERE user_id = users.id
);
```

---

## ⚡ Performance Optimization

### Index Strategy

```sql
-- Primary: Tenant-first composite indexes
CREATE INDEX jobs_tenant_id_status_idx
  ON jobs (tenant_id, status);

CREATE INDEX jobs_tenant_id_created_at_idx
  ON jobs (tenant_id, created_at DESC);

-- For filtering + sorting
CREATE INDEX jobs_tenant_id_status_created_at_idx
  ON jobs (tenant_id, status, created_at DESC);

-- For user-specific queries
CREATE INDEX jobs_tenant_id_user_id_idx
  ON jobs (tenant_id, user_id);
```

### Query Patterns

```typescript
// ✅ GOOD: Tenant filter uses index efficiently
const jobs = await db.query.jobs.findMany({
  where: and(
    eq(jobs.tenantId, tenantId),
    eq(jobs.status, 'OPEN')
  ),
  orderBy: desc(jobs.createdAt),
});

// ❌ BAD: Status filter first causes full scan
const jobs = await db.query.jobs.findMany({
  where: and(
    eq(jobs.status, 'OPEN'),
    eq(jobs.tenantId, tenantId)
  ),
});
```

### Connection Pooling

```typescript
// Configure pool per tenant (for high-traffic tenants)
const tenantPools = new Map<string, Pool>();

function getPoolForTenant(tenantId: string): Pool {
  if (!tenantPools.has(tenantId)) {
    tenantPools.set(tenantId, new Pool({
      connectionString: DATABASE_URL,
      max: 10, // Per-tenant limit
    }));
  }
  return tenantPools.get(tenantId)!;
}
```

---

## 📊 Monitoring & Analytics

### Tenant Usage Tracking

```typescript
// Track queries per tenant
const tenantMetrics = new Map<string, { queries: number, latency: number }>();

function trackTenantQuery(tenantId: string, latency: number) {
  const metrics = tenantMetrics.get(tenantId) || { queries: 0, latency: 0 };
  metrics.queries++;
  metrics.latency += latency;
  tenantMetrics.set(tenantId, metrics);
}

// Middleware to track
app.use((req, res, next) => {
  const start = Date.now();
  res.on('finish', () => {
    const latency = Date.now() - start;
    if (req.tenantContext) {
      trackTenantQuery(req.tenantContext.tenantId, latency);
    }
  });
  next();
});
```

---

## 🔍 Testing Tenant Isolation

### Unit Test Example

```typescript
describe('Tenant Isolation', () => {
  it('should prevent cross-tenant data access', async () => {
    // Create two tenants
    const tenant1 = await createTenant({ name: 'Tenant 1' });
    const tenant2 = await createTenant({ name: 'Tenant 2' });

    // Create jobs in each tenant
    const job1 = await createJob({ tenantId: tenant1.id, title: 'Job 1' });
    const job2 = await createJob({ tenantId: tenant2.id, title: 'Job 2' });

    // Set context for tenant 1
    await setTenantContext(db, userId, tenant1.id);

    // Fetch jobs
    const jobs = await db.query.jobs.findMany();

    // Should only see tenant 1's jobs
    expect(jobs).toHaveLength(1);
    expect(jobs[0].id).toBe(job1.id);
    expect(jobs.find(j => j.id === job2.id)).toBeUndefined();
  });
});
```

---

**Document Version:** 1.0
**Token Count:** ~2000 tokens
