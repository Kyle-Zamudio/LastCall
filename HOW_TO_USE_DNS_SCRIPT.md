# How to Use the GoDaddy DNS Script

## Step 1: Get DNS Record Values from Resend

1. Go to: https://resend.com/domains
2. Click on `lastcall.work`
3. Copy these values:

**DKIM:**
- Name: `resend._domainkey`
- Content: (the long string - copy the FULL value)

**SPF MX:**
- Name: `send`
- Type: `MX`
- Content: (the feedback-smtp.us-east-... value)

**SPF TXT:**
- Name: `send`
- Type: `TXT`
- Content: (the v=spf1 include:amazons... value)

## Step 2: Run the Script

Open PowerShell and run:

```powershell
.\add-godaddy-dns.ps1 `
    -DkimValue "PASTE_DKIM_VALUE_HERE" `
    -SpfMxValue "PASTE_SPF_MX_VALUE_HERE" `
    -SpfTxtValue "PASTE_SPF_TXT_VALUE_HERE"
```

Replace the values with the actual values from Resend.

## Step 3: Verify

1. Wait 5-30 minutes
2. Go back to Resend
3. Click "I've added the records"
4. Resend will verify automatically

## Alternative: Manual Method

If the script doesn't work, you can add records manually in GoDaddy:
1. Go to: https://www.godaddy.com
2. Sign in → My Products → Domains
3. Click `lastcall.work` → DNS
4. Add the records manually
