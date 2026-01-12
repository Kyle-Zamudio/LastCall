-- Run all email notification migrations
-- This will add email_notifications_enabled to both workers and businesses tables

-- 1. Add to workers table
ALTER TABLE workers
ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;

COMMENT ON COLUMN workers.email_notifications_enabled IS 'Whether the worker wants to receive email notifications when new shifts matching their positions are posted';

UPDATE workers 
SET email_notifications_enabled = true 
WHERE email_notifications_enabled IS NULL;

-- 2. Add to businesses table
ALTER TABLE businesses
ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;

COMMENT ON COLUMN businesses.email_notifications_enabled IS 'Whether the business wants to receive email notifications when workers express interest in their shifts';

UPDATE businesses 
SET email_notifications_enabled = true 
WHERE email_notifications_enabled IS NULL;

-- 3. Verify both columns exist
SELECT 
  'workers' as table_name,
  column_name, 
  data_type, 
  column_default
FROM information_schema.columns 
WHERE table_name = 'workers' 
AND column_name = 'email_notifications_enabled'
UNION ALL
SELECT 
  'businesses' as table_name,
  column_name, 
  data_type, 
  column_default
FROM information_schema.columns 
WHERE table_name = 'businesses' 
AND column_name = 'email_notifications_enabled';
