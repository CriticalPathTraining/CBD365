cls

# Create new resource group
$location = "southcentralus" # centralus eastus eastus2 westus northcentralus southcentralus westcentralus westus2           
$resourceGroup = "Lab01"
New-AzureRmResourceGroup -Name $resourceGroup -Location $location


# Create new storage account
$storageAccountName = "bigdaddy4071"
$storageAccountType = "Standard_LRS" 
New-AzureRmStorageAccount -Name $storageAccountName -ResourceGroupName $resourceGroup –Type $storageAccountType -Location $location

# Reconfigure storage account with a different type
$storageAccountType2 = "Standard_GRS"
Set-AzureRmStorageAccount -Name $storageAccountName -ResourceGroupName $resourceGroup –Type $storageAccountType2
