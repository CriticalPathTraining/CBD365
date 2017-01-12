cls

$tenantName = "PBI2017"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null

$location = "southcentralus" 

$resourceGroupName = "powerbi-demo"

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction Ignore

# Create group if it does't exist
if(!$resourceGroup){
  Write-Host "Resource group named" $resourceGroupName "does not exist - now creating it"
  $resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
}

