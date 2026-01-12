# Fixing 403 Forbidden Errors

The 403 errors mean Resend is rejecting the API requests. This is usually due to:

## Possible Causes:

1. **Invalid API Key** - The RESEND_API_KEY might be wrong or expired
2. **Unverified Domain** - The FROM_EMAIL domain isn't verified in Resend
3. **API Key Permissions** - The API key doesn't have email sending permissions

## Step 1: Check Function Logs

1. Go to: https://supabase.com/dashboard/project/thugeejicutetunygyta/functions
2. Click on `send-shift-notifications`
3. Click "Logs" tab (NOT the general logs)
4. Look for:
   - "Found X worker(s) to notify"
   - "Failed to send email" errors
   - "RESEND_API_KEY not configured"

## Step 2: Verify Resend API Key

1. Go to: https://resend.com/api-keys
2. Check if your API key is active
3. Make sure it has "Send emails" permission

## Step 3: Check FROM_EMAIL Domain

The FROM_EMAIL is set to: `notifications@lastcallwork.com`

1. Go to: https://resend.com/domains
2. Check if `lastcallwork.com` is verified
3. If not, you need to either:
   - Verify the domain in Resend, OR
   - Use Resend's test domain: `onboarding@resend.dev`

## Step 4: Update FROM_EMAIL if Needed

If your domain isn't verified, update the secret:

```powershell
supabase secrets set FROM_EMAIL=onboarding@resend.dev
```

Then redeploy the function.

## Step 5: Verify Secrets Are Set

Check your secrets:
```powershell
supabase secrets list
```

Make sure:
- RESEND_API_KEY is set
- FROM_EMAIL is set (and domain is verified)
