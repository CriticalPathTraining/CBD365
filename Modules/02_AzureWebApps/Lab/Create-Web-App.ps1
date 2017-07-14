cls
$tenantName = "[YOUR TENANT]"
$tenantAdminAccountName = "[YOUR USER ACCOUNT]"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$location = "southcentralus" 
$resourceGroupName = "lab02"
$appServicePlanName = "lab02-plan"
$webAppName = "MyWebApp714"
$webAppSlotName = "staging"

# establish login
$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null

# Create resource group if it doesn't already exist
$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction Ignore
if(!$resourceGroup){
  Write-Host "Resource group named" $resourceGroupName "does not exist - now creating it"
  $resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
}

# create app service plan if it doesn't already exist
$appServicePlan = Get-AzureRmAppServicePlan -Name $appServicePlanName -ErrorAction Ignore
if(!$appServicePlan){
    # create app service plan
    Write-Host "App servie Plan named" $appServicePlanName "does not exist - now creating it"

    $appServicePlan = New-AzureRmAppServicePlan `
                         -ResourceGroupName $resourceGroupName `
                         -location $location `
                         -Name $appServicePlanName `
                         -Tier Standard `
                         -WorkerSize "Small" `
                         -NumberofWorkers 1
}


# create web app if it doesn't already exist
$webApp = Get-AzureRmWebApp -Name $webAppName -ResourceGroupName $resourceGroupName -ErrorAction Ignore
if(!$webApp) {
    # create web app
    Write-Host "Web App named" $webAppName "does not exist - now creating it"
    $webApp = New-AzureRmWebApp `
                 -ResourceGroupName $resourceGroupName `
                 -Location $location `
                 -AppServicePlan $appServicePlanName `
                 -Name $webAppName

    $slot = New-AzureRmWebAppSlot `
               -ResourceGroupName $resourceGroupName `
               -Name $webAppName `
               -Slot $webAppSlotName
}
