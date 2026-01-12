# GoDaddy DNS Record Addition Script
# This script adds the Resend DNS records to your GoDaddy domain

param(
    [Parameter(Mandatory=$true)]
    [string]$Domain = "lastcall.work",
    
    [Parameter(Mandatory=$true)]
    [string]$ApiKey = "fZBBEExoSvBJR_MBCszoFAXXtHwXC3fwz87Q",
    
    [Parameter(Mandatory=$true)]
    [string]$ApiSecret = "GB6MSbyxha1CgsXeyo4G7G",
    
    [Parameter(Mandatory=$true)]
    [string]$DkimValue,
    
    [Parameter(Mandatory=$true)]
    [string]$SpfMxValue,
    
    [Parameter(Mandatory=$true)]
    [string]$SpfTxtValue
)

$baseUrl = "https://api.godaddy.com/v1/domains/$Domain/records"

$headers = @{
    "Authorization" = "sso-key $ApiKey:$ApiSecret"
    "Content-Type" = "application/json"
}

Write-Host "Adding DNS records to $Domain..." -ForegroundColor Yellow

# 1. Add DKIM Record
Write-Host "`nAdding DKIM record..." -ForegroundColor Cyan
$dkimRecord = @{
    type = "TXT"
    name = "resend._domainkey"
    data = $DkimValue
    ttl = 600
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/TXT/resend._domainkey" -Method PUT -Headers $headers -Body $dkimRecord
    Write-Host "✅ DKIM record added successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ Error adding DKIM: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Response: $($_.Exception.Response)" -ForegroundColor Red
}

# 2. Add SPF MX Record
Write-Host "`nAdding SPF MX record..." -ForegroundColor Cyan
$spfMxRecord = @{
    type = "MX"
    name = "send"
    data = $SpfMxValue
    priority = 10
    ttl = 600
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/MX/send" -Method PUT -Headers $headers -Body $spfMxRecord
    Write-Host "✅ SPF MX record added successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ Error adding SPF MX: $($_.Exception.Message)" -ForegroundColor Red
}

# 3. Add SPF TXT Record
Write-Host "`nAdding SPF TXT record..." -ForegroundColor Cyan
$spfTxtRecord = @{
    type = "TXT"
    name = "send"
    data = $SpfTxtValue
    ttl = 600
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/TXT/send" -Method PUT -Headers $headers -Body $spfTxtRecord
    Write-Host "✅ SPF TXT record added successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ Error adding SPF TXT: $($_.Exception.Message)" -ForegroundColor Red
}

# 4. Add DMARC Record (Optional)
Write-Host "`nAdding DMARC record..." -ForegroundColor Cyan
$dmarcRecord = @{
    type = "TXT"
    name = "_dmarc"
    data = "v=DMARC1; p=none;"
    ttl = 600
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "$baseUrl/TXT/_dmarc" -Method PUT -Headers $headers -Body $dmarcRecord
    Write-Host "✅ DMARC record added successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ Error adding DMARC: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n✅ DNS records addition complete!" -ForegroundColor Green
Write-Host "Wait 5-30 minutes for DNS propagation, then verify in Resend." -ForegroundColor Yellow
