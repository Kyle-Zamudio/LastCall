-- Migration: Add subscription and payment method fields to businesses table
-- Run this when you're ready to implement monthly subscriptions
-- This allows businesses to add/update payment methods without account deletion

ALTER TABLE businesses
ADD COLUMN IF NOT EXISTS subscription_status TEXT DEFAULT 'free', -- 'free', 'active', 'cancelled', 'past_due'
ADD COLUMN IF NOT EXISTS subscription_plan TEXT, -- 'monthly', 'annual', etc.
ADD COLUMN IF NOT EXISTS subscription_start_date DATE,
ADD COLUMN IF NOT EXISTS subscription_end_date DATE,
ADD COLUMN IF NOT EXISTS payment_method_id TEXT, -- ID from your payment processor (Stripe, etc.)
ADD COLUMN IF NOT EXISTS payment_method_type TEXT, -- 'card', 'bank_account', etc.
ADD COLUMN IF NOT EXISTS payment_method_last4 TEXT, -- Last 4 digits of card/account
ADD COLUMN IF NOT EXISTS payment_method_brand TEXT, -- 'visa', 'mastercard', etc.
ADD COLUMN IF NOT EXISTS billing_email TEXT; -- Email for billing notifications

-- Add index for faster subscription queries
CREATE INDEX IF NOT EXISTS idx_businesses_subscription_status ON businesses(subscription_status);
CREATE INDEX IF NOT EXISTS idx_businesses_subscription_end_date ON businesses(subscription_end_date);

