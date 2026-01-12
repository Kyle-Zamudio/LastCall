# How to Run Database Migrations in Supabase

## Quick Steps

1. **Go to your Supabase Dashboard:**
   - https://supabase.com/dashboard/project/thugeejicutetunygyta

2. **Navigate to SQL Editor:**
   - Click "SQL Editor" in the left sidebar
   - Or go directly to: https://supabase.com/dashboard/project/thugeejicutetunygyta/sql

3. **Run the Migrations:**

   **For Workers (Email Notifications):**
   ```sql
   ALTER TABLE workers
   ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;
   ```

   **For Businesses (Email Notifications):**
   ```sql
   ALTER TABLE businesses
   ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;
   ```

4. **Or Run the Migration Files:**
   - Copy the contents of `migration_add_email_notifications.sql`
   - Paste into SQL Editor
   - Click "Run"
   - Repeat for `migration_add_business_email_notifications.sql`

## Verify It Worked

After running, check the tables:

1. Go to **Table Editor** in the left sidebar
2. Click on `workers` table
3. Check if `email_notifications_enabled` column exists
4. Do the same for `businesses` table

## Need Help?

If you want me to:
- Create a combined migration script
- Check your current database structure
- Help troubleshoot any errors

Just let me know what you see or what error you're getting!
