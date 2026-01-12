# SMS/Phone Notifications - Implementation Plan

## Current Status
✅ Phone numbers are already collected from both workers and businesses
✅ Phone field exists in both signup forms and settings

## Why SMS Notifications?
- **Faster than email** - Most people check texts immediately
- **Higher open rates** - SMS has ~98% open rate vs ~20% for email
- **Time-sensitive** - Perfect for shift notifications that need quick response
- **No app required** - Works on any phone

## Implementation Options

### Option 1: Twilio (Most Popular)
**Pros:**
- Very reliable and widely used
- Good documentation
- Pay-as-you-go pricing
- Easy to integrate

**Cons:**
- Costs ~$0.0075 per SMS (about 3/4 of a cent)
- Need to verify phone numbers (can be done via code)

**Pricing:**
- ~$0.0075 per SMS in US
- Free tier: None (but very cheap)

### Option 2: AWS SNS (Simple Notification Service)
**Pros:**
- Very cheap ($0.00645 per SMS in US)
- Integrates well if you're using AWS
- Reliable

**Cons:**
- Slightly more complex setup
- Need AWS account

**Pricing:**
- ~$0.00645 per SMS in US
- Very affordable

### Option 3: Resend (If they add SMS)
**Pros:**
- Already using Resend for email
- Could consolidate services

**Cons:**
- Resend doesn't currently support SMS (email only)

## Recommended: Twilio

**Why Twilio:**
- Easiest to set up
- Best documentation
- Most developer-friendly
- Very reliable

## Implementation Steps

### 1. Add SMS Notification Preferences
- Add `sms_notifications_enabled` column to workers and businesses tables
- Add toggle in settings (similar to email notifications)

### 2. Set Up Twilio
- Sign up at https://twilio.com
- Get API credentials (Account SID, Auth Token)
- Get a phone number (or use trial number for testing)

### 3. Create Edge Function
- Similar to email notification functions
- Use Twilio API to send SMS
- Format messages for SMS (shorter, 160 chars)

### 4. Update Notification Triggers
- When shift is posted → SMS workers (if enabled)
- When worker expresses interest → SMS business (if enabled)

## Cost Estimate

**Example:**
- 100 shifts posted per month
- Average 5 workers notified per shift = 500 SMS
- 100 worker interests = 100 SMS to businesses
- **Total: ~600 SMS/month**
- **Cost: ~$4.50/month** (very affordable!)

## Message Format (SMS-friendly)

**Worker Notification:**
```
New shift! Bartender at Joe's Bar, Sat 6pm-10pm, $25/hr. View: lastcall.work
```

**Business Notification:**
```
New interest! Kyle Z. wants your Bartender shift (Sat 6pm). View: lastcall.work
```

## Features to Add

1. **SMS Notification Toggle** (in settings)
2. **Phone Number Verification** (optional, but recommended)
3. **SMS Rate Limiting** (prevent spam)
4. **Opt-out keyword** (reply STOP to unsubscribe)

## Should We Do It?

**Pros:**
- ✅ Already have phone numbers
- ✅ Relatively easy to implement
- ✅ Very affordable
- ✅ Higher engagement than email
- ✅ Users expect SMS for time-sensitive things

**Cons:**
- ⚠️ Small ongoing cost (~$5-10/month for typical usage)
- ⚠️ Need to handle opt-outs
- ⚠️ Phone number verification adds complexity

## Recommendation

**Yes, but start simple:**
1. Add SMS notification preferences
2. Use Twilio (easiest)
3. Start with basic notifications (same as email)
4. Add phone verification later if needed

Want me to implement it? I can:
- Add SMS notification preferences to database
- Create Twilio Edge Function
- Add UI toggles in settings
- Update notification triggers

Let me know and I'll get started!
