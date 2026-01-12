# Quick Start: Push Notifications

## What's Done ✅

- ✅ Service Worker updated
- ✅ Push subscription code in frontend
- ✅ Edge Function created (`send-push-notification`)
- ✅ Existing functions updated to send push notifications
- ✅ All functions deployed

## What You Need to Do

### Step 1: Generate VAPID Keys (2 minutes)

1. Go to: https://web-push-codelab.glitch.me/
2. Click "Generate VAPID Keys"
3. Copy both keys

### Step 2: Set VAPID Keys in Supabase

```powershell
supabase secrets set VAPID_PUBLIC_KEY=your_public_key_here
supabase secrets set VAPID_PRIVATE_KEY=your_private_key_here
supabase secrets set VAPID_SUBJECT=mailto:notifications@lastcall.work
```

### Step 3: Update index.html

Find this line (around line 131):
```javascript
const VAPID_PUBLIC_KEY = 'YOUR_VAPID_PUBLIC_KEY';
```

Replace with your actual public key:
```javascript
const VAPID_PUBLIC_KEY = 'your_public_key_here';
```

### Step 4: Run Database Migration

Run in Supabase SQL Editor:
```sql
ALTER TABLE workers ADD COLUMN IF NOT EXISTS push_subscription JSONB;
ALTER TABLE businesses ADD COLUMN IF NOT EXISTS push_subscription JSONB;
```

Or run: `migration_add_push_subscription.sql`

## That's It! 🎉

After these 4 steps:
- Users will be prompted to enable push notifications
- Notifications work when browser is closed
- Works on mobile and desktop
- **Cost: $0**

## Test It

1. Log in as a user
2. You'll be prompted to enable push notifications
3. Click "Allow"
4. Post a shift (or express interest)
5. Close your browser
6. You should still receive the notification!
