# Installing Supabase CLI on Windows

Since npm global installation is not supported, use one of these methods:

## Method 1: Direct Download (Easiest)

1. **Download the latest release:**
   - Go to: https://github.com/supabase/cli/releases/latest
   - Download: `supabase_windows_amd64.zip` (or `supabase_windows_arm64.zip` for ARM)

2. **Extract the zip file:**
   - Extract `supabase.exe` to a folder (e.g., `C:\Tools\supabase\`)

3. **Add to PATH:**
   - Press `Win + X` and select "System"
   - Click "Advanced system settings"
   - Click "Environment Variables"
   - Under "User variables", find "Path" and click "Edit"
   - Click "New" and add the folder path (e.g., `C:\Tools\supabase\`)
   - Click OK on all dialogs

4. **Verify installation:**
   - Open a NEW terminal/PowerShell window
   - Run: `supabase --version`

## Method 2: Using Scoop (If you install Scoop)

If you want to use Scoop:

```powershell
# Install Scoop first (if not installed)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Add Supabase bucket
scoop bucket add supabase https://github.com/supabase/scoop-bucket.git

# Install Supabase
scoop install supabase
```

## Method 3: Manual Installation via GitHub Releases

```powershell
# Download latest version
$url = "https://github.com/supabase/cli/releases/latest/download/supabase_windows_amd64.zip"
$output = "$env:TEMP\supabase.zip"
Invoke-WebRequest -Uri $url -OutFile $output

# Extract
Expand-Archive -Path $output -DestinationPath "$env:TEMP\supabase" -Force

# Move to a permanent location
New-Item -ItemType Directory -Force -Path "C:\Tools\supabase"
Move-Item "$env:TEMP\supabase\supabase.exe" -Destination "C:\Tools\supabase\supabase.exe" -Force

# Add to PATH (requires manual step or admin rights)
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Tools\supabase", "User")
```

After installation, **restart your terminal** and verify:
```bash
supabase --version
```
