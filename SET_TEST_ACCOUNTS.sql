-- Script to mark your accounts as test accounts
-- Replace the email addresses with your actual test account emails

-- Mark your worker test accounts
-- UPDATE workers SET test_account = true WHERE email = 'your-worker-email-1@example.com';
-- UPDATE workers SET test_account = true WHERE email = 'your-worker-email-2@example.com';

-- Mark your business test accounts  
-- UPDATE businesses SET test_account = true WHERE email = 'your-business-email-1@example.com';
-- UPDATE businesses SET test_account = true WHERE email = 'your-business-email-2@example.com';

-- To see which accounts are marked as test accounts:
-- SELECT id, email, full_name, test_account FROM workers WHERE test_account = true;
-- SELECT id, email, business_name, test_account FROM businesses WHERE test_account = true;

-- To disable test mode (send to everyone again):
-- UPDATE workers SET test_account = false;
-- UPDATE businesses SET test_account = false;
