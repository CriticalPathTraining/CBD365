# establish authenticated connection to tenant admin site collection
$credential = Get-Credential
Connect-SPOService -Url https://CptLiberty1-admin.sharepoint.com -Credential $credential
                                                                                                 


# enable scripting for a specific site collection
#Set-SPOSite https://CptLiberty1.sharepoint.com/sites/TeamSite_TedPattison -DenyAddAndCustomizePages 0

Get-SPOSite https://CptLiberty1.sharepoint.com/sites/TeamSite_TedPattison | select *