cls
$tenantName = "LabsForCBD365"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null
Add-AzureAccount -Credential $credential

$location = "southcentralus" 

$resourceGroupName = "demo01"

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction Ignore

# Create group if it does't exist
if(!$resourceGroup){
  Write-Host "Resource group named" $resourceGroupName "does not exist - now creating it"
  $resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
}


# Process for creating web app
$storageAccountName = "cbd365"
$storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -ErrorAction Ignore
if(!$storageAccount){
    # ensure web app name is not in use
    $originalName = $storageAccountName
    $counter = 0

    while( (Get-AzureRmStorageAccountNameAvailability $storageAccountName).NameAvailable -eq $false ){
        Write-Host "storage account name $storageAccountName already in use"
        $counter += 1
        $storageAccountName = $originalName + "00" + $counter
    }

    Write-Host "Storage account name $storageAccountName is available"

    $storageAccount = New-AzureRmStorageAccount `
                        -Location $location `
                        -ResourceGroupName $resourceGroupName `
                        -Name $storageAccountName `
                        -SkuName Standard_LRS `
                        -Kind Storage                        
}


$subnetName = "demo02-subnet"
$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix 10.0.0.0/24
Write-Host "Subnet created"


$virtualNetworkName = "demo02-virtual-network"
$virtualNetwork = New-AzureRmVirtualNetwork `
                      -ResourceGroupName $resourceGroupName `
                      -Location $location `
                      -Name $virtualNetworkName `
                      -Subnet $subnet `
                      -AddressPrefix 10.0.0.0/16

Write-Host "Virtual network created"

$publicIpAddressName = "demo02-ip-address"
$publicIpAddress = New-AzureRmPublicIpAddress `
                        -Name $publicIpAddressName `
                        -ResourceGroupName $resourceGroupName `
                        -Location $location `
                        -AllocationMethod Dynamic # -DomainNameLabel - # Test-AzureRmDnsAvailability -Location $location -DomainNameLabel myvm1

$networkInterfaceName = "demo02-network-interface"
$networkInterface = New-AzureRmNetworkInterface `
                        -Name $networkInterfaceName `
                        -ResourceGroupName $resourceGroupName `
                        -Location $location `
                        -SubnetId $virtualNetwork.Subnets[0].Id `
                        -PublicIpAddressId $publicIpAddress.Id

Write-Host "Network interface created"


$vmAdminLoginName = "CptStudent"
$vmAdminPassword = "pass@word1234"
$vmAdminSecurePassword = ConvertTo-SecureString –String $vmAdminPassword –AsPlainText -Force
$vmAdminCredentials = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $vmAdminLoginName, $vmAdminSecurePassword

$vmName = "demo02-virtual-machine"
$vmComputerName = "devbox"

$vm = New-AzureRmVMConfig -VMName $vmName -VMSize "Standard_DS1_v2"

Write-Host "Called New-AzureRmVMConfig"

$vm = Set-AzureRmVMOperatingSystem `
        -VM $vm `
        -Windows `
        -ComputerName $vmComputerName `
        -Credential $vmAdminCredentials `
        -ProvisionVMAgent `
        -EnableAutoUpdate

Write-Host "called Set-AzureRmVMOperatingSystem"

# $vmImage = Get-AzureRmVMImage -Location $location -PublisherName "MicrosoftSQLServer" -Offer "SQL2016-WS2012R2" -Skus "Enterprise"

# $vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName "MicrosoftSQLServer" -Offer "SQL2016-WS2012R2" -Skus "Enterprise" -Version "13.0.31640"
# $vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName "MicrosoftSharePoint" -Offer "MicrosoftSharePointServer" -Skus "2016" -Version "16.0.4354"
# $vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName "MicrosoftVisualStudio" -Offer "VisualStudio" -Skus "VS-2015-Ent-AzureSDK-2.9-WS2012R2" -Version "50.0.14"

$vm = Set-AzureRmVMSourceImage `
            -VM $vm `
            -PublisherName "MicrosoftVisualStudio" `
            -Offer "VisualStudio" `
            -Skus "VS-2015-Ent-AzureSDK-2.9-WS2012R2" `
            -Version "50.0.14"

Write-Host "Called Set-AzureRmVMSourceImage"

$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $networkInterface.Id

Write-Host "Called Add-AzureRmVMNetworkInterface"

$vhdFileName = "myOsDisk1"
$vhdPath = "vhds/"  + $vhdFileName + ".vhd"
$osDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + $vhdPath

$vm = Set-AzureRmVMOSDisk `
        -VM $vm `
        -Name $vhdFileName `
        -VhdUri $osDiskUri `
        -CreateOption fromImage

Write-Host "Called Set-AzureRmVMOSDisk"

New-AzureRmVM -ResourceGroupName $resourceGroupName -Location $location -VM $vm

Write-Host "Called New-AzureRmVM"

