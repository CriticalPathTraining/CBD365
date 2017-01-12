$tenantName = "LabsForCBD365"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"

cls
Login-AzureRMAccount -Credential $credential


#Get-AzureRmSubscription

#Get-AzureRmResourceProvider

#Get-AzureRmADUser

#Get-AzureRmADApplication
Get-AzureRmADGroup | select *