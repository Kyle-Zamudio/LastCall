# Add DNS Records Manually in GoDaddy

## Step 1: Go to GoDaddy DNS Management

1. Go to: https://www.godaddy.com
2. Sign in to your account
3. Click "My Products" → "Domains"
4. Find `lastcall.work`
5. Click "DNS" or "Manage DNS"

## Step 2: Add DKIM Record

1. Click "Add" or "+" button
2. Select Type: **TXT**
3. Name: `resend._domainkey`
4. Value: `p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCgWaQb2lsYNKzZRGuOr0wR83wEigK2uUEMclK/A+Ia+QqCwtuwLV/GITJ0m0fDs5MrVRO1vq3wQbeTuqa5AkpJmZt3nOi9iksI9LzNLOmMXlvNrvMxmanpYawi8gnPhnLQujkzwshR48y2GcLRirNz3IBfRrj/Ywlkap85oKBrgwIDAQAB`
5. TTL: `600` (or leave default)
6. Click "Save"

## Step 3: Add SPF MX Record

1. Click "Add" or "+" button
2. Select Type: **MX**
3. Name: `send`
4. Value: `feedback-smtp.us-east-1.amazonses.com`
5. Priority: `10`
6. TTL: `600` (or leave default)
7. Click "Save"

## Step 4: Add SPF TXT Record

1. Click "Add" or "+" button
2. Select Type: **TXT**
3. Name: `send`
4. Value: `v=spf1 include:amazonses.com ~all`
5. TTL: `600` (or leave default)
6. Click "Save"

## Step 5: Add DMARC Record (Optional)

1. Click "Add" or "+" button
2. Select Type: **TXT**
3. Name: `_dmarc`
4. Value: `v=DMARC1; p=none;`
5. TTL: `600` (or leave default)
6. Click "Save"

## Step 6: Verify in Resend

1. Wait 5-30 minutes for DNS to propagate
2. Go to: https://resend.com/domains
3. Click on `lastcall.work`
4. Click "I've added the records"
5. Resend will verify automatically

## Notes:
- Don't delete any existing DNS records
- DNS changes can take up to 24 hours, but usually work in 5-30 minutes
- Make sure you're adding to the correct domain (`lastcall.work`)
