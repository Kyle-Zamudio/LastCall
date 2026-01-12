# Email Notifications - Complete Setup

## ✅ What's Been Added

### 1. **Worker Email Notifications** (When shifts are posted)
- ✅ Workers receive emails when new shifts matching their positions are posted
- ✅ Workers can enable/disable email notifications in their profile settings
- ✅ Edge Function: `send-shift-notifications` (already deployed)

### 2. **Business Email Notifications** (When workers express interest)
- ✅ Businesses receive emails when workers express interest in their shifts
- ✅ Businesses can enable/disable email notifications in their settings
- ✅ Edge Function: `notify-business-interest` (needs deployment)
- ✅ Automatically triggered when a worker clicks "I'm Interested"

### 3. **Database Migrations**
- ✅ `migration_add_email_notifications.sql` - Adds email preferences for workers
- ✅ `migration_add_business_email_notifications.sql` - Adds email preferences for businesses

### 4. **UI Updates**
- ✅ Worker Settings: Email notification toggle added
- ✅ Business Settings: Email notification toggle added

---

## 📋 Next Steps

### Step 1: Run Database Migrations

Run both migrations in your Supabase SQL Editor:

1. **For Workers:**
   ```sql
   ALTER TABLE workers
   ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;
   ```

2. **For Businesses:**
   ```sql
   ALTER TABLE businesses
   ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN DEFAULT true;
   ```

Or run the migration files:
- `migration_add_email_notifications.sql`
- `migration_add_business_email_notifications.sql`

### Step 2: Deploy the Business Notification Function

```powershell
& "$env:USERPROFILE\Tools\supabase\supabase.exe" functions deploy notify-business-interest
```

### Step 3: Verify Email Fields

Both workers and businesses already have email addresses:
- ✅ Workers: Email is collected during signup (used for login)
- ✅ Businesses: Email is collected during signup (used for login)
- ✅ Both are stored in the `email` field in their respective tables

---

## 🧪 Testing

### Test Worker Notifications:
1. As a business, post a new shift
2. Check that workers with matching positions receive email notifications
3. Verify the email includes shift details and a link to view

### Test Business Notifications:
1. As a worker, express interest in a shift
2. Check that the business receives an email notification
3. Verify the email includes worker details and shift information

---

## 📧 Email Content

### Worker Notification Email Includes:
- Business name
- Position
- Date and time
- Pay rate
- Age requirement
- Location (if available)
- Link to view shift

### Business Notification Email Includes:
- Worker name
- Worker experience
- Worker positions
- Worker certifications
- Worker contact info (if available)
- Shift details
- Link to view on LastCall

---

## ⚙️ Configuration

### Default Behavior:
- **New workers**: Email notifications enabled by default
- **New businesses**: Email notifications enabled by default
- **Existing users**: Email notifications enabled by default (after migration)

### Users Can:
- Enable/disable email notifications in their profile settings
- Still receive browser notifications (if enabled)
- Continue using the website normally

---

## 🔍 Troubleshooting

### Emails Not Sending:

1. **Check Edge Function logs:**
   ```powershell
   & "$env:USERPROFILE\Tools\supabase\supabase.exe" functions logs send-shift-notifications
   & "$env:USERPROFILE\Tools\supabase\supabase.exe" functions logs notify-business-interest
   ```

2. **Verify secrets are set:**
   ```powershell
   & "$env:USERPROFILE\Tools\supabase\supabase.exe" secrets list
   ```

3. **Check Resend dashboard:**
   - Go to https://resend.com
   - Check the "Emails" section for delivery status
   - Verify API key is active

4. **Verify user preferences:**
   - Check that `email_notifications_enabled` is `true` in database
   - Check that user has a valid email address

---

## ✅ Status

- ✅ Workers have email addresses (from signup)
- ✅ Businesses have email addresses (from signup)
- ✅ Email notification preferences added for both
- ✅ Edge Functions created and configured
- ✅ UI toggles added to settings
- ✅ Automatic triggers in place

**Everything is ready!** Just run the migrations and deploy the business notification function.
