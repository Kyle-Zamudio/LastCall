# Verify lastcall.work in Resend

## Important: Use the Correct Domain!

You own: **`lastcall.work`** (not `lastcallwork.com`)

## Step 1: Add Domain in Resend
1. Go to: https://resend.com/domains
2. Click "Add Domain"
3. Enter: **`lastcall.work`** (NOT lastcallwork.com)
4. Copy the DNS records Resend gives you

## Step 2: Add DNS Records in GoDaddy
1. Go to: https://www.godaddy.com
2. Sign in → My Products → Domains
3. Click on **`lastcall.work`** → DNS
4. Add these records:

### DKIM:
- Type: **TXT**
- Name: `resend._domainkey`
- Value: (from Resend)
- TTL: 600

### SPF (2 records):
**Record 1:**
- Type: **MX**
- Name: `send`
- Value: (from Resend)
- Priority: `10`
- TTL: 600

**Record 2:**
- Type: **TXT**
- Name: `send`
- Value: (from Resend)
- TTL: 600

### DMARC (Optional):
- Type: **TXT**
- Name: `_dmarc`
- Value: `v=DMARC1; p=none;`
- TTL: 600

## Step 3: Verify
1. Wait 5-30 minutes
2. Go back to Resend
3. Click "I've added the records"
4. Resend will verify automatically

## After Verification
Once verified, emails will work! The FROM_EMAIL is already set to `notifications@lastcall.work`
