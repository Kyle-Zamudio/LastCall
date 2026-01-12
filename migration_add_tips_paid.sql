-- Migration: Add tips_paid column to shifts table
-- Run this in your Supabase SQL editor if you already ran the previous migration

ALTER TABLE shifts 
ADD COLUMN IF NOT EXISTS tips_paid DECIMAL(10,2);

