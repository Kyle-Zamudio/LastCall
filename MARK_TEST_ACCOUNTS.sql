-- Mark your accounts as test accounts
-- This enables test mode: only test accounts will receive notifications

-- Step 1: Add test_account columns (if not already added)
ALTER TABLE workers
ADD COLUMN IF NOT EXISTS test_account BOOLEAN DEFAULT false;

ALTER TABLE businesses
ADD COLUMN IF NOT EXISTS test_account BOOLEAN DEFAULT false;

-- Step 2: Mark your worker accounts as test accounts
-- Using LOWER() to match emails case-insensitively
UPDATE workers 
SET test_account = true 
WHERE LOWER(email) IN (
  LOWER('ZKyle86@gmail.com'),
  LOWER('zkylez86@gmail.com')
);

-- Step 3: Mark your business accounts as test accounts
UPDATE businesses 
SET test_account = true 
WHERE LOWER(email) IN (
  LOWER('ZKyle86@gmail.com'),
  LOWER('zkylez86@gmail.com')
);

-- Step 4: Verify the test accounts are marked
SELECT 
  'Workers' as account_type,
  id, 
  email, 
  full_name as name, 
  test_account 
FROM workers 
WHERE LOWER(email) IN (LOWER('ZKyle86@gmail.com'), LOWER('zkylez86@gmail.com'))
UNION ALL
SELECT 
  'Businesses' as account_type,
  id, 
  email, 
  business_name as name, 
  test_account 
FROM businesses 
WHERE LOWER(email) IN (LOWER('ZKyle86@gmail.com'), LOWER('zkylez86@gmail.com'));

-- Expected result: You should see your accounts with test_account = true
