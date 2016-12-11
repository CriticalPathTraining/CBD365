cls
$tenantName = "LabsForCBD365"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null
Add-AzureAccount -Credential $credential

$location = "southcentralus" 

$resourceGroupName = "Lab01"

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction Ignore

# Create group if it does't exist
if(!$resourceGroup){
  Write-Host "Resource group named" $resourceGroupName "does not exist - now creating it"
  $resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
}


# create app service plan if it doesn't exist
$appservicePlanName = "lab01-appserviceplan"
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
$webAppName = "cbd365-webapp"

# ensure web app name is not in use
$originalName = $webAppName 
$counter = 0


while(Test-AzureName -Website -Name $webAppName){
    Write-Host "Web app name $webAppName already in use"
    $counter += 1
    $webAppName = $originalName + $counter
}

Write-Host "Web app name $webAppName is available"

# create web app
$webApp = New-AzureRmWebApp `
            -ResourceGroupName $resourceGroupName `
            -Location $location `
            -AppServicePlan $appservicePlanName `
            -Name $webAppName



Add-AzureAccount -Credential $credential
Publish-AzureWebsiteProject -Package .\Bob.zip -Name $webAppName

$url = "https://" + $webApp.DefaultHostName
Start-Process $url
