# Script to set up Supabase secrets for email notifications
# This securely stores your API key in Supabase (not in files)

param(
    [Parameter(Mandatory=$true)]
    [string]$ResendApiKey,
    
    [Parameter(Mandatory=$false)]
    [string]$FromEmail = "onboarding@resend.dev"
)

Write-Host "Setting up Supabase secrets..." -ForegroundColor Green

# Use full path to supabase CLI
$supabasePath = "$env:USERPROFILE\Tools\supabase\supabase.exe"

# Set RESEND_API_KEY
Write-Host "Setting RESEND_API_KEY..." -ForegroundColor Yellow
& $supabasePath secrets set RESEND_API_KEY=$ResendApiKey

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ RESEND_API_KEY set successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to set RESEND_API_KEY" -ForegroundColor Red
    exit 1
}

# Set FROM_EMAIL
Write-Host "Setting FROM_EMAIL to $FromEmail..." -ForegroundColor Yellow
& $supabasePath secrets set FROM_EMAIL=$FromEmail

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ FROM_EMAIL set successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to set FROM_EMAIL" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "✅ All secrets configured!" -ForegroundColor Green
Write-Host ""
Write-Host "Next step: Deploy the function with:" -ForegroundColor Cyan
Write-Host "  & `"$supabasePath`" functions deploy send-shift-notifications" -ForegroundColor Yellow
