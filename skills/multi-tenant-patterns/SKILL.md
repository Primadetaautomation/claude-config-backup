# Multi-Tenant Architecture Patterns

**Category:** Backend/Database Architecture
**Version:** 1.0
**Progressive Levels:** 3 (Minimal → Detailed → Full)

---

## 📋 Level 1: Core Principles (Always Loaded)

### What This Skill Covers

Multi-tenant architecture patterns for building SaaS applications with complete data isolation, including:
- **Row Level Security (RLS)** for database-level tenant isolation
- **Public vs Authenticated Access** patterns
- **Tenant Context Management** in application code
- **Migration Strategies** from single to multi-tenant
- **Performance Optimization** for tenant-scoped queries

### When to Use This Skill

✅ **Use when:**
- Building SaaS applications with multiple customers/organizations
- Requiring complete data isolation between tenants
- Supporting both public and authenticated access patterns
- Scaling from single-tenant to multi-tenant architecture
- Implementing role-based access control within tenants

❌ **Don't use when:**
- Building single-customer applications
- Using separate databases per tenant (database-per-tenant model)
- Working with non-SQL databases without RLS support

---

## 🎯 Quick Decision Matrix

| Requirement | Pattern | Security Level |
|-------------|---------|----------------|
| Complete data isolation | PostgreSQL RLS | 🔒 High |
| Public job listings + private management | Hybrid RLS policies | 🔒 High |
| Per-tenant feature flags | Feature flags in tenant table | 🔐 Medium |
| Cross-tenant user access | Tenant memberships table | 🔒 High |
| Audit trail | Created/updated timestamps + user tracking | 🔐 Medium |

---

## 🏗️ Core Architecture Pattern

### Database Schema Foundation

```typescript
// Core tenant tables
tenants: {
  id: uuid (PK)
  name: string
  slug: string (unique)
  status: enum ('ACTIVE' | 'SUSPENDED' | 'INACTIVE')
  plan: enum ('STARTER' | 'GROWTH' | 'ENTERPRISE')
  featureFlags: json
}

tenantMemberships: {
  id: uuid (PK)
  userId: uuid (FK → users)
  tenantId: uuid (FK → tenants)
  role: enum ('VIEWER' | 'MEMBER' | 'MANAGER' | 'ADMIN' | 'OWNER')
  status: enum ('ACTIVE' | 'PENDING' | 'SUSPENDED')
}

// All business tables must include:
businessTable: {
  // ... existing fields
  tenantId: uuid (FK → tenants)  // Add to ALL tables
}
```

### Row Level Security (RLS) Pattern

```sql
-- Enable RLS on table
ALTER TABLE jobs ENABLE ROW LEVEL SECURITY;

-- Basic tenant isolation policy
CREATE POLICY tenant_isolation_policy ON jobs
  FOR ALL
  USING (
    tenant_id::uuid = current_setting('app.current_tenant_id', true)::uuid
  );
```

### Application Context Management

```typescript
// Set tenant context in middleware
async function setTenantContext(db, userId: string, tenantId: string) {
  await db.execute(sql`SET app.current_user_id = ${userId}`);
  await db.execute(sql`SET app.current_tenant_id = ${tenantId}`);
}
```

---

## 🔒 Security Principles (MUST Follow)

1. **Never trust client-provided tenant IDs** - Always derive from authenticated session
2. **Set tenant context BEFORE queries** - RLS policies depend on session variables
3. **Validate tenant membership** - Check user belongs to tenant before setting context
4. **Audit sensitive operations** - Log tenant context changes and access patterns
5. **Test cross-tenant access** - Verify RLS prevents data leakage between tenants

---

## 📚 Level 2: Detailed Patterns (Load on Request)

Use `/add .claude/skills/multi-tenant-patterns/detailed-patterns.md` for:
- Complete RLS policy patterns for all access types
- Public vs Authenticated access implementation
- INNER JOIN vs Separate Query patterns for public access
- Tenant membership validation strategies
- Role-based access control (RBAC) implementation
- Migration strategies from single to multi-tenant
- Performance optimization techniques

---

## 🛠️ Level 3: Scripts & Templates (Load on Request)

### Available Scripts

Use `/add .claude/skills/multi-tenant-patterns/scripts/` for:
- `create-tenant-schema.sql` - Complete tenant schema setup
- `add-tenant-columns.sql` - Add tenant_id to existing tables
- `create-rls-policies.sql` - RLS policy templates
- `validate-tenant-isolation.sql` - Test tenant isolation
- `migrate-to-multi-tenant.sql` - Data migration script

---

## 🚨 Common Pitfalls to Avoid

### ❌ Anti-Pattern: INNER JOIN with RLS
```typescript
// DON'T: This fails when RLS blocks joined tables
const job = await db
  .select({ job: jobs, user: users })
  .from(jobs)
  .innerJoin(users, eq(jobs.userId, users.id))
  .where(eq(jobs.id, jobId));
// Result: RLS blocks users table → INNER JOIN returns 0 rows
```

### ✅ Correct Pattern: Separate Queries for Public Access
```typescript
// DO: Query separately when no tenant context
const [job] = await db
  .select()
  .from(jobs)
  .where(and(eq(jobs.id, jobId), eq(jobs.status, 'OPEN')));

// Fetch related data separately (RLS allows specific fields)
const [user] = await db
  .select({ id: users.id, name: users.name })  // Only safe fields
  .from(users)
  .where(eq(users.id, job.userId));
```

### ❌ Anti-Pattern: Hardcoded Tenant IDs
```typescript
// DON'T: Never trust client-provided tenant IDs
const tenantId = req.body.tenantId;  // ❌ Dangerous!
await setTenantContext(db, userId, tenantId);
```

### ✅ Correct Pattern: Derive from Session
```typescript
// DO: Always derive tenant from authenticated session
const { userId, tenantId } = await validateSession(req);
await setTenantContext(db, userId, tenantId);
```

---

## 🎯 Implementation Checklist

### Phase 1: Database Setup
- [ ] Create tenant management tables (tenants, memberships, invitations)
- [ ] Add tenant_id to all business tables
- [ ] Update unique constraints to be tenant-scoped
- [ ] Create indexes for tenant-based queries
- [ ] Enable RLS on all tenant-aware tables

### Phase 2: RLS Policies
- [ ] Create utility functions (get_current_tenant_id, etc.)
- [ ] Implement tenant isolation policies
- [ ] Add public access policies for OPEN resources
- [ ] Test cross-tenant access prevention
- [ ] Validate policy performance

### Phase 3: Application Integration
- [ ] Implement authentication middleware with tenant context
- [ ] Update all queries to respect tenant context
- [ ] Add tenant switching functionality
- [ ] Implement role-based authorization
- [ ] Add audit logging for tenant operations

### Phase 4: Testing & Validation
- [ ] Unit tests for tenant isolation
- [ ] Integration tests for cross-tenant scenarios
- [ ] Performance tests with multiple tenants
- [ ] Security audit for data leakage
- [ ] Load testing with tenant-scoped queries

---

## 📊 Performance Optimization

### Index Strategy
```sql
-- Primary: Tenant-first composite indexes
CREATE INDEX jobs_tenant_id_status_idx ON jobs (tenant_id, status);
CREATE INDEX jobs_tenant_id_user_id_idx ON jobs (tenant_id, user_id);

-- Secondary: Tenant-only indexes for filtering
CREATE INDEX jobs_tenant_id_idx ON jobs (tenant_id);
```

### Query Patterns
```typescript
// GOOD: Tenant filter first (uses index efficiently)
WHERE tenant_id = $1 AND status = 'OPEN'

// BAD: Status filter first (full table scan)
WHERE status = 'OPEN' AND tenant_id = $1
```

---

## 🔍 Troubleshooting Guide

### Problem: "Tenant or user not found" error
**Cause:** RLS policy blocks access due to missing/invalid tenant context
**Solution:** Check tenant context is set before queries, verify tenant membership

### Problem: Public users can't view OPEN resources
**Cause:** RLS policy too restrictive, doesn't allow public access
**Solution:** Update policy to allow access when status = 'OPEN' AND no tenant context

### Problem: Slow queries after adding multi-tenancy
**Cause:** Missing indexes on tenant_id column
**Solution:** Add composite indexes: (tenant_id, frequently_filtered_column)

### Problem: Users see data from other tenants
**Cause:** Tenant context not set or RLS policy missing
**Solution:** Verify RLS enabled, check session variables are set correctly

---

## 📖 Related Skills

- `backend-development-patterns` - API design and database patterns
- `security-essentials` - Authentication and authorization
- `testing-fundamentals` - Testing tenant isolation
- `production-code-standards` - Error handling and logging

---

## 🎓 Learning Path

1. **Start here:** Understand RLS basics and tenant schema design
2. **Next:** Implement basic tenant isolation with RLS policies
3. **Then:** Add public access patterns for unauthenticated users
4. **Advanced:** Optimize performance with proper indexing
5. **Expert:** Migrate existing single-tenant app to multi-tenant

---

**Progressive Loading:**
- This Level 1 document: ~600 tokens (always loaded)
- Level 2 detailed-patterns.md: ~2000 tokens (load when needed)
- Level 3 scripts/: ~3000 tokens (load specific scripts only)

**Total Skill Budget:** ~5600 tokens (well under 10K recommendation)
