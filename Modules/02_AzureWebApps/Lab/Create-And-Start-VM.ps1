cls
$tenantName = "pbibc"
$tenantAdminAccountName = "student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$location = "southcentralus" 
$resourceGroupName = "lab02-vm"

$storageAccountName = "lab02storage"
$subnetName = "lab02-subnet"
$virtualNetworkName = "lab02-vnet"
$networkInterfaceName = "lab02-nic"
$publicIpAddressName = "lab02-publicIP"
$domainNameLabel = "lab02vm"

$vmName = "lab02-virtual-machine"
$vmComputerName = "devbox"
$vmAdminLoginName = "CptStudent"
$vmAdminPassword = "pass@word1234"
$vhdFileName = "lab02-vm-disk1"
$vmSize = "Basic_A2"

$publisherName = "MicrosoftVisualStudio"
$offer = "VisualStudio"
$sku = "VS-2015-Comm-VSU3-AzureSDK-29-Win10-N"
$version = "2017.11.16"


$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null

# Create group if it does't exist
$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction Ignore
if(!$resourceGroup){
  Write-Host "Resource group named" $resourceGroupName "does not exist - now creating it"
  $resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
}

# Process for creating web app
$storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -ErrorAction Ignore
if(!$storageAccount){
    # ensure web app name is not in use
    $originalName = $storageAccountName
    $counter = 0

    while( (Get-AzureRmStorageAccountNameAvailability -Name $storageAccountName).NameAvailable -eq $false ){
        Write-Host "Storage account name $storageAccountName already in use"
        $counter += 1
        $storageAccountName = $originalName + $counter
    }

    Write-Host "Calling New-AzureRmStorageAccount to create a storage account named $storageAccountName"
    $storageAccount = New-AzureRmStorageAccount `
                        -Location $location `
                        -ResourceGroupName $resourceGroupName `
                        -Name $storageAccountName `
                        -SkuName Standard_LRS `
                        -Kind Storage                        
}

Write-Host "Calling New-AzureRmVirtualNetworkSubnetConfig to create subnet named $subnetName"
$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix 10.0.0.0/24


Write-Host "Calling New-AzureRmVirtualNetwork to create Virtual network name $virtualNetworkName"
$virtualNetwork = New-AzureRmVirtualNetwork `
                      -ResourceGroupName $resourceGroupName `
                      -Location $location `
                      -Name $virtualNetworkName `
                      -Subnet $subnet `
                      -AddressPrefix 10.0.0.0/16 `
                      -WarningAction SilentlyContinue


$counter = 0
$originalName = $domainNameLabel
while( (Test-AzureRmDnsAvailability -Location $location -DomainNameLabel $domainNameLabel) -eq $false ){
    Write-Host "domain label name $domainNameLabel already in use"
    $counter += 1
    $domainNameLabel = $originalName + $counter
}

Write-Host "Calling New-AzureRmPublicIpAddress to create static public IP address with domain label name of $domainNameLabel"
$publicIpAddress = New-AzureRmPublicIpAddress `
                        -Name $publicIpAddressName `
                        -ResourceGroupName $resourceGroupName `
                        -Location $location `
                        -AllocationMethod Static `
                        -DomainNameLabel $domainNameLabel `
                        -WarningAction SilentlyContinue

Write-Host "Calling New-AzureRmNetworkInterface to create network interface named $networkInterfaceName"
$networkInterface = New-AzureRmNetworkInterface `
                        -Name $networkInterfaceName `
                        -ResourceGroupName $resourceGroupName `
                        -Location $location `
                        -SubnetId $virtualNetwork.Subnets[0].Id `
                        -PublicIpAddressId $publicIpAddress.Id `
                        -WarningAction SilentlyContinue


# create sign-in credentials for VM
$vmAdminSecurePassword = ConvertTo-SecureString –String $vmAdminPassword –AsPlainText -Force
$vmAdminCredentials = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $vmAdminLoginName, $vmAdminSecurePassword

Write-Host "Calling New-AzureRmVMConfig to create new VM configuration with name of $vmName ans size of $vmSize"
$vm = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize

Write-Host "Calling Set-AzureRmVMOperatingSystem to set OS disk for VM"
$vm = Set-AzureRmVMOperatingSystem `
        -VM $vm `
        -Windows `
        -ComputerName $vmComputerName `
        -Credential $vmAdminCredentials `
        -ProvisionVMAgent `
        -EnableAutoUpdate


Write-Host "Calling Set-AzureRmVMSourceImage to configure VM template"
$vm = Set-AzureRmVMSourceImage `
            -VM $vm `
            -PublisherName $publisherName `
            -Offer $offer `
            -Skus $sku `
            -Version $version

Write-Host "Calling Add-AzureRmVMNetworkInterface to configure VM with network connectivity"
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $networkInterface.Id


$vhdPath = "vhds/"  + $vhdFileName + ".vhd"
$osDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + $vhdPath


Write-Host "Calling Set-AzureRmVMOSDisk to configure creating VM from VM image"
$vm = Set-AzureRmVMOSDisk `
        -VM $vm `
        -Name $vhdFileName `
        -VhdUri $osDiskUri `
        -CreateOption fromImage

Write-Host "Calling New-AzureRmVM to create and start VM"
$vm = New-AzureRmVM -ResourceGroupName $resourceGroupName -Location $location -VM $vm

Write-Host "All done - VM has been provisioned"
$vm | select *
