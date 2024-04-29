# Define App Name as Repository Name
$appName = "HelloWorld-DotNet-App"

# Define the URL of the GitHub repository to clone
$repositoryUrl = "https://github.com/ccostin28/" + $appName

# Define the directory where you want to clone the repository
$cloneDirectory = "C:\temp\" + $appName

# Clone the repository using Git
git clone $repositoryUrl $cloneDirectory

# Create a directory for the web application
$createDirForApp = "C:\inetpub\wwwroot\" + $appName
New-Item -ItemType Directory -Path $createDirForApp

# Copy the application files to the directory
$path = $cloneDirectory + "/*"
$destination = "C:\inetpub\wwwroot\" + $appName
Copy-Item -Path $path -Destination $destination -Recurse

# Start IIS (if not already started)
Start-Service -Name W3SVC

# Restart the website in IIS
Restart-WebItem -Name "Default Web Site"
