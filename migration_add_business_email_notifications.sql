-- Migration: Add email notification preferences to businesses table
-- This allows businesses to opt-in/opt-out of email notifications when workers express interest

ALTER TABLE businesses
ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;

-- Add comment to document the column
COMMENT ON COLUMN businesses.email_notifications_enabled IS 'Whether the business wants to receive email notifications when workers express interest in their shifts';

-- Note: Default to true so existing businesses get notifications
-- Businesses can opt-out in their profile settings
