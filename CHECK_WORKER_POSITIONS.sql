-- Check what positions your worker accounts have
-- This will show why the shift isn't appearing

-- Check worker positions
SELECT 
  id,
  email,
  full_name,
  positions,
  available
FROM workers 
WHERE LOWER(email) IN (LOWER('ZKyle86@gmail.com'), LOWER('zkylez86@gmail.com'));

-- If "Dishwasher" is not in the positions array, the shift won't show!

-- To add "Dishwasher" to your worker account:
-- UPDATE workers 
-- SET positions = array_append(positions, 'Dishwasher')
-- WHERE LOWER(email) = LOWER('your-worker-email@example.com')
-- AND NOT ('Dishwasher' = ANY(positions));

-- Or to set all positions (replace with your email):
-- UPDATE workers 
-- SET positions = ARRAY['Bartender', 'Server', 'Cook', 'Dishwasher', 'Host', 'Barback']
-- WHERE LOWER(email) = LOWER('your-worker-email@example.com');
