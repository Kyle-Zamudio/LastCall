# Adding DNS Records in GoDaddy

## Step 1: Log into GoDaddy
1. Go to: https://www.godaddy.com
2. Sign in to your account
3. Go to "My Products" → "Domains"
4. Find `lastcall.work` (or `lastcallwork.com` if you own that)
5. Click "DNS" or "Manage DNS"

## Step 2: Add the DNS Records

You'll need to add these records from Resend:

### DKIM Record:
1. Click "Add" or "+" to add a new record
2. Select Type: **TXT**
3. Name: `resend._domainkey`
4. Value: (paste the full content from Resend - starts with `p=MIGfMAOGCSqGSIb3DQEB...`)
5. TTL: 600 (or leave default)
6. Click "Save"

### SPF Records (2 records):

**Record 1 - MX:**
1. Click "Add"
2. Type: **MX**
3. Name: `send`
4. Value: (the feedback-smtp.us-east-... value from Resend)
5. Priority: `10`
6. TTL: 600
7. Click "Save"

**Record 2 - TXT:**
1. Click "Add"
2. Type: **TXT**
3. Name: `send`
4. Value: (the `v=spf1 include:amazons...` value from Resend)
5. TTL: 600
6. Click "Save"

### DMARC Record (Optional):
1. Click "Add"
2. Type: **TXT**
3. Name: `_dmarc`
4. Value: `v=DMARC1; p=none;`
5. TTL: 600
6. Click "Save"

## Step 3: Wait and Verify
1. Wait 5-30 minutes for DNS to propagate
2. Go back to Resend
3. Click "I've added the records"
4. Resend will verify automatically

## Important Notes:
- Make sure you're adding records to the correct domain (`lastcall.work` or `lastcallwork.com`)
- Don't delete any existing records
- DNS changes can take up to 24 hours, but usually work in 5-30 minutes
