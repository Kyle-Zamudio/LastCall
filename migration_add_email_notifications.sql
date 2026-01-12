-- Migration: Add email notification preferences to workers table
-- This allows workers to opt-in/opt-out of email notifications for new shifts

ALTER TABLE workers
ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;

-- Add comment to document the column
COMMENT ON COLUMN workers.email_notifications_enabled IS 'Whether the worker wants to receive email notifications when new shifts matching their positions are posted';

-- Note: Default to true so existing workers get notifications
-- Workers can opt-out in their profile settings
