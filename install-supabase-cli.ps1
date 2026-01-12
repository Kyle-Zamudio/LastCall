# PowerShell script to install Supabase CLI on Windows

Write-Host "Installing Supabase CLI..." -ForegroundColor Green

# Get the latest release URL
$latestReleaseUrl = "https://api.github.com/repos/supabase/cli/releases/latest"
Write-Host "Fetching latest release information..." -ForegroundColor Yellow

try {
    $releaseInfo = Invoke-RestMethod -Uri $latestReleaseUrl
    # Look for Windows tar.gz file
    $downloadUrl = $releaseInfo.assets | Where-Object { 
        $_.name -like "*windows*amd64*.tar.gz"
    } | Select-Object -First 1 -ExpandProperty browser_download_url
    
    if (-not $downloadUrl) {
        Write-Host "Error: Could not find Windows download URL" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "Found release: $($releaseInfo.tag_name)" -ForegroundColor Green
    Write-Host "Download URL: $downloadUrl" -ForegroundColor Yellow
    
    # Create temp directory
    $tempDir = "$env:TEMP\supabase-install"
    $tarPath = "$tempDir\supabase.tar.gz"
    $extractPath = "$tempDir\extracted"
    
    New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
    New-Item -ItemType Directory -Force -Path $extractPath | Out-Null
    
    # Download
    Write-Host "Downloading Supabase CLI..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $downloadUrl -OutFile $tarPath
    
    # Extract tar.gz (requires 7-Zip or tar command)
    Write-Host "Extracting..." -ForegroundColor Yellow
    # Try using built-in tar (Windows 10+)
    try {
        tar -xzf $tarPath -C $extractPath
    } catch {
        Write-Host "Note: Using alternative extraction method..." -ForegroundColor Yellow
        # If tar doesn't work, user will need to extract manually
        Write-Host "Please extract $tarPath manually and place supabase.exe in $extractPath" -ForegroundColor Yellow
        Write-Host "Press Enter after extracting..." -ForegroundColor Yellow
        Read-Host
    }
    
    # Find supabase.exe
    $supabaseExe = Get-ChildItem -Path $extractPath -Recurse -Filter "supabase.exe" | Select-Object -First 1
    
    if (-not $supabaseExe) {
        Write-Host "Error: Could not find supabase.exe in downloaded archive" -ForegroundColor Red
        exit 1
    }
    
    # Create installation directory
    $installDir = "$env:USERPROFILE\Tools\supabase"
    New-Item -ItemType Directory -Force -Path $installDir | Out-Null
    
    # Copy executable
    Copy-Item -Path $supabaseExe.FullName -Destination "$installDir\supabase.exe" -Force
    
    Write-Host "Supabase CLI installed to: $installDir" -ForegroundColor Green
    
    # Add to PATH
    Write-Host "Adding to PATH..." -ForegroundColor Yellow
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    
    if ($currentPath -notlike "*$installDir*") {
        $newPath = $currentPath + ";$installDir"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        Write-Host "Added to PATH!" -ForegroundColor Green
    } else {
        Write-Host "Already in PATH" -ForegroundColor Yellow
    }
    
    # Cleanup
    Remove-Item -Path $tempDir -Recurse -Force
    
    Write-Host ""
    Write-Host "✅ Installation complete!" -ForegroundColor Green
    Write-Host ""
    Write-Host "IMPORTANT: Please close and reopen your terminal/PowerShell window" -ForegroundColor Yellow
    Write-Host "Then run: supabase --version" -ForegroundColor Cyan
    Write-Host ""
    
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
    exit 1
}
