-- Migration: Add payment tracking fields to shifts table
-- Run this in your Supabase SQL editor

ALTER TABLE shifts 
ADD COLUMN IF NOT EXISTS completed BOOLEAN DEFAULT false,
ADD COLUMN IF NOT EXISTS payment_method TEXT,
ADD COLUMN IF NOT EXISTS amount_paid DECIMAL(10,2),
ADD COLUMN IF NOT EXISTS tips_paid DECIMAL(10,2),
ADD COLUMN IF NOT EXISTS payment_notes TEXT;

-- Add index for faster queries on completed shifts
CREATE INDEX IF NOT EXISTS idx_shifts_completed ON shifts(completed);
CREATE INDEX IF NOT EXISTS idx_shifts_business_completed ON shifts(business_id, completed);

