
$tenantAdminAccountName = "_YOUR_ACCOUNT_NAME_"
$tenantName = "_YOUR_TENANT_NAME_"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$location = "southcentralus" 
$resourceGroupName = "sql-databases"

$sqlServerName = "_YOUR_SQL_SERVER_NAME_"
$sqlServerVersion = "12.0"
$sqlServerAdminLogin = "CptStudent"
$sqlServerAdminPassword = "pass@word1234"

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null


$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction Ignore

# Create group if it does't exist
if(!$resourceGroup){
  Write-Host "Resource group named" $resourceGroupName "does not exist - now creating it"
  $resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
}

$sqlServerSecureAdminPassword = ConvertTo-SecureString –String $sqlServerAdminPassword –AsPlainText -Force
$sqlServerAdminCredentials = New-Object `
                                –TypeName System.Management.Automation.PSCredential `
                                –ArgumentList $sqlServerAdminLogin, $sqlServerSecureAdminPassword

$sqlServer = Get-AzureRmSqlServer `
                    -ServerName $sqlServerName `
                    -ResourceGroupName $resourceGroupName `
                    -ea SilentlyContinue

if(!$sqlServer) {
   
   Write-Output "Creating SQL server: $sqlServerName"
   $sqlServer = New-AzureRmSqlServer `
                    -SqlAdministratorCredentials $sqlServerAdminCredentials `
                    -ResourceGroupName $resourceGroupName `
                    -ServerName $sqlServerName `
                    -Location $location `
                    -ServerVersion $sqlServerVersion                    

    # open up all inbound traffic                
    New-AzureRmSqlServerFirewallRule `
            -FirewallRuleName "AllowAll" `
            -StartIpAddress 0.0.0.0 `
            -EndIpAddress 255.255.255.255 `
            -ServerName $sqlServerName `
            -ResourceGroupName $resourceGroupName

    # allow access from other azure services
    New-AzureRmSqlServerFirewallRule `
            -ServerName $sqlServerName `
            -ResourceGroupName $resourceGroupName `
            -AllowAllAzureIPs
}

$sqlServer | select ServerName, SqlAdministratorLogin

$sqlServerUrl = $sqlServerName + ".database.windows.net"
Write-Host "SQL Server URL:" $sqlServerUrl 

$sqlDatabaseName = "ProductsDB"
$sqlDatabaseEdition = "Basic"
$sqlDatabaseServiceLevel = "Basic"

$sqlDatabase = Get-AzureRmSqlDatabase -DatabaseName $sqlDatabaseName -ServerName $sqlServerName -ResourceGroupName $resourceGroupName -ErrorAction SilentlyContinue
if(!$sqlDatabase){
    $sqlDatabase = New-AzureRmSqlDatabase `
                        -DatabaseName $sqlDatabaseName `
                        -ServerName $sqlServerName `
                        -ResourceGroupName $resourceGroupName `
                        -Edition $sqlDatabaseEdition `
                        -RequestedServiceObjectiveName $sqlDatabaseServiceLevel


    $connectionString =  "Data Source=" + $sqlServerUrl + ";"
    $connectionString += "Initial Catalog=" + $sqlDatabaseName + ";"
    $connectionString += "User ID=" + $sqlServerAdminLogin + ";" 
    $connectionString += "Password=" + $sqlServerAdminPassword + ";"
    $connectionString += "Connection Timeout=90"

    $connection = New-Object -TypeName System.Data.SqlClient.SqlConnection($connectionString)

    $queryCreateTables = [IO.File]::ReadAllText($PSScriptRoot + "\CreateProductsTable.sql")

    $command = New-Object -TypeName System.Data.SqlClient.SqlCommand($queryCreateTables, $connection)
    $connection.Open()
    $command.ExecuteNonQuery()
    $connection.Close()
}


$sqlDatabase | select *
