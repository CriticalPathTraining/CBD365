# establish authenticated connection to tenant admin site collection
$credential = Get-Credential
Connect-SPOService -Url https://pbibc-admin.sharepoint.com -Credential $credential


# enable scripting for a specific site collection
Set-SPOSite https://pbibc.sharepoint.com-DenyAddAndCustomizePages 0

Get-SPOSite https://pbibc.sharepoint.com | select *