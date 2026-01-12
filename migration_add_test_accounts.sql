-- Migration: Add test account flags to prevent sending notifications to real users during testing

-- Add test_account column to workers table
ALTER TABLE workers
ADD COLUMN IF NOT EXISTS test_account BOOLEAN DEFAULT false;

-- Add test_account column to businesses table
ALTER TABLE businesses
ADD COLUMN IF NOT EXISTS test_account BOOLEAN DEFAULT false;

-- Add global test mode setting (we'll store this in a settings table or use an environment variable)
-- For now, we'll use a simple approach: if ANY test accounts exist, only send to test accounts

COMMENT ON COLUMN workers.test_account IS 'If true, this is a test account. In test mode, only test accounts receive notifications.';
COMMENT ON COLUMN businesses.test_account IS 'If true, this is a test account. In test mode, only test accounts receive notifications.';

-- Note: After running this, you'll need to manually mark your test accounts
-- Example: UPDATE workers SET test_account = true WHERE email = 'your-email@example.com';
-- Example: UPDATE businesses SET test_account = true WHERE email = 'your-email@example.com';
