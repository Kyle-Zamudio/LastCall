-- Test if workers match the criteria for a shift
-- Replace 'Bartender' with the position you're posting

-- Check workers who should receive notifications for a Bartender shift
SELECT 
  id,
  email,
  full_name,
  positions,
  available,
  email_notifications_enabled,
  test_account,
  -- Check if they match all criteria
  CASE 
    WHEN available = true THEN '✅ Available'
    ELSE '❌ Not Available'
  END as availability_status,
  CASE 
    WHEN email_notifications_enabled = true THEN '✅ Notifications Enabled'
    ELSE '❌ Notifications Disabled'
  END as notification_status,
  CASE 
    WHEN test_account = true THEN '✅ Test Account'
    ELSE '❌ Not Test Account'
  END as test_status,
  CASE 
    WHEN 'Bartender' = ANY(positions) THEN '✅ Has Position'
    ELSE '❌ Missing Position'
  END as position_match
FROM workers
WHERE 
  available = true
  AND email_notifications_enabled = true
  AND test_account = true
  AND 'Bartender' = ANY(positions);

-- Expected: Should show your worker accounts if they match all criteria
