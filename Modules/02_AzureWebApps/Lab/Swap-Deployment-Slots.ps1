cls
$tenantName = "[YOUR TENANT]"
$tenantAdminAccountName = "[YOUR USER ACCOUNT]"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$resourceGroupName = "lab02"
$webAppName = "MyWebApp714"
$sourceSlotName = "staging"
$destinationSlotName = "production"

# establish login
$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null

Write-Host "Swapping deployment slots..."
Swap-AzureRmWebAppSlot `
       -ResourceGroupName $resourceGroupName `
       -Name $webAppName `
       -SourceSlotName $sourceSlotName `
       -DestinationSlotName $destinationSlotName
