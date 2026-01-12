# Generate VAPID Keys for Web Push

VAPID keys are required for Web Push API. They're free and easy to generate.

## Option 1: Online Generator (Easiest)

1. Go to: https://web-push-codelab.glitch.me/
2. Click "Generate VAPID Keys"
3. Copy both keys:
   - **Public Key** (starts with `B...`)
   - **Private Key** (starts with `...`)

## Option 2: Using Node.js (if you have it)

```bash
npm install -g web-push
web-push generate-vapid-keys
```

## What You'll Get

- **Public Key**: Used in the frontend (safe to expose)
- **Private Key**: Used in Edge Functions (keep secret!)

## After Generating

1. Set the public key in `index.html` (replace `YOUR_VAPID_PUBLIC_KEY`)
2. Set the private key as a Supabase secret: `VAPID_PRIVATE_KEY`

Let me know when you have the keys and I'll help you set them up!
