Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module Azure -AllowClobber
Install-Module AzureRM -AllowClobber
Install-Module AzureAD