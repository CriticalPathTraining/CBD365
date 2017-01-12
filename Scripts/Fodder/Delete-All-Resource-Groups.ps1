cls
foreach ($group in Get-AzureRMResourceGroup) {
  if ($group) {
    Write-Host "Deleting " $group.ResourceGroupName "resource group..."
    Remove-AzureRMResourceGroup -Name $group.ResourceGroupName -Force
  }
}