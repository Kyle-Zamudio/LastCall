-- Fix worker positions to include Dishwasher
-- This will make the Dishwasher shift visible to your worker accounts

-- Add Dishwasher to both worker accounts if not already present
UPDATE workers 
SET positions = CASE 
  WHEN NOT ('Dishwasher' = ANY(positions)) THEN array_append(positions, 'Dishwasher')
  ELSE positions
END
WHERE LOWER(email) IN (LOWER('ZKyle86@gmail.com'), LOWER('zkylez86@gmail.com'));

-- Verify the update
SELECT 
  email,
  full_name,
  positions,
  available
FROM workers 
WHERE LOWER(email) IN (LOWER('ZKyle86@gmail.com'), LOWER('zkylez86@gmail.com'));

-- Expected: Both accounts should now have 'Dishwasher' in their positions array
