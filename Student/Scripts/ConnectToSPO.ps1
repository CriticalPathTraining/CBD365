# establish authenticated connection to tenant admin site collection
$credential = Get-Credential
Connect-SPOService -Url https://CptLabs-admin.sharepoint.com -Credential $credential

# enable scripting
Set-SPOsite https://CptLabs.sharepoint.com -DenyAddAndCustomizePages 0 
