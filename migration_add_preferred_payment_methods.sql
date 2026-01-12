-- Migration: Add preferred_payment_methods column to workers table
-- This allows workers to specify their preferred payment methods (Cash, Venmo, PayPal, etc.)

-- Add the preferred_payment_methods column as a TEXT array
-- This allows storing multiple payment method preferences per worker
ALTER TABLE workers
ADD COLUMN IF NOT EXISTS preferred_payment_methods TEXT[] DEFAULT '{}';

-- Add a comment to document the column
COMMENT ON COLUMN workers.preferred_payment_methods IS 'Array of preferred payment methods (e.g., ["Venmo", "Cash", "PayPal"])';

-- Optional: Create an index if you plan to query by payment methods frequently
-- CREATE INDEX IF NOT EXISTS idx_workers_preferred_payment_methods 
-- ON workers USING GIN (preferred_payment_methods);

