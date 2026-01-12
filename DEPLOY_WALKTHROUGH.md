# Step-by-Step: Deploy Email Notifications Edge Function

## Prerequisites
- ✅ You have a Resend API key
- ✅ Your Supabase project URL: `https://thugeejicutetunygyta.supabase.co`
- ⚠️ Need to install Supabase CLI

---

## Step 1: Install Supabase CLI

### Option A: Using npm (Recommended)
```bash
npm install -g supabase
```

### Option B: Using Scoop (Windows)
```bash
scoop bucket add supabase https://github.com/supabase/scoop-bucket.git
scoop install supabase
```

### Option C: Using Chocolatey (Windows)
```bash
choco install supabase
```

### Verify Installation
```bash
supabase --version
```
You should see a version number like `v1.x.x`

---

## Step 2: Login to Supabase

```bash
supabase login
```

This will open your browser to authenticate. After logging in, you'll be authenticated in the CLI.

---

## Step 3: Link Your Project

You need to link your local project to your Supabase project.

**Get your project reference ID:**
- Your project URL is: `https://thugeejicutetunygyta.supabase.co`
- The project ref is: `thugeejicutetunygyta`

**Link the project:**
```bash
cd C:\Users\zkyle\Documents\LastCallCursor
supabase link --project-ref thugeejicutetunygyta
```

You'll be prompted for your database password. If you don't remember it, you can reset it in the Supabase dashboard under Settings → Database.

---

## Step 4: Set Environment Variables (Secrets)

Set your Resend API key and email address:

```bash
supabase secrets set RESEND_API_KEY=your_resend_api_key_here
supabase secrets set FROM_EMAIL=notifications@yourdomain.com
```

**Important Notes:**
- Replace `your_resend_api_key_here` with your actual Resend API key
- For `FROM_EMAIL`, you have two options:
  - **If you verified a domain in Resend**: Use `notifications@yourdomain.com`
  - **If using Resend's test domain**: Use `onboarding@resend.dev` (for testing only)

**Example:**
```bash
supabase secrets set RESEND_API_KEY=re_1234567890abcdef
supabase secrets set FROM_EMAIL=onboarding@resend.dev
```

---

## Step 5: Deploy the Edge Function

Make sure you're in the project directory, then deploy:

```bash
supabase functions deploy send-shift-notifications
```

You should see output like:
```
Deploying function send-shift-notifications...
Function send-shift-notifications deployed successfully
```

---

## Step 6: Verify Deployment

Check that the function is deployed:

```bash
supabase functions list
```

You should see `send-shift-notifications` in the list.

---

## Step 7: Test the Function (Optional)

You can test the function manually:

```bash
supabase functions invoke send-shift-notifications --body '{"shift":{"id":"test","position":"Bartender","shift_date":"2024-01-15","start_time":"18:00","end_time":"22:00","hourly_rate":25,"tips_included":false,"age_requirement":"21","notes":"Test shift"},"business":{"id":"test","business_name":"Test Bar","address":"123 Test St"}}'
```

---

## Step 8: Check Logs (If Issues Occur)

If emails aren't sending, check the function logs:

```bash
supabase functions logs send-shift-notifications
```

This will show you any errors that occurred.

---

## Troubleshooting

### "Command not found: supabase"
- Make sure npm is installed: `npm --version`
- Try installing globally: `npm install -g supabase`
- Restart your terminal after installation

### "Project not found" or "Access denied"
- Make sure you're logged in: `supabase login`
- Verify the project ref is correct
- Check that you have access to the project in the Supabase dashboard

### "Invalid API key" or "Email sending failed"
- Double-check your Resend API key
- Verify the FROM_EMAIL matches a verified domain in Resend
- Check Resend dashboard for any errors

### "Function not found" after deployment
- Wait a few seconds and try again
- Check Supabase dashboard → Edge Functions to see if it appears there

---

## Next Steps

1. ✅ Run the database migration: `migration_add_email_notifications.sql`
2. ✅ Test by posting a shift as a business
3. ✅ Check that workers receive emails
4. ✅ Monitor logs if issues occur

---

## Quick Reference Commands

```bash
# Install CLI
npm install -g supabase

# Login
supabase login

# Link project
supabase link --project-ref thugeejicutetunygyta

# Set secrets
supabase secrets set RESEND_API_KEY=your_key
supabase secrets set FROM_EMAIL=your_email

# Deploy function
supabase functions deploy send-shift-notifications

# View logs
supabase functions logs send-shift-notifications

# List functions
supabase functions list
```
