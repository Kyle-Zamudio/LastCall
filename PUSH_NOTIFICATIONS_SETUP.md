# Push Notifications Setup - Complete Guide

## Step 1: Generate VAPID Keys

1. Go to: https://web-push-codelab.glitch.me/
2. Click "Generate VAPID Keys"
3. Copy both keys:
   - **Public Key** (starts with `B...`)
   - **Private Key** (long string)

## Step 2: Set VAPID Keys

### In Supabase Secrets:
```powershell
supabase secrets set VAPID_PUBLIC_KEY=your_public_key_here
supabase secrets set VAPID_PRIVATE_KEY=your_private_key_here
supabase secrets set VAPID_SUBJECT=mailto:notifications@lastcall.work
```

### In index.html:
Replace `YOUR_VAPID_PUBLIC_KEY` with your actual public key:
```javascript
const VAPID_PUBLIC_KEY = 'your_public_key_here';
```

## Step 3: Run Database Migration

Run in Supabase SQL Editor:
```sql
-- Add push_subscription column
ALTER TABLE workers
ADD COLUMN IF NOT EXISTS push_subscription JSONB;

ALTER TABLE businesses
ADD COLUMN IF NOT EXISTS push_subscription JSONB;
```

Or run: `migration_add_push_subscription.sql`

## Step 4: Deploy Edge Function

```powershell
supabase functions deploy send-push-notification
```

## Step 5: Test

1. Log in as a user
2. You'll be prompted to enable push notifications
3. Click "Allow"
4. Post a shift (or express interest)
5. You should receive a push notification even if browser is closed!

## How It Works

1. **User subscribes**: Browser creates push subscription
2. **Subscription saved**: Stored in database (workers/businesses table)
3. **Event happens**: Shift posted or interest expressed
4. **Edge Function called**: Sends push notification via web-push library
5. **Notification appears**: Even when browser is closed!

## Cost: $0

- Web Push API: Free
- VAPID keys: Free
- Supabase Edge Functions: Free (500K/month)
- Total: $0

## Troubleshooting

- **No notification**: Check browser console for errors
- **Subscription failed**: Verify VAPID keys are set correctly
- **Not working when closed**: Make sure VAPID keys are configured
