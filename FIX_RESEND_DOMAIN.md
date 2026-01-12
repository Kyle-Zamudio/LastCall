# Fix Resend Domain Issue

## The Problem
The `resend.dev` domain can only send to **your own email address**. To send to other recipients (like your test accounts), you need to verify your own domain.

## Solution Options

### Option 1: Verify Your Domain (Recommended for Production)
1. Go to: https://resend.com/domains
2. Click "Add Domain"
3. Enter: `lastcallwork.com` (or your domain)
4. Add the DNS records Resend provides to your domain
5. Wait for verification (usually a few minutes)
6. Once verified, emails will work!

### Option 2: Use Your Verified Email (Quick Test)
If you have a verified email in Resend:
1. Go to: https://resend.com/emails
2. Check what verified emails you have
3. Update the FROM_EMAIL secret to use that email

### Option 3: Verify Domain Now
If you own `lastcallwork.com`:
1. Go to Resend → Domains
2. Add `lastcallwork.com`
3. Add the DNS records
4. Wait for verification
5. Update FROM_EMAIL to use your domain

## Current FROM_EMAIL
Check what's currently set:
```powershell
supabase secrets list
```

## After Domain is Verified
Update the secret:
```powershell
supabase secrets set FROM_EMAIL=notifications@lastcallwork.com
```

Then redeploy:
```powershell
supabase functions deploy send-shift-notifications
supabase functions deploy notify-business-interest
```
