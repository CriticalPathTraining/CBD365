cls
$credential = Get-Credential
Connect-MsolService -Credential $credential

Add-AzureAccount 

New-AzureSBNamespace DeveloperTesting "East US 2" -CreateACSNamespace $true -NamespaceType Messaging