# Test Mode Setup - Prevent Notifying Real Users

## What I've Done

✅ Created migration to add `test_account` column
✅ Updated both Edge Functions to respect test mode
✅ Created SQL scripts to mark your accounts as test accounts

## How Test Mode Works

**Automatic Detection:**
- If ANY account has `test_account = true`, test mode is automatically enabled
- In test mode: Only test accounts receive notifications
- All other users are skipped (no notifications sent)

**Normal Mode:**
- If NO accounts have `test_account = true`, everyone gets notifications normally

## Setup Steps

### Step 1: Run the Migration

In Supabase SQL Editor, run:
```sql
-- Add test_account column to workers table
ALTER TABLE workers
ADD COLUMN IF NOT EXISTS test_account BOOLEAN DEFAULT false;

-- Add test_account column to businesses table
ALTER TABLE businesses
ADD COLUMN IF NOT EXISTS test_account BOOLEAN DEFAULT false;
```

Or run the file: `migration_add_test_accounts.sql`

### Step 2: Mark Your Accounts as Test Accounts

Replace the email addresses in `MARK_MY_TEST_ACCOUNTS.sql` with your actual emails, then run:

```sql
-- Mark your worker test accounts
UPDATE workers 
SET test_account = true 
WHERE email IN (
  'your-worker-email-1@example.com',
  'your-worker-email-2@example.com'
);

-- Mark your business test accounts
UPDATE businesses 
SET test_account = true 
WHERE email IN (
  'your-business-email-1@example.com',
  'your-business-email-2@example.com'
);
```

### Step 3: Verify Test Mode is Active

```sql
-- Check test accounts
SELECT id, email, full_name, test_account FROM workers WHERE test_account = true;
SELECT id, email, business_name, test_account FROM businesses WHERE test_account = true;
```

## What Happens Now

✅ **Test Mode Active:**
- Only your test accounts receive email notifications
- All other users are skipped
- You can test freely without bothering real users

✅ **Edge Functions Updated:**
- Both functions check for test mode
- Automatically filter to test accounts only

## To Disable Test Mode (Go Live)

When you're ready to send to everyone:

```sql
-- Remove test account flags
UPDATE workers SET test_account = false;
UPDATE businesses SET test_account = false;
```

Once all test_account flags are false, notifications will go to everyone again.

## Next Steps

1. **Provide your email addresses** and I'll create the exact SQL for you
2. **Run the migration** in Supabase SQL Editor
3. **Mark your accounts** as test accounts
4. **Test notifications** - only your accounts will receive them!

What are your test account email addresses?
