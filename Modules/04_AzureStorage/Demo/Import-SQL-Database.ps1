cls
$tenantName = "LabsForCBD365"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null

$location = "southcentralus" 

$resourceGroupName = "demo05"

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction Ignore

# Create group if it does't exist
if(!$resourceGroup){
  Write-Host "Resource group named" $resourceGroupName "does not exist - now creating it"
  $resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
}

$sqlServerName = "cptlab05"
$sqlServerVersion = "12.0"

$sqlServerAdminLogin = "CptStudent"
$sqlServerAdminPassword = "pass@word1234"
$sqlServerSecureAdminPassword = ConvertTo-SecureString –String $sqlServerAdminPassword –AsPlainText -Force
$sqlServerAdminCredentials = New-Object `
                                –TypeName System.Management.Automation.PSCredential `
                                –ArgumentList $sqlServerAdminLogin, $sqlServerSecureAdminPassword

$sqlServer = Get-AzureRmSqlServer `
                    -ServerName $sqlServerName `
                    -ResourceGroupName $resourceGroupName `
                    -ea SilentlyContinue

if(!$sqlServer) {
   
   Write-Output "Creating SQL server: $serverName"
   $sqlServer = New-AzureRmSqlServer `
                    -ResourceGroupName $resourceGroupName `
                    -ServerName $sqlServerName `
                    -Location $location `
                    -ServerVersion $sqlServerVersion `
                    -SqlAdministratorCredentials $sqlServerAdminCredentials

                    
    New-AzureRmSqlServerFirewallRule `
            -FirewallRuleName "AllowAll" `
            -StartIpAddress 0.0.0.0 `
            -EndIpAddress 255.255.255.255 `
            -ServerName $sqlServerName `
            -ResourceGroupName $resourceGroupName

}

$sqlServer | select ServerName, SqlAdministratorLogin

$sqlServerUrl = $sqlServerName + ".database.windows.net"
Write-Host "SQL Server URL:" $sqlServerUrl 

$sqlDatabaseName = "WingtipSalesDB"
$sqlDatabaseEdition = "Basic"
$sqlDatabaseServiceLevel = "Basic"

$sqlDatabase = Get-AzureRmSqlDatabase -DatabaseName $sqlDatabaseName -ServerName $sqlServerName -ResourceGroupName $resourceGroupName -ErrorAction SilentlyContinue
if(!$sqlDatabase){

    $storageAccountName = "cptsqllab05"
    $storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -ErrorAction Ignore
    if(!$storageAccount){
        # ensure storage account name is not in use
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


    $storageKeyType = "StorageAccessKey"
    $storageUri = $storageAccount.PrimaryEndpoints.Blob
    $storageKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName)[0].Value

    $storageContext = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageKey

    $storageContainerName = "sql"
    $storageContainer = Get-AzureStorageContainer -Name $storageContainerName -Context $storageContext -ErrorAction SilentlyContinue

    if(!$storageContainer){
        New-AzureStorageContainer -Name $storageContainerName -Context $storageContext -Permission Blob
    }

    $sqlDatabaseImportFileName = "WingtipSalesDB.bacpac"
    $sqlDatabaseImportFilePath = $PSScriptRoot + "/" + $sqlDatabaseImportFileName
    $sqlDatabaseImportFile 
    $blob = Set-AzureStorageBlobContent -File $sqlDatabaseImportFilePath -Container $storageContainerName -Blob $sqlDatabaseImportFileName -Context $storageContext -Force

    $blob | select *

    $sqlDatabaseImportFileUri = $storageAccount.PrimaryEndpoints.Blob + $storageContainerName + "/" + $sqlDatabaseImportFileName
    
    $importRequest = New-AzureRmSqlDatabaseImport `
                        –ResourceGroupName $resourceGroupName `
                        –ServerName $sqlServerName `
                        –DatabaseName $sqlDatabaseName `
                        –StorageKeytype $storageKeyType `
                        –StorageKey $storageKey `
                        -StorageUri $sqlDatabaseImportFileUri `
                        –AdministratorLogin $sqlServerAdminLogin `
                        –AdministratorLoginPassword $sqlServerSecureAdminPassword `
                        –Edition $sqlDatabaseEdition `
                        –ServiceObjectiveName $sqlDatabaseServiceLevel `
                        -DatabaseMaxSizeBytes 5000000


    Do {
        $importStatus = Get-AzureRmSqlDatabaseImportExportStatus -OperationStatusLink $importRequest.OperationStatusLink
        Write-host "Importing database..." $importStatus.StatusMessage
        Start-Sleep -Seconds 5
        $importStatus.Status
    }
    until ($importStatus.Status -eq "Succeeded")
        
    $importStatus

}

    

    
