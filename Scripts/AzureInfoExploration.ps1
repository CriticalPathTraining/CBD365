cls

# update this script with your user name and password
$user = "student@pbibc.onMicrosoft.com"
$pwd = "password1"

$securePassword = ConvertTo-SecureString –String $pwd –AsPlainText -Force

$credential = New-Object –TypeName System.Management.Automation.PSCredential `
                         –ArgumentList $user, $securePassword

Connect-MsolService -Credential $credential

Write-Host("Account SKUs")
Get-MsolAccountSku | Format-Table SkuId, AccountName, SkuPartNumber, AccountSkuId, ActiveUnits, ConsumedUnits


Write-Host
Write-Host("Subscriptions for current user")
Get-MsolSubscription | Format-Table ObjectId, SkuId, SkuPartNumber, Status, IsTrial

Write-Host
Write-Host("Info on company associated with current tenancy")
Get-MsolCompanyInformation | Format-List ObjectId, DisplayName, InitialDomain, TechnicalNotificationEmails