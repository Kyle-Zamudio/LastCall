-- Check if email columns exist in your tables
-- Run this in Supabase SQL Editor to verify

-- Check workers table
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'workers' 
AND column_name IN ('email', 'email_notifications_enabled')
ORDER BY column_name;

-- Check businesses table
SELECT 
    column_name, 
    data_type, 
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'businesses' 
AND column_name IN ('email', 'email_notifications_enabled')
ORDER BY column_name;
