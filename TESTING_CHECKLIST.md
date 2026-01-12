# Testing Checklist - Notifications

## Before Testing

### Worker Account Setup
✅ **Positions**: Make sure your worker account has the position you're posting (e.g., "Dishwasher")
✅ **Email**: Verify email address is correct
✅ **Email Notifications**: Should be enabled (default)
✅ **Available**: Should be set to "Available" (green toggle)
✅ **Test Account**: Should be marked as `test_account = true` in database

### Business Account Setup
✅ **Email**: Verify email address is correct
✅ **Email Notifications**: Should be enabled (default)
✅ **Test Account**: Should be marked as `test_account = true` in database

## Testing Steps

### Test 1: Worker Sees Shift
1. **Post a shift** as business (e.g., "Dishwasher")
2. **Log in as worker** (with "Dishwasher" in positions)
3. **Check "Available" tab** - shift should appear
4. **Wait 10 seconds** - check for:
   - ✅ Email notification
   - ✅ Push notification (if browser open)

### Test 2: Business Gets Interest Notification
1. **Log in as worker**
2. **Click "I'm Interested"** on a shift
3. **Log in as business** (owner of that shift)
4. **Wait 10 seconds** - check for:
   - ✅ Email notification
   - ✅ Push notification (if browser open)

## Common Issues

### Shift Not Showing?
- ❌ Worker doesn't have the position selected
- ❌ Shift date is in the past
- ❌ Shift has already ended (same day, time passed)
- ❌ Worker is not marked as "Available"

### No Email Received?
- ❌ Check spam folder
- ❌ Verify email address in account
- ❌ Check Resend dashboard: https://resend.com/emails
- ❌ Verify test_account = true (test mode active)
- ❌ Check email_notifications_enabled = true

### No Push Notification?
- ❌ Browser notification permission not granted
- ❌ Service Worker not registered (check console F12)
- ❌ Browser closed (notifications appear when reopened)

## Quick SQL Checks

```sql
-- Check worker positions
SELECT email, positions, available, email_notifications_enabled, test_account 
FROM workers 
WHERE LOWER(email) IN (LOWER('ZKyle86@gmail.com'), LOWER('zkylez86@gmail.com'));

-- Check business settings
SELECT email, business_name, email_notifications_enabled, test_account 
FROM businesses 
WHERE LOWER(email) IN (LOWER('ZKyle86@gmail.com'), LOWER('zkylez86@gmail.com'));

-- Check recent shifts
SELECT id, position, shift_date, start_time, end_time, status, business_id
FROM shifts 
WHERE status = 'open' 
ORDER BY created_at DESC 
LIMIT 5;
```

## After You Update Positions

1. **Refresh the page** (hard refresh: Ctrl + F5)
2. **Check "Available" tab** - shift should appear
3. **Post another shift** if needed
4. **Check notifications** within 10 seconds

Good luck testing! 🚀
