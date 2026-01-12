-- Quick script to mark YOUR accounts as test accounts
-- Replace the email addresses below with your actual test account emails

-- ============================================
-- STEP 1: Add the test_account column (run migration first)
-- ============================================
-- Run: migration_add_test_accounts.sql first!

-- ============================================
-- STEP 2: Mark your accounts as test accounts
-- ============================================
-- Replace these with your actual email addresses:

-- Your worker test accounts (replace with your emails):
UPDATE workers 
SET test_account = true 
WHERE email IN (
  'your-worker-email-1@example.com',
  'your-worker-email-2@example.com'
);

-- Your business test accounts (replace with your emails):
UPDATE businesses 
SET test_account = true 
WHERE email IN (
  'your-business-email-1@example.com',
  'your-business-email-2@example.com'
);

-- ============================================
-- STEP 3: Verify your test accounts
-- ============================================
-- Run these to see which accounts are marked as test:

-- SELECT id, email, full_name, test_account FROM workers WHERE test_account = true;
-- SELECT id, email, business_name, test_account FROM businesses WHERE test_account = true;

-- ============================================
-- How Test Mode Works:
-- ============================================
-- Once you mark ANY account as test_account = true:
-- ✅ Only test accounts will receive notifications
-- ✅ All other users will NOT receive notifications
-- ✅ This prevents bombarding real users during testing

-- To disable test mode (send to everyone again):
-- UPDATE workers SET test_account = false;
-- UPDATE businesses SET test_account = false;
