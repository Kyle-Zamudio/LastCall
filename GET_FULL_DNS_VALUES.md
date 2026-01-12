# How to Get Full DNS Record Values from Resend

## Step 1: View Full Values

On the Resend DNS Records page, you can:

1. **Click on the Value** - Some interfaces let you click to expand
2. **Hover over the value** - Might show tooltip with full value
3. **Copy button** - Look for a copy icon next to each value
4. **Right-click → Inspect** - View the full value in the HTML

## Step 2: Copy Each Value

You need to copy the FULL value for each record:

### DKIM Record:
- **Name:** `resend._domainkey`
- **Type:** TXT
- **Value:** (The FULL string starting with `p=MIGfMA0GCSqGSIb3DQEB...` - it's very long!)

### SPF MX Record:
- **Name:** `send`
- **Type:** MX
- **Value:** (The FULL string starting with `feedback-smtp.us-east-...`)

### SPF TXT Record:
- **Name:** `send`
- **Type:** TXT
- **Value:** (The FULL string starting with `v=spf1 include:amazons...`)

## Step 3: Paste Here

Once you have the full values, paste them here and I'll add them to GoDaddy automatically!

## Alternative: Manual Method

If it's easier, you can also add them manually in GoDaddy:
1. Go to: https://www.godaddy.com
2. Sign in → My Products → Domains
3. Click `lastcall.work` → DNS
4. Add each record manually
