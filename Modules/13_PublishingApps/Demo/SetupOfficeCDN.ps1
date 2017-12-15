$creds = Get-Credential -UserName "student@pbibc.onMicrosoft.com" -Message "Enter password"

Connect-SPOService -Url https://pbibc-admin.sharepoint.com -Credential $creds

#Get-SPOTenantCdnEnabled -CdnType Public
#Get-SPOTenantCdnOrigins -CdnType Public
#Get-SPOTenantCdnPolicies -CdnType Public

Set-SPOTenantCdnEnabled -CdnType Public

Get-SPOTenantCdnOrigins -CdnType Public