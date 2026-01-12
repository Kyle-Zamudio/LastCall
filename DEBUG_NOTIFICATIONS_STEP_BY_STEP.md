# Step-by-Step Notification Debugging

## Step 1: Check Browser Console
1. Open browser console (F12)
2. Post a shift
3. Look for:
   - ✅ "Notification function called" - function was invoked
   - ❌ Any red errors

## Step 2: Check Supabase Function Logs
1. Go to: https://supabase.com/dashboard/project/thugeejicutetunygyta/functions
2. Click on `send-shift-notifications`
3. Click "Logs" tab
4. Look for recent invocations
5. Check for errors or "No workers to notify" messages

## Step 3: Check Resend Dashboard
1. Go to: https://resend.com/emails
2. Check if any emails were sent
3. Look at delivery status

## Step 4: Verify Worker Account
Run this SQL:
```sql
SELECT 
  email,
  positions,
  available,
  email_notifications_enabled,
  test_account
FROM workers 
WHERE LOWER(email) IN (LOWER('ZKyle86@gmail.com'), LOWER('zkylez86@gmail.com'));
```

Must have:
- ✅ Position matches shift (e.g., "Bartender")
- ✅ available = true
- ✅ email_notifications_enabled = true
- ✅ test_account = true

## Step 5: Test Function Manually
1. Go to Supabase Dashboard → Functions
2. Click `send-shift-notifications`
3. Use "Invoke" tab
4. Test with sample data
