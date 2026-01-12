-- Enable email notifications for all existing users
-- Run this to auto-enable email notifications for users who registered before this feature

-- Enable for all existing workers
UPDATE workers 
SET email_notifications_enabled = true 
WHERE email_notifications_enabled IS NULL OR email_notifications_enabled = false;

-- Enable for all existing businesses
UPDATE businesses 
SET email_notifications_enabled = true 
WHERE email_notifications_enabled IS NULL OR email_notifications_enabled = false;

-- Verify the update
SELECT 
  'Workers' as account_type,
  COUNT(*) FILTER (WHERE email_notifications_enabled = true) as enabled,
  COUNT(*) FILTER (WHERE email_notifications_enabled = false) as disabled
FROM workers
UNION ALL
SELECT 
  'Businesses' as account_type,
  COUNT(*) FILTER (WHERE email_notifications_enabled = true) as enabled,
  COUNT(*) FILTER (WHERE email_notifications_enabled = false) as disabled
FROM businesses;
