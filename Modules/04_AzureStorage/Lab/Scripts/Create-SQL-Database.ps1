cls
$tenantName = "cpt0814"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null
#Add-AzureAccount -Credential $credential

$location = "southcentralus" 

$resourceGroupName = "sql-databases"

$resourceGroup = Get-AzureRmResourceGroup -Name $resourceGroupName -ErrorAction Ignore

# Create group if it does't exist
if(!$resourceGroup){
  Write-Host "Resource group named" $resourceGroupName "does not exist - now creating it"
  $resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
}

$sqlServerName = "cpt0814"
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
            -AllowAllAzureIPs `
            -StartIpAddress 0.0.0.0 `
            -EndIpAddress 255.255.255.255 `
            -ServerName $sqlServerName `
            -ResourceGroupName $resourceGroupName

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




