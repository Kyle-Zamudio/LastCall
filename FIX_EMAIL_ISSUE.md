# Fix: Can't Access Verification Email

You're getting verification codes sent to an old work email (`@volantco.com`) that you no longer have access to.

## Quick Fix: Use Access Token Instead

Instead of using `supabase login`, use an access token:

### Step 1: Get Your Supabase Access Token

1. **Go to Supabase Dashboard**: https://supabase.com/dashboard
2. **Click your profile icon** (top right)
3. **Go to "Access Tokens"** or "Account Settings"
4. **Generate a new token** (or copy existing one)
5. **Copy the token**

### Step 2: Set the Token as Environment Variable

**In PowerShell:**
```powershell
$env:SUPABASE_ACCESS_TOKEN="your_token_here"
```

**To make it permanent (for current session):**
```powershell
[Environment]::SetEnvironmentVariable("SUPABASE_ACCESS_TOKEN", "your_token_here", "User")
```

### Step 3: Verify It Works

```powershell
& "$env:USERPROFILE\Tools\supabase\supabase.exe" projects list
```

If this works, you're all set! You can now use Supabase CLI without needing to log in.

---

## Alternative: Update Your Supabase Account Email

If you want to fix the root cause:

1. **Try logging into Supabase Dashboard** with your current email:
   - Go to: https://supabase.com/dashboard
   - Try logging in with `lastcallwork@gmail.com` (or whatever email you use now)

2. **If you can log in**:
   - Go to Account Settings
   - Update your email address
   - Verify the new email

3. **If you can't log in** (because it's tied to the old email):
   - Contact Supabase Support: support@supabase.com
   - Explain: "I need to change my account email because I no longer have access to the old one (@volantco.com)"
   - They can help you recover/update the account

---

## For Future Reference

Once you have the access token set, you don't need to run `supabase login` anymore. The token will be used automatically.
