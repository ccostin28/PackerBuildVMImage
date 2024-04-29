# Install .NET Framework (example)
Install-WindowsFeature -Name Web-Server
Install-WindowsFeature -Name NET-Framework-Core

# Install .NET Core Runtime
#Invoke-WebRequest -Uri https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
#.\dotnet-install.ps1 -Channel LTS -Runtime aspnetcore

# Install .NET Runtime (example)
Invoke-WebRequest -Uri "https://dotnet.microsoft.com/download/dotnet/thank-you/runtime-8.0.0-windows-x64-installer" -OutFile "dotnet-runtime-installer.exe"
Start-Process -FilePath "dotnet-runtime-installer.exe" -ArgumentList "/quiet" -Wait
Remove-Item "dotnet-runtime-installer.exe"


# Install IIS (Internet Information Services)
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Configure IIS for ASP.NET Core
& $Env:ProgramFiles\dotnet\sdk\${{ env:DOTNET_VERSION }}\AspNetCore\Hosting\IIS\installiisintegration.ps1

# Enable ASP.NET Core Module
Add-WebGlobalModule -Name AspNetCoreModule -Image $Env:ProgramFiles\dotnet\modules\AspNetCoreModuleV2\aspnetcorev2.dll

# Optional: Install URL Rewrite Module (if needed for URL rewriting)
Invoke-WebRequest -Uri https://download.microsoft.com/download/C/3/A/C3A5200B-D33C-47E9-9D70-2F7C65DAAD94/rewrite_amd64_en-US.msi -OutFile rewrite_amd64_en-US.msi
Start-Process -FilePath msiexec -ArgumentList "/i rewrite_amd64_en-US.msi /qn" -NoNewWindow -Wait

# Optional: Install other dependencies or tools (e.g., SQL Server, Redis, etc.)

# Install additional Windows features or roles
# Add-WindowsFeature ...

# Restart IIS to apply changes
Restart-Service -Name W3SVC

# Install Chocolatey (optional, for package management)
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install packages using Chocolatey (example)
#choco install -y <package_name>

# Install git using Chocolatey
choco install -y git.install

###############################################################################
# If installing git using Chocolatey does not work, uncomment the below rows
# Define the URL to download the Git for Windows installer
#$gitInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.2/Git-2.35.1.2-64-bit.exe"

# Define the path where you want to download the installer
#$installerPath = "$env:TEMP\GitInstaller.exe"

# Download the Git for Windows installer
#Invoke-WebRequest -Uri $gitInstallerUrl -OutFile $installerPath

# Execute the installer silently
#Start-Process -FilePath $installerPath -ArgumentList "/SILENT", "/NORESTART" -Wait

# Remove the installer file
#Remove-Item $installerPath
###############################################################################

# Install other software or dependencies (example)
# Invoke-WebRequest -Uri "https://example.com/installer.exe" -OutFile "installer.exe"
# Start-Process -FilePath "installer.exe" -ArgumentList "/S" -Wait









