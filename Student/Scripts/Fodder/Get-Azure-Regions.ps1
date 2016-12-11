Clear-Host
Write-Host "Azure Data Center Locations"
Get-AzureRmLocation | Format-Table Location #, DisplayName