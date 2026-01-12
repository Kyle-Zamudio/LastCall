-- Migration: Add email_notifications_enabled column to businesses table
-- Run this in Supabase SQL Editor to fix the error

ALTER TABLE businesses
ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;

-- Add comment to document the column
COMMENT ON COLUMN businesses.email_notifications_enabled IS 'Whether the business wants to receive email notifications when workers express interest in their shifts';

-- Set default to true for existing businesses
UPDATE businesses 
SET email_notifications_enabled = true 
WHERE email_notifications_enabled IS NULL;

-- Verify the column was added
SELECT 
  column_name, 
  data_type, 
  column_default
FROM information_schema.columns 
WHERE table_name = 'businesses' 
AND column_name = 'email_notifications_enabled';
