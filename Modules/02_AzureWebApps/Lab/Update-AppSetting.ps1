cls
$tenantName = "pbi2017"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$resourceGroupName = "lab02"
$webAppName = "MyWebApp714"

# establish login
$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null

   
$AppSettings = @{"WelcomeMessage" = "Hello App Settings Modified by a PowerShell Script" }
Set-AzureRmWebApp -ResourceGroupName $resourceGroupName -Name $webAppName -AppSettings $AppSettings
