# Notification Timing & Troubleshooting

## Expected Delivery Times

### Email Notifications (via Resend)
- **Normal**: 1-5 seconds
- **Sometimes**: Up to 30 seconds
- **Rare**: Up to 1 minute (if Resend queue is busy)

### Push Notifications (Browser)
- **Instant**: 1-2 seconds when browser is open
- **When browser closed**: Appears when browser is opened again
- **Mobile**: Same timing, works even when browser is closed

## What Happens When You Post a Shift

1. **Shift is saved** to database (instant)
2. **Edge Function is triggered** (fire and forget - non-blocking)
3. **Function queries** for matching workers (1-2 seconds)
4. **Emails are sent** via Resend API (1-5 seconds)
5. **Push notifications** appear (1-2 seconds if browser open)

**Total time: Usually 3-10 seconds from posting to receiving**

## How to Check If It's Working

### Check Email Delivery
1. **Check your inbox** (and spam folder)
2. **Check Resend Dashboard**: https://resend.com/emails
   - Go to "Emails" section
   - You'll see delivery status for each email

### Check Push Notifications
1. **Make sure notifications are enabled**:
   - Browser should show permission granted
   - Check browser settings if needed
2. **Keep browser open** for fastest delivery
3. **Check browser console** (F12) for any errors

### Check Edge Function Logs
Go to Supabase Dashboard:
- https://supabase.com/dashboard/project/thugeejicutetunygyta/functions
- Click on the function name
- View "Logs" tab
- Look for any errors

## Troubleshooting

### No Email Received After 1 Minute?

1. **Check Resend Dashboard**:
   - Go to https://resend.com/emails
   - See if email was sent
   - Check delivery status

2. **Check Spam Folder**:
   - Emails might be filtered
   - Check "Promotions" or "Updates" tabs in Gmail

3. **Verify Test Mode**:
   - Make sure your account is marked as test_account = true
   - Run: `SELECT email, test_account FROM workers WHERE email = 'your-email@example.com';`

4. **Check Function Logs**:
   - Supabase Dashboard → Functions → Logs
   - Look for errors

### No Push Notification?

1. **Check Permission**:
   - Browser should have asked for notification permission
   - If denied, go to browser settings and enable

2. **Check Service Worker**:
   - Open browser console (F12)
   - Look for "Service Worker registered" message
   - Check for any errors

3. **Try Hard Refresh**:
   - Ctrl + F5 (or Cmd + Shift + R on Mac)
   - This reloads the Service Worker

## Quick Test

To test if notifications are working:

1. **Post a shift** as a business (using your test account)
2. **Wait 10 seconds**
3. **Check**:
   - Email inbox (and spam)
   - Push notification (if browser open)
   - Resend dashboard for email status

If nothing after 1 minute, check the logs!
