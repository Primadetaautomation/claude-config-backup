-- ================================
-- Multi-Tenant Schema Setup
-- Description: Creates complete tenant management infrastructure
-- Version: 1.0
-- ================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ================================
-- ENUMS
-- ================================

CREATE TYPE tenant_status AS ENUM ('ACTIVE', 'SUSPENDED', 'INACTIVE', 'DELETED');
CREATE TYPE tenant_plan AS ENUM ('STARTER', 'GROWTH', 'UNLIMITED', 'ENTERPRISE');
CREATE TYPE membership_role AS ENUM ('VIEWER', 'MEMBER', 'MANAGER', 'ADMIN', 'OWNER');
CREATE TYPE membership_status AS ENUM ('ACTIVE', 'PENDING', 'SUSPENDED', 'INACTIVE');
CREATE TYPE invitation_status AS ENUM ('PENDING', 'ACCEPTED', 'DECLINED', 'EXPIRED', 'CANCELLED');

-- ================================
-- TENANTS TABLE
-- ================================

CREATE TABLE tenants (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  status tenant_status DEFAULT 'ACTIVE',
  plan tenant_plan DEFAULT 'STARTER',

  -- Optional fields
  subdomain TEXT UNIQUE,
  custom_domain TEXT UNIQUE,
  logo_url TEXT,

  -- Feature flags (JSON)
  feature_flags JSONB DEFAULT '{}',

  -- Settings (JSON)
  settings JSONB DEFAULT '{}',

  -- Billing
  stripe_customer_id TEXT,

  -- Metadata
  metadata JSONB DEFAULT '{}',

  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  -- Constraints
  CONSTRAINT tenants_name_check CHECK (length(name) >= 2),
  CONSTRAINT tenants_slug_check CHECK (slug ~ '^[a-z0-9-]+$')
);

COMMENT ON TABLE tenants IS 'Core tenant entities for multi-tenant SaaS application';
COMMENT ON COLUMN tenants.feature_flags IS 'JSON object with feature toggles: {"advanced_analytics": true, "api_access": false}';
COMMENT ON COLUMN tenants.settings IS 'JSON object with tenant-specific configuration';

-- Indexes
CREATE INDEX tenants_status_idx ON tenants (status);
CREATE INDEX tenants_plan_idx ON tenants (plan);
CREATE INDEX tenants_slug_idx ON tenants (slug);

-- ================================
-- TENANT MEMBERSHIPS TABLE
-- ================================

CREATE TABLE tenant_memberships (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  role membership_role DEFAULT 'MEMBER',
  status membership_status DEFAULT 'ACTIVE',

  -- Custom permissions (overrides defaults)
  custom_permissions JSONB DEFAULT '{}',

  -- Invitation tracking
  invited_by UUID,
  invitation_id UUID,

  -- Timestamps
  joined_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  -- Constraints
  UNIQUE(user_id, tenant_id)
);

COMMENT ON TABLE tenant_memberships IS 'Links users to tenants with role-based access control';
COMMENT ON COLUMN tenant_memberships.custom_permissions IS 'JSON object to override default role permissions';

-- Indexes
CREATE INDEX tenant_memberships_user_id_idx ON tenant_memberships (user_id);
CREATE INDEX tenant_memberships_tenant_id_idx ON tenant_memberships (tenant_id);
CREATE INDEX tenant_memberships_tenant_id_status_idx ON tenant_memberships (tenant_id, status);

-- ================================
-- TENANT INVITATIONS TABLE
-- ================================

CREATE TABLE tenant_invitations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
  invited_by UUID NOT NULL,

  -- Invitation details
  email TEXT NOT NULL,
  role membership_role DEFAULT 'MEMBER',
  status invitation_status DEFAULT 'PENDING',

  -- Token for secure acceptance
  token TEXT UNIQUE NOT NULL,

  -- Optional message
  message TEXT,

  -- Metadata
  metadata JSONB DEFAULT '{}',

  -- Timestamps
  expires_at TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '7 days'),
  accepted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  -- Constraints
  CONSTRAINT tenant_invitations_email_check CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$')
);

COMMENT ON TABLE tenant_invitations IS 'Manages secure user invitations to tenants';

-- Indexes
CREATE INDEX tenant_invitations_tenant_id_idx ON tenant_invitations (tenant_id);
CREATE INDEX tenant_invitations_email_idx ON tenant_invitations (email);
CREATE INDEX tenant_invitations_token_idx ON tenant_invitations (token);
CREATE INDEX tenant_invitations_status_idx ON tenant_invitations (status);

-- ================================
-- UTILITY FUNCTIONS
-- ================================

-- Function: Get current tenant ID from session
CREATE OR REPLACE FUNCTION get_current_tenant_id()
RETURNS UUID AS $$
BEGIN
  RETURN current_setting('app.current_tenant_id', true)::UUID;
EXCEPTION WHEN OTHERS THEN
  RETURN NULL;
END;
$$ LANGUAGE plpgsql STABLE;

-- Function: Get current user ID from session
CREATE OR REPLACE FUNCTION get_current_user_id()
RETURNS UUID AS $$
BEGIN
  RETURN current_setting('app.current_user_id', true)::UUID;
EXCEPTION WHEN OTHERS THEN
  RETURN NULL;
END;
$$ LANGUAGE plpgsql STABLE;

-- Function: Get user's accessible tenant IDs
CREATE OR REPLACE FUNCTION get_current_user_tenant_ids()
RETURNS UUID[] AS $$
DECLARE
  v_user_id UUID;
BEGIN
  v_user_id := get_current_user_id();

  IF v_user_id IS NULL THEN
    RETURN ARRAY[]::UUID[];
  END IF;

  RETURN ARRAY(
    SELECT tenant_id
    FROM tenant_memberships
    WHERE user_id = v_user_id
      AND status = 'ACTIVE'
  );
END;
$$ LANGUAGE plpgsql STABLE;

-- Function: Check if user has access to tenant
CREATE OR REPLACE FUNCTION user_has_tenant_access(
  p_user_id UUID,
  p_tenant_id UUID
)
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1
    FROM tenant_memberships
    WHERE user_id = p_user_id
      AND tenant_id = p_tenant_id
      AND status = 'ACTIVE'
  );
END;
$$ LANGUAGE plpgsql STABLE;

-- Function: Check if user has minimum role in tenant
CREATE OR REPLACE FUNCTION user_has_minimum_role(
  p_user_id UUID,
  p_tenant_id UUID,
  p_minimum_role membership_role
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
  v_user_role membership_role;
  v_user_level INT;
  v_minimum_level INT;
BEGIN
  -- Get user's role
  SELECT role INTO v_user_role
  FROM tenant_memberships
  WHERE user_id = p_user_id
    AND tenant_id = p_tenant_id
    AND status = 'ACTIVE';

  IF v_user_role IS NULL THEN
    RETURN FALSE;
  END IF;

  -- Compare levels
  v_user_level := (v_role_hierarchy->>v_user_role::text)::INT;
  v_minimum_level := (v_role_hierarchy->>p_minimum_role::text)::INT;

  RETURN v_user_level >= v_minimum_level;
END;
$$ LANGUAGE plpgsql STABLE;

-- Function: Generate secure invitation token
CREATE OR REPLACE FUNCTION generate_invitation_token()
RETURNS TEXT AS $$
BEGIN
  RETURN encode(gen_random_bytes(32), 'hex');
END;
$$ LANGUAGE plpgsql VOLATILE;

-- Function: Create tenant with owner
CREATE OR REPLACE FUNCTION create_tenant_with_owner(
  p_user_id UUID,
  p_tenant_name TEXT,
  p_tenant_slug TEXT
)
RETURNS UUID AS $$
DECLARE
  v_tenant_id UUID;
BEGIN
  -- Create tenant
  INSERT INTO tenants (name, slug)
  VALUES (p_tenant_name, p_tenant_slug)
  RETURNING id INTO v_tenant_id;

  -- Create owner membership
  INSERT INTO tenant_memberships (user_id, tenant_id, role, status)
  VALUES (p_user_id, v_tenant_id, 'OWNER', 'ACTIVE');

  RETURN v_tenant_id;
END;
$$ LANGUAGE plpgsql;

-- Function: Invite user to tenant
CREATE OR REPLACE FUNCTION invite_user_to_tenant(
  p_tenant_id UUID,
  p_invited_by UUID,
  p_email TEXT,
  p_role membership_role DEFAULT 'MEMBER',
  p_message TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
  v_invitation_id UUID;
  v_token TEXT;
BEGIN
  -- Generate secure token
  v_token := generate_invitation_token();

  -- Create invitation
  INSERT INTO tenant_invitations (
    tenant_id,
    invited_by,
    email,
    role,
    token,
    message
  )
  VALUES (
    p_tenant_id,
    p_invited_by,
    p_email,
    p_role,
    v_token,
    p_message
  )
  RETURNING id INTO v_invitation_id;

  RETURN v_invitation_id;
END;
$$ LANGUAGE plpgsql;

-- Function: Accept invitation
CREATE OR REPLACE FUNCTION accept_tenant_invitation(
  p_user_id UUID,
  p_token TEXT
)
RETURNS UUID AS $$
DECLARE
  v_invitation RECORD;
  v_membership_id UUID;
BEGIN
  -- Get invitation
  SELECT * INTO v_invitation
  FROM tenant_invitations
  WHERE token = p_token
    AND status = 'PENDING'
    AND expires_at > NOW();

  IF v_invitation IS NULL THEN
    RAISE EXCEPTION 'Invalid or expired invitation';
  END IF;

  -- Create membership
  INSERT INTO tenant_memberships (
    user_id,
    tenant_id,
    role,
    status,
    invited_by,
    invitation_id
  )
  VALUES (
    p_user_id,
    v_invitation.tenant_id,
    v_invitation.role,
    'ACTIVE',
    v_invitation.invited_by,
    v_invitation.id
  )
  RETURNING id INTO v_membership_id;

  -- Update invitation
  UPDATE tenant_invitations
  SET status = 'ACCEPTED',
      accepted_at = NOW()
  WHERE id = v_invitation.id;

  RETURN v_membership_id;
END;
$$ LANGUAGE plpgsql;

-- ================================
-- TRIGGERS
-- ================================

-- Update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tenants_updated_at
  BEFORE UPDATE ON tenants
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER tenant_memberships_updated_at
  BEFORE UPDATE ON tenant_memberships
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER tenant_invitations_updated_at
  BEFORE UPDATE ON tenant_invitations
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

-- ================================
-- SUCCESS MESSAGE
-- ================================

DO $$
BEGIN
  RAISE NOTICE '';
  RAISE NOTICE '✅ Multi-tenant schema created successfully!';
  RAISE NOTICE '';
  RAISE NOTICE 'Tables created:';
  RAISE NOTICE '  - tenants';
  RAISE NOTICE '  - tenant_memberships';
  RAISE NOTICE '  - tenant_invitations';
  RAISE NOTICE '';
  RAISE NOTICE 'Functions created:';
  RAISE NOTICE '  - get_current_tenant_id()';
  RAISE NOTICE '  - get_current_user_id()';
  RAISE NOTICE '  - get_current_user_tenant_ids()';
  RAISE NOTICE '  - user_has_tenant_access()';
  RAISE NOTICE '  - user_has_minimum_role()';
  RAISE NOTICE '  - create_tenant_with_owner()';
  RAISE NOTICE '  - invite_user_to_tenant()';
  RAISE NOTICE '  - accept_tenant_invitation()';
  RAISE NOTICE '';
  RAISE NOTICE 'Next steps:';
  RAISE NOTICE '  1. Run add-tenant-columns.sql to add tenant_id to existing tables';
  RAISE NOTICE '  2. Run create-rls-policies.sql to enable Row Level Security';
  RAISE NOTICE '';
END $$;
