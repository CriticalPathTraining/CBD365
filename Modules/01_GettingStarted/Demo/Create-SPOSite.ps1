cls

$tenantName = "LabsForCBD365"
$tenantAdminAccountName = "Student"

$tenantDomain = $tenantName + ".onMicrosoft.com"
Write-Host "Tenant domain: $tenantDomain"

$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain
Write-Host "Tenant Admin SPN: $tenantAdminSPN"

$spoTenantAdminSiteUrl = "https://" + $tenantName + "-admin.sharepoint.com"
Write-Host "SPO Tenant Admin Site: $spoTenantAdminSiteUrl"


$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Connect-SPOService -Url $spoTenantAdminSiteUrl -Credential $credential


Get-SPOSite | Format-Table Url, Template

$newSiteName = "DevSite"
$newSiteUrl = "https://" + $tenantName + ".sharepoint.com/sites/" + $newSiteName

New-SPOSite -Url $newSiteUrl `
            -Owner $tenantAdminSPN `
            -StorageQuota 1000 `
            -Title "Test Site" `
            -Template "DEV#0" `
            -NoWait