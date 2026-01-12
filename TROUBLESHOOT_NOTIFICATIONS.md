# Troubleshooting: No Notifications Received

## Quick Checks

### 1. Check Browser Console
Open browser console (F12) and look for:
- ✅ "Notification function called" - means function was invoked
- ❌ "Notification service error" - means there's an error
- ❌ Any red error messages

### 2. Check Resend Dashboard
Go to: https://resend.com/emails
- See if emails were sent
- Check delivery status
- Look for any errors

### 3. Check Supabase Function Logs
Go to: https://supabase.com/dashboard/project/thugeejicutetunygyta/functions
- Click on `send-shift-notifications`
- View "Logs" tab
- Look for recent invocations and errors

### 4. Verify Worker Account Setup
Run this SQL to check:
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

**Required:**
- ✅ Position must match the shift (e.g., "Dishwasher")
- ✅ `available = true`
- ✅ `email_notifications_enabled = true`
- ✅ `test_account = true` (if test mode is active)

## Common Issues

### Issue 1: Function Not Being Called
**Symptom:** No "Notification function called" in console

**Fix:**
- Check browser console for errors
- Verify the shift was actually saved
- Try posting another shift

### Issue 2: Function Called But No Email
**Symptom:** Console shows "Notification function called" but no email

**Possible causes:**
- Worker doesn't have the position
- Worker not marked as available
- Email notifications disabled
- Test mode active but worker not marked as test account
- Resend API issue

**Fix:**
- Check Resend dashboard
- Verify worker account settings (run SQL above)
- Check function logs in Supabase

### Issue 3: Email Sent But Not Received
**Symptom:** Resend shows email sent, but not in inbox

**Fix:**
- Check spam folder
- Check "Promotions" tab in Gmail
- Verify email address is correct
- Check Resend delivery status

## Debug Steps

1. **Open browser console** (F12)
2. **Post a shift**
3. **Look for:**
   - "Notification function called" message
   - Any error messages
4. **Check Resend dashboard** for email status
5. **Check Supabase function logs** for errors

## Test Manually

You can test the function directly:

1. Go to Supabase Dashboard → Functions
2. Click on `send-shift-notifications`
3. Use "Invoke" tab to test with sample data
4. Check logs for results

Let me know what you see in the browser console or Resend dashboard!
