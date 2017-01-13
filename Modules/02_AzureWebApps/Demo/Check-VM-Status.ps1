cls
$tenantName = "[YOUR TENANT]"
$tenantAdminAccountName = "[YOUR USER ACCOUNT]"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$location = "southcentralus" 
$resourceGroupName = "lab02-vm"

# establish login
$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null

$resourceGroups = Get-AzureRmResourceGroup 

foreach($group in $resourceGroups){
  $VMs = Get-AzureRmVM -ResourceGroupName $group.ResourceGroupName
  foreach($vm in $VMs){
    $vmDetail = Get-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vm.Name -Status
    foreach ($vmStatus in $vmDetail.Statuses) { 
        if($vmStatus.Code -like "*PowerState*") {
            $vmStatus = $vmStatus.DisplayStatus
            Write-Host "VM named" $vm.Name "has a status of" $vmStatus 
        }
    }
  }  
}