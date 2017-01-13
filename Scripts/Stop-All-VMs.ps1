cls
$tenantName = "[YOUR TENANT]"
$tenantAdminAccountName = "[YOUR USER ACCOUNT]"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

# establish login
$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null

foreach($group in Get-AzureRmResourceGroup){
  foreach($vm in Get-AzureRmVM -ResourceGroupName $group.ResourceGroupName){
    Write-Host "Stopping VM named" $vm.Name "..." 
    Stop-AzureRmVM -ResourceGroupName $resourceGroupName -Name $vm.Name -Force
  }  
}

Write-Host "All VMs have been stopped" 
