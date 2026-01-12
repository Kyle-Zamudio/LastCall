# Automated setup script for email notifications
# Run this AFTER you've logged in and linked your project

$supabasePath = "$env:USERPROFILE\Tools\supabase\supabase.exe"

Write-Host "Setting up email notification secrets..." -ForegroundColor Green
Write-Host ""

# Set Resend API Key
Write-Host "Setting RESEND_API_KEY..." -ForegroundColor Yellow
& $supabasePath secrets set RESEND_API_KEY=re_Dr3XiVQD_8XY3iwSd2rYRYM2XvG1vdgjB

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ RESEND_API_KEY set successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to set RESEND_API_KEY. Make sure you're logged in and project is linked." -ForegroundColor Red
    exit 1
}

# Set FROM_EMAIL
Write-Host "Setting FROM_EMAIL..." -ForegroundColor Yellow
& $supabasePath secrets set FROM_EMAIL=onboarding@resend.dev

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ FROM_EMAIL set successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to set FROM_EMAIL" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Deploying Edge Function..." -ForegroundColor Yellow
& $supabasePath functions deploy send-shift-notifications

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ SUCCESS! Email notifications are now set up!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Run the database migration: migration_add_email_notifications.sql" -ForegroundColor White
    Write-Host "2. Test by posting a shift as a business" -ForegroundColor White
    Write-Host "3. Check that workers receive email notifications" -ForegroundColor White
} else {
    Write-Host "❌ Failed to deploy function. Check the error above." -ForegroundColor Red
}
