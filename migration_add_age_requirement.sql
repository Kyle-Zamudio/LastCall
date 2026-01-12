-- Migration: Add age_requirement column to shifts table
-- This allows businesses to specify if a shift requires workers 18+ or 21+

ALTER TABLE shifts
ADD COLUMN IF NOT EXISTS age_requirement TEXT DEFAULT '18';

-- Update existing shifts to have 18+ as default (all existing shifts should allow 18+)
UPDATE shifts
SET age_requirement = '18'
WHERE age_requirement IS NULL;

-- Add a check constraint to ensure only valid values ('18' or '21')
ALTER TABLE shifts
ADD CONSTRAINT check_age_requirement CHECK (age_requirement IN ('18', '21'));

