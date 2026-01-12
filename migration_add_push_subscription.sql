-- Migration: Add push_subscription column to workers and businesses tables
-- This stores Web Push API subscriptions for browser-closed notifications

-- Add push_subscription column to workers table
ALTER TABLE workers
ADD COLUMN IF NOT EXISTS push_subscription JSONB;

-- Add push_subscription column to businesses table
ALTER TABLE businesses
ADD COLUMN IF NOT EXISTS push_subscription JSONB;

-- Add comments
COMMENT ON COLUMN workers.push_subscription IS 'Web Push API subscription for receiving notifications when browser is closed';
COMMENT ON COLUMN businesses.push_subscription IS 'Web Push API subscription for receiving notifications when browser is closed';
