# Web Push Setup - Notifications When Browser is Closed

## Current Status

✅ Service Worker is set up
✅ Basic notifications work when browser is open
⚠️ Need Web Push API for "browser closed" notifications

## What's Needed

For true push notifications when the browser is closed, we need:

1. **VAPID Keys** (Voluntary Application Server Identification)
   - Public key for the browser
   - Private key for the server
   - Free to generate

2. **Push Subscription**
   - User subscribes to push notifications
   - Subscription stored in database
   - Backend sends push messages

3. **Backend Push Service**
   - Send push messages when events happen
   - Can use Supabase Edge Function or external service

## Implementation Options

### Option 1: Supabase + Web Push (Recommended)
- Use Supabase Edge Function to send push
- Store subscriptions in database
- Free tier available

### Option 2: Firebase Cloud Messaging (FCM)
- Very reliable
- Free tier: Unlimited
- Requires Firebase account

### Option 3: Simple Polling (Current)
- Works but requires browser to be open
- No true "browser closed" support
- Simplest but limited

## Next Steps

1. Generate VAPID keys
2. Update code with public key
3. Create Edge Function to send push
4. Test push notifications

Would you like me to implement Web Push API with Supabase?
