cls

$tenantName = "LabsForCBD365"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential

#Set Azure location
$locName = "southcentralus"

#Assign variables
$rgName="Lab01"
$vnetName = "HQ-VNET"
$subnetName = "DATABASE"
$vmName = "ResDevDB2"
$vmSize = "Standard_A1"
$pubName="MicrosoftWindowsServer"
$offerName="WindowsServer"
$skuName="2012-R2-Datacenter"
$nicName="resdevdb2"
$diskName="OSDisk"


$storageAcc = Get-AzureRmStorageAccount



#Set Virtual network and Subnet
$vnet = Get-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $rgName
foreach ($subnet in $vnet.subnets)
{
    if ($subnet.name -eq $subnetName)
    {
        $subnetid = $subnet.Id        
    }
}

#Create PIP and NIC
$pip = New-AzureRmPublicIpAddress -Name $nicName -ResourceGroupName $rgName -Location $locName -AllocationMethod Dynamic
$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -Location $locName -SubnetId $subnetid -PublicIpAddressId $pip.Id

#Set VM Configuration
$vm=New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize
$vm=Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id
$vm=Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred 
$vm=Set-AzureRmVMSourceImage -VM $vm -PublisherName $pubName -Offer $offerName -Skus $skuName -Version "latest"

$osDiskUri=$storageAcc.PrimaryEndpoints.Blob.ToString() + "vhds/" + $vmName + $diskName  + ".vhd"
$vm=Set-AzureRmVMOSDisk -VM $vm -Name $diskName -VhdUri $osDiskUri -CreateOption fromImage

#Create the VM
New-AzureRmVM -ResourceGroupName $rgName -Location $locName -VM $vm