-- Ensure all existing users have email notifications enabled
-- Run this in Supabase SQL Editor to enable notifications for all existing users

-- Enable email notifications for all existing workers (if not already enabled)
UPDATE workers 
SET email_notifications_enabled = true 
WHERE email_notifications_enabled IS NULL OR email_notifications_enabled = false;

-- Enable email notifications for all existing businesses (if not already enabled)
UPDATE businesses 
SET email_notifications_enabled = true 
WHERE email_notifications_enabled IS NULL OR email_notifications_enabled = false;

-- Verify the update
SELECT 
  'Workers' as table_name,
  COUNT(*) as total_users,
  COUNT(*) FILTER (WHERE email_notifications_enabled = true) as notifications_enabled,
  COUNT(*) FILTER (WHERE email_notifications_enabled = false) as notifications_disabled,
  COUNT(*) FILTER (WHERE email_notifications_enabled IS NULL) as notifications_null
FROM workers
UNION ALL
SELECT 
  'Businesses' as table_name,
  COUNT(*) as total_users,
  COUNT(*) FILTER (WHERE email_notifications_enabled = true) as notifications_enabled,
  COUNT(*) FILTER (WHERE email_notifications_enabled = false) as notifications_disabled,
  COUNT(*) FILTER (WHERE email_notifications_enabled IS NULL) as notifications_null
FROM businesses;
