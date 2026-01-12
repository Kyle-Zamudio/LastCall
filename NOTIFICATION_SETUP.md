# Email Notification Setup Guide

This guide explains how to set up email notifications for workers when new shifts are posted.

## Overview

When a business posts a new shift, the system automatically sends email notifications to all workers who:
- Have the shift's position in their profile
- Have email notifications enabled (default: enabled)
- Are marked as available

## Setup Steps

### 1. Run the Database Migration

First, add the email notification preference field to the workers table:

```sql
-- Run this migration
\i migration_add_email_notifications.sql
```

Or manually execute:
```sql
ALTER TABLE workers
ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;
```

### 2. Set Up Email Service (Resend)

The notification system uses [Resend](https://resend.com) for sending emails. You'll need to:

1. **Sign up for Resend** at https://resend.com
2. **Get your API key** from the Resend dashboard
3. **Verify your domain** (or use Resend's test domain for development)

### 3. Deploy the Supabase Edge Function

1. **Install Supabase CLI** (if not already installed):
   ```bash
   npm install -g supabase
   ```

2. **Link your project**:
   ```bash
   supabase link --project-ref your-project-ref
   ```

3. **Set environment variables**:
   ```bash
   supabase secrets set RESEND_API_KEY=your_resend_api_key
   supabase secrets set FROM_EMAIL=notifications@yourdomain.com
   ```

4. **Deploy the function**:
   ```bash
   supabase functions deploy send-shift-notifications
   ```

### 4. Alternative: Use Supabase Database Webhooks

If you prefer not to use Edge Functions, you can set up a database webhook:

1. Go to your Supabase dashboard
2. Navigate to Database → Webhooks
3. Create a new webhook that triggers on `INSERT` to the `shifts` table
4. Point it to your own notification service endpoint

### 5. Test the System

1. **As a worker**: Go to Settings → Edit Profile
2. **Verify** that "Email Notifications" is enabled (default)
3. **As a business**: Post a new shift
4. **Check** that matching workers receive email notifications

## Configuration

### Default Behavior

- New workers have email notifications **enabled by default**
- Workers can opt-out in their profile settings
- Notifications are sent immediately when a shift is posted

### Email Content

The notification email includes:
- Business name
- Position
- Date and time
- Pay rate
- Age requirement
- Location (if available)
- Link to view the shift on LastCall

## Troubleshooting

### Emails Not Sending

1. **Check Edge Function logs**:
   ```bash
   supabase functions logs send-shift-notifications
   ```

2. **Verify environment variables**:
   ```bash
   supabase secrets list
   ```

3. **Test Resend API**:
   - Check your Resend dashboard for delivery status
   - Verify your API key is correct

### Workers Not Receiving Emails

1. **Check worker preferences**: Ensure `email_notifications_enabled` is `true`
2. **Verify position match**: Worker must have the shift's position in their profile
3. **Check availability**: Worker must be marked as `available = true`
4. **Check spam folder**: Emails might be filtered as spam

## Customization

### Change Email Template

Edit `supabase/functions/send-shift-notifications/index.ts` to customize:
- Email subject line
- Email body HTML
- Email styling

### Use Different Email Service

To use a different email service (SendGrid, Mailgun, etc.):
1. Replace the Resend API call in the Edge Function
2. Update the API endpoint and authentication
3. Adjust the request format as needed

## Cost Considerations

- **Resend**: Free tier includes 3,000 emails/month
- **Supabase Edge Functions**: Free tier includes 500,000 invocations/month
- For high volume, consider upgrading plans

## Security Notes

- Never commit API keys to version control
- Use Supabase secrets for environment variables
- The Edge Function uses service role key (keep it secure)
- Email addresses are only used for notifications
