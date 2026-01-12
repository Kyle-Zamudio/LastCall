-- Debug script to check notification setup

-- 1. Check if your worker account is set up correctly
SELECT 
  'Worker Check' as check_type,
  email,
  full_name,
  positions,
  available,
  email_notifications_enabled,
  test_account
FROM workers 
WHERE LOWER(email) IN (LOWER('ZKyle86@gmail.com'), LOWER('zkylez86@gmail.com'));

-- 2. Check if your business account is set up correctly
SELECT 
  'Business Check' as check_type,
  email,
  business_name,
  email_notifications_enabled,
  test_account
FROM businesses 
WHERE LOWER(email) IN (LOWER('ZKyle86@gmail.com'), LOWER('zkylez86@gmail.com'));

-- 3. Check recent shifts
SELECT 
  id,
  position,
  shift_date,
  start_time,
  end_time,
  status,
  business_id,
  created_at
FROM shifts 
WHERE status = 'open'
ORDER BY created_at DESC 
LIMIT 5;

-- 4. Check if test mode is active (any test accounts exist)
SELECT 
  'Test Mode Check' as check_type,
  COUNT(*) FILTER (WHERE test_account = true) as test_workers,
  COUNT(*) FILTER (WHERE test_account = false) as regular_workers
FROM workers
UNION ALL
SELECT 
  'Test Mode Check' as check_type,
  COUNT(*) FILTER (WHERE test_account = true) as test_businesses,
  COUNT(*) FILTER (WHERE test_account = false) as regular_businesses
FROM businesses;
