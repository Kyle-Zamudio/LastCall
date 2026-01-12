# Setting Up Your Resend API Key

## Quick Setup Steps

Once Supabase CLI is working, follow these steps:

### Step 1: Login to Supabase
```bash
supabase login
```
This will open your browser to authenticate.

### Step 2: Link Your Project
```bash
cd C:\Users\zkyle\Documents\LastCallCursor
supabase link --project-ref thugeejicutetunygyta
```
You'll need your database password (can be reset in Supabase dashboard if needed).

### Step 3: Set Your Resend API Key
```bash
supabase secrets set RESEND_API_KEY=your_api_key_here
```

Replace `your_api_key_here` with your actual Resend API key.

### Step 4: Set Your Email Address
```bash
supabase secrets set FROM_EMAIL=onboarding@resend.dev
```

**Note:** 
- For testing: Use `onboarding@resend.dev` (Resend's test domain)
- For production: Use your verified domain email like `notifications@yourdomain.com`

### Step 5: Deploy the Function
```bash
supabase functions deploy send-shift-notifications
```

### Step 6: Verify
```bash
supabase functions list
```

You should see `send-shift-notifications` in the list.

---

## Ready to Set Your API Key?

When you're ready, I can help you run these commands with your actual API key. Just paste it when prompted, and I'll set it up securely using Supabase's secrets management (it won't be stored in files or visible in code).
