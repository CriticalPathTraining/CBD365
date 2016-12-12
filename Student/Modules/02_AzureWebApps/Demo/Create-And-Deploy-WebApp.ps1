cls

$tenantName = "LabsForCBD365"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null

$location = "southcentralus" 

$resourceGroupName = "Lab02"

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction Ignore

# Create group if it does't exist
if(!$resourceGroup){
  Write-Host "Resource group named" $resourceGroupName "does not exist - now creating it"
  $resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
}


# create app service plan if it doesn't exist
$appservicePlanName = "lab02-appserviceplan"
$appservicePlan = Get-AzureRmAppServicePlan -Name $appservicePlanName -ErrorAction Ignore
if(!$appservicePlan){
    # create app service plan
    Write-Host "App servie Plan named" $appservicePlanName "does not exist - now creating it"

    $appservicePlan = New-AzureRmAppServicePlan `
                         -ResourceGroupName $resourceGroupName `
                         -location $location `
                         -Name $appservicePlanName `
                         -Tier Standard `
                         -WorkerSize Small `
                         -NumberofWorkers 1
}

# Process for creating web app
$webAppName = "cbd365-webapp-0"
$webApp = Get-AzureRmWebApp -Name $webAppName -ResourceGroupName $resourceGroupName -ErrorAction Ignore
if(!$webApp) {
    # create app service plan
    Write-Host "WebApp named" $webAppName "does not exist - now creating it"
    # create web app
    $webApp = New-AzureRmWebApp `
                -ResourceGroupName $resourceGroupName `
                -Location $location `
                -AppServicePlan $appservicePlanName `
                -Name $webAppName
}

$webApp | select *


Add-AzureAccount -Credential $credential
$packagePath = $PSScriptRoot + "\Bob.zip"
Publish-AzureWebsiteProject -Package $packagePath -Name $webAppName


$webAppUrl = "https://" + $webAppName + ".azurewebsites.net"
Start-Process $webAppUrl

