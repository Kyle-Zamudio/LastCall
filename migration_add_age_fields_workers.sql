-- Migration: Add age verification columns to workers table
-- This allows workers to specify if they are 18+ and 21+

ALTER TABLE workers
ADD COLUMN IF NOT EXISTS age_18_plus BOOLEAN DEFAULT false;

ALTER TABLE workers
ADD COLUMN IF NOT EXISTS age_21_plus BOOLEAN DEFAULT false;

-- Note: Existing workers will have both set to false by default
-- They will need to update their profile to set these values

