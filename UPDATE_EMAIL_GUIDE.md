# How to Update Your Email Address

If you're getting verification codes sent to an old email you no longer have access to, here's how to fix it:

## 1. Supabase Account Email

If the verification is from Supabase:

1. **Go to Supabase Dashboard**: https://supabase.com/dashboard
2. **Try to log in** with your current email
3. **If you can't access the account**:
   - Go to: https://supabase.com/dashboard/account
   - Click on your profile → Account Settings
   - Update your email address
   - You may need to verify the new email

**Alternative**: If you can't access the account at all:
- Contact Supabase support: support@supabase.com
- Explain you need to change your email because you no longer have access to the old one

## 2. GitHub Account Email

If the verification is from GitHub:

1. **Go to GitHub**: https://github.com/settings/emails
2. **Add your new email** to your account
3. **Verify the new email** (check your inbox)
4. **Set it as primary** if needed
5. **Remove the old email** if you want

**If you can't log in**:
- Go to: https://github.com/login
- Click "Forgot password?"
- Use account recovery options

## 3. Resend Account Email

If the verification is from Resend:

1. **Go to Resend**: https://resend.com/login
2. **Try logging in** with your current email
3. **If you can't access**:
   - Go to: https://resend.com/forgot-password
   - Or contact support: support@resend.com

## 4. Supabase CLI Login Issue

If you're trying to run `supabase login` and it's asking for verification:

**Option A: Use Access Token Instead**
1. Go to Supabase Dashboard → Account Settings
2. Generate an Access Token
3. Use it instead of login:
   ```powershell
   $env:SUPABASE_ACCESS_TOKEN="your_token_here"
   ```

**Option B: Update Email First**
1. Update your Supabase account email (see #1 above)
2. Then try `supabase login` again

## Quick Fix: Check Which Service

The email domain `@volantco.com` suggests this might be:
- An old work email you used to sign up
- A Supabase account email
- A GitHub account email

**To identify which service:**
- Check the "From" address in the email (if you can see it)
- Check the verification link URL
- Supabase emails usually come from `noreply@supabase.com`
- GitHub emails come from `noreply@github.com`

## Need Help?

If you can't figure out which service it is, try:
1. Check your browser history for recent logins
2. Check which service you were trying to use when the verification appeared
3. Contact support for the service you think it is
