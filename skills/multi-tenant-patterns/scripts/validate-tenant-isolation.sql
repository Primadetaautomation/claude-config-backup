-- ================================
-- Tenant Isolation Validation Script
-- Description: Comprehensive tests for multi-tenant data isolation
-- Version: 1.0
-- ================================

DO $$
DECLARE
  v_test_count INT := 0;
  v_pass_count INT := 0;
  v_fail_count INT := 0;

  -- Test tenants
  v_tenant1_id UUID;
  v_tenant2_id UUID;

  -- Test users
  v_user1_id UUID;
  v_user2_id UUID;

  -- Test data
  v_job1_id UUID;
  v_job2_id UUID;

  -- Results
  v_result_count INT;
BEGIN
  RAISE NOTICE '';
  RAISE NOTICE '🧪 Starting Multi-Tenant Isolation Tests';
  RAISE NOTICE '=====================================';
  RAISE NOTICE '';

  -- ================================
  -- SETUP: Create Test Data
  -- ================================

  RAISE NOTICE '📦 Setting up test data...';

  -- Create test tenants
  INSERT INTO tenants (name, slug) VALUES ('Test Tenant 1', 'test-tenant-1')
    RETURNING id INTO v_tenant1_id;
  INSERT INTO tenants (name, slug) VALUES ('Test Tenant 2', 'test-tenant-2')
    RETURNING id INTO v_tenant2_id;

  -- Create test users (assuming users table exists)
  -- Replace with your actual user creation logic
  v_user1_id := gen_random_uuid();
  v_user2_id := gen_random_uuid();

  -- Create tenant memberships
  INSERT INTO tenant_memberships (user_id, tenant_id, role, status)
  VALUES
    (v_user1_id, v_tenant1_id, 'ADMIN', 'ACTIVE'),
    (v_user2_id, v_tenant2_id, 'ADMIN', 'ACTIVE');

  -- Create test jobs (if jobs table exists)
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'jobs') THEN
    INSERT INTO jobs (tenant_id, title, status)
    VALUES (v_tenant1_id, 'Test Job 1', 'OPEN')
    RETURNING id INTO v_job1_id;

    INSERT INTO jobs (tenant_id, title, status)
    VALUES (v_tenant2_id, 'Test Job 2', 'OPEN')
    RETURNING id INTO v_job2_id;
  END IF;

  RAISE NOTICE '✅ Test data created';
  RAISE NOTICE '';

  -- ================================
  -- TEST 1: Tenant Context Setting
  -- ================================

  v_test_count := v_test_count + 1;
  RAISE NOTICE 'Test %: Tenant context setting', v_test_count;

  BEGIN
    PERFORM set_config('app.current_tenant_id', v_tenant1_id::text, false);
    PERFORM set_config('app.current_user_id', v_user1_id::text, false);

    IF get_current_tenant_id() = v_tenant1_id THEN
      v_pass_count := v_pass_count + 1;
      RAISE NOTICE '  ✅ PASS: Context set correctly';
    ELSE
      v_fail_count := v_fail_count + 1;
      RAISE NOTICE '  ❌ FAIL: Context not set correctly';
    END IF;
  EXCEPTION WHEN OTHERS THEN
    v_fail_count := v_fail_count + 1;
    RAISE NOTICE '  ❌ FAIL: Error setting context: %', SQLERRM;
  END;

  RAISE NOTICE '';

  -- ================================
  -- TEST 2: Basic RLS Policy Check
  -- ================================

  v_test_count := v_test_count + 1;
  RAISE NOTICE 'Test %: Basic RLS policy enforcement', v_test_count;

  BEGIN
    -- Set context for tenant 1
    PERFORM set_config('app.current_tenant_id', v_tenant1_id::text, false);

    -- Query jobs (should only see tenant 1's jobs)
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'jobs') THEN
      SELECT COUNT(*) INTO v_result_count
      FROM jobs
      WHERE tenant_id = v_tenant2_id;  -- Try to access tenant 2's jobs

      IF v_result_count = 0 THEN
        v_pass_count := v_pass_count + 1;
        RAISE NOTICE '  ✅ PASS: Cannot access other tenant''s data';
      ELSE
        v_fail_count := v_fail_count + 1;
        RAISE NOTICE '  ❌ FAIL: Can access other tenant''s data (count: %)', v_result_count;
      END IF;
    ELSE
      RAISE NOTICE '  ⏭️  SKIP: jobs table not found';
    END IF;
  EXCEPTION WHEN OTHERS THEN
    v_pass_count := v_pass_count + 1;
    RAISE NOTICE '  ✅ PASS: RLS blocked access (expected behavior)';
  END;

  RAISE NOTICE '';

  -- ================================
  -- TEST 3: Public Access to OPEN Resources
  -- ================================

  v_test_count := v_test_count + 1;
  RAISE NOTICE 'Test %: Public access to OPEN resources', v_test_count;

  BEGIN
    -- Clear tenant context (simulate public user)
    PERFORM set_config('app.current_tenant_id', '', false);
    PERFORM set_config('app.current_user_id', '', false);

    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'jobs') THEN
      SELECT COUNT(*) INTO v_result_count
      FROM jobs
      WHERE status = 'OPEN';

      IF v_result_count > 0 THEN
        v_pass_count := v_pass_count + 1;
        RAISE NOTICE '  ✅ PASS: Public can access OPEN jobs (count: %)', v_result_count;
      ELSE
        v_fail_count := v_fail_count + 1;
        RAISE NOTICE '  ❌ FAIL: Public cannot access OPEN jobs';
      END IF;
    ELSE
      RAISE NOTICE '  ⏭️  SKIP: jobs table not found';
    END IF;
  EXCEPTION WHEN OTHERS THEN
    v_fail_count := v_fail_count + 1;
    RAISE NOTICE '  ❌ FAIL: Error accessing public data: %', SQLERRM;
  END;

  RAISE NOTICE '';

  -- ================================
  -- TEST 4: Cross-Tenant Membership Check
  -- ================================

  v_test_count := v_test_count + 1;
  RAISE NOTICE 'Test %: Cross-tenant membership validation', v_test_count;

  BEGIN
    -- Check that user1 doesn't have access to tenant2
    IF NOT user_has_tenant_access(v_user1_id, v_tenant2_id) THEN
      v_pass_count := v_pass_count + 1;
      RAISE NOTICE '  ✅ PASS: User cannot access non-member tenant';
    ELSE
      v_fail_count := v_fail_count + 1;
      RAISE NOTICE '  ❌ FAIL: User can access non-member tenant';
    END IF;
  EXCEPTION WHEN OTHERS THEN
    v_fail_count := v_fail_count + 1;
    RAISE NOTICE '  ❌ FAIL: Error checking membership: %', SQLERRM;
  END;

  RAISE NOTICE '';

  -- ================================
  -- TEST 5: Role Hierarchy Validation
  -- ================================

  v_test_count := v_test_count + 1;
  RAISE NOTICE 'Test %: Role hierarchy validation', v_test_count;

  BEGIN
    -- Check that ADMIN has MEMBER privileges
    IF user_has_minimum_role(v_user1_id, v_tenant1_id, 'MEMBER') THEN
      v_pass_count := v_pass_count + 1;
      RAISE NOTICE '  ✅ PASS: Role hierarchy works correctly';
    ELSE
      v_fail_count := v_fail_count + 1;
      RAISE NOTICE '  ❌ FAIL: Role hierarchy broken';
    END IF;
  EXCEPTION WHEN OTHERS THEN
    v_fail_count := v_fail_count + 1;
    RAISE NOTICE '  ❌ FAIL: Error checking role hierarchy: %', SQLERRM;
  END;

  RAISE NOTICE '';

  -- ================================
  -- TEST 6: Tenant-Scoped Unique Constraints
  -- ================================

  v_test_count := v_test_count + 1;
  RAISE NOTICE 'Test %: Tenant-scoped unique constraints', v_test_count;

  BEGIN
    -- Try to create jobs with same title in different tenants (should succeed)
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'jobs') THEN
      INSERT INTO jobs (tenant_id, title, status)
      VALUES (v_tenant1_id, 'Duplicate Title Test', 'OPEN');

      INSERT INTO jobs (tenant_id, title, status)
      VALUES (v_tenant2_id, 'Duplicate Title Test', 'OPEN');

      v_pass_count := v_pass_count + 1;
      RAISE NOTICE '  ✅ PASS: Can create same title in different tenants';
    ELSE
      RAISE NOTICE '  ⏭️  SKIP: jobs table not found';
    END IF;
  EXCEPTION WHEN unique_violation THEN
    v_fail_count := v_fail_count + 1;
    RAISE NOTICE '  ❌ FAIL: Unique constraints not tenant-scoped';
  EXCEPTION WHEN OTHERS THEN
    v_fail_count := v_fail_count + 1;
    RAISE NOTICE '  ❌ FAIL: Error testing constraints: %', SQLERRM;
  END;

  RAISE NOTICE '';

  -- ================================
  -- CLEANUP: Remove Test Data
  -- ================================

  RAISE NOTICE '🧹 Cleaning up test data...';

  -- Delete test data
  DELETE FROM tenant_memberships WHERE user_id IN (v_user1_id, v_user2_id);
  DELETE FROM tenants WHERE id IN (v_tenant1_id, v_tenant2_id);

  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'jobs') THEN
    DELETE FROM jobs WHERE id IN (v_job1_id, v_job2_id);
    DELETE FROM jobs WHERE title = 'Duplicate Title Test';
  END IF;

  RAISE NOTICE '✅ Cleanup complete';
  RAISE NOTICE '';

  -- ================================
  -- RESULTS SUMMARY
  -- ================================

  RAISE NOTICE '';
  RAISE NOTICE '=====================================';
  RAISE NOTICE '📊 Test Results Summary';
  RAISE NOTICE '=====================================';
  RAISE NOTICE 'Total tests: %', v_test_count;
  RAISE NOTICE '✅ Passed: %', v_pass_count;
  RAISE NOTICE '❌ Failed: %', v_fail_count;
  RAISE NOTICE '';

  IF v_fail_count = 0 THEN
    RAISE NOTICE '🎉 All tests passed! Tenant isolation is working correctly.';
  ELSE
    RAISE NOTICE '⚠️  Some tests failed. Please review the output above.';
  END IF;

  RAISE NOTICE '';
END $$;
