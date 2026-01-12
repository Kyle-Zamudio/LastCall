# Where to Find Your API Keys

## 1. Resend API Key (For Email Notifications) ⭐ **THIS IS WHAT WE NEED**

1. Go to https://resend.com
2. Sign in to your Resend account
3. Go to **API Keys** in the left sidebar
4. Click **Create API Key**
5. Give it a name (e.g., "LastCall Notifications")
6. Copy the API key (it starts with `re_` and looks like: `re_1234567890abcdef...`)

**This is the key you'll share with me to set up email notifications.**

---

## 2. Supabase Access Token (For CLI - Optional)

If you can't run `supabase login` interactively, you can use an access token:

1. Go to https://supabase.com/dashboard
2. Click your profile icon (top right)
3. Go to **Access Tokens**
4. Click **Generate New Token**
5. Copy the token

**But first, try running `supabase login` in a terminal - it's easier!**

---

## What You're Looking At

The screenshot you showed is Supabase's **project API keys** (anon/public keys). These are:
- ✅ Used in your frontend code (you already have this)
- ❌ NOT what we need for CLI login
- ❌ NOT what we need for email notifications

---

## Summary

**For email notifications setup, we need:**
- ✅ **Resend API Key** (from resend.com) - This is what you should share with me

**For CLI login (if needed):**
- Try `supabase login` first (opens browser)
- Or use Supabase Access Token if that doesn't work
