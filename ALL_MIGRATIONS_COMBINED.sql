-- Combined Migration: Add Email Notification Preferences
-- This adds the notification preference columns (email column already exists)

-- For Workers
ALTER TABLE workers
ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;

COMMENT ON COLUMN workers.email_notifications_enabled IS 'Whether the worker wants to receive email notifications when new shifts matching their positions are posted';

-- For Businesses
ALTER TABLE businesses
ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;

COMMENT ON COLUMN businesses.email_notifications_enabled IS 'Whether the business wants to receive email notifications when workers express interest in their shifts';

-- Note: The 'email' column already exists in both tables (used for login)
-- This migration only adds the notification preference toggle
