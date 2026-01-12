# Quick Setup Guide - Email Notifications

## Current Status
✅ Supabase CLI installed and working (v2.67.1)
✅ Edge Function code ready
⏳ Need to set up API key and deploy

## Next Steps

### Option 1: Automated Setup (Recommended)

1. **Login to Supabase first:**
   ```powershell
   & "$env:USERPROFILE\Tools\supabase\supabase.exe" login
   ```

2. **Link your project:**
   ```powershell
   cd C:\Users\zkyle\Documents\LastCallCursor
   & "$env:USERPROFILE\Tools\supabase\supabase.exe" link --project-ref thugeejicutetunygyta
   ```
   (You'll need your database password - can reset in Supabase dashboard if needed)

3. **Run the setup script with your API key:**
   ```powershell
   .\setup-secrets.ps1 -ResendApiKey "your_api_key_here"
   ```

4. **Deploy the function:**
   ```powershell
   & "$env:USERPROFILE\Tools\supabase\supabase.exe" functions deploy send-shift-notifications
   ```

### Option 2: Manual Setup

If you prefer to do it step by step:

```powershell
# 1. Login
& "$env:USERPROFILE\Tools\supabase\supabase.exe" login

# 2. Link project
cd C:\Users\zkyle\Documents\LastCallCursor
& "$env:USERPROFILE\Tools\supabase\supabase.exe" link --project-ref thugeejicutetunygyta

# 3. Set API key (replace with your actual key)
& "$env:USERPROFILE\Tools\supabase\supabase.exe" secrets set RESEND_API_KEY=your_api_key_here

# 4. Set email address
& "$env:USERPROFILE\Tools\supabase\supabase.exe" secrets set FROM_EMAIL=onboarding@resend.dev

# 5. Deploy function
& "$env:USERPROFILE\Tools\supabase\supabase.exe" functions deploy send-shift-notifications
```

## After Setup

1. ✅ Run the database migration: `migration_add_email_notifications.sql`
2. ✅ Test by posting a shift as a business
3. ✅ Check that workers receive emails

---

**Ready to proceed?** Share your Resend API key and I'll help you set it up!
