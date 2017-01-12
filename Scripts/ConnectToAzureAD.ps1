cls

$user = "Student@CptLabs.onMicrosoft.com"
$pwd = "pass@word1"


$securePassword = ConvertTo-SecureString –String $pwd –AsPlainText -Force

$credential = New-Object –TypeName System.Management.Automation.PSCredential `
                         –ArgumentList $user, $securePassword

Connect-MsolService -Credential $credential

Get-MsolCompanyInformation  | Format-Table DisplayName, PreferredLanguage, CountryLetterCode

Get-MsolAccountSku | Format-Table SkuPartNumber

Get-MsolSubscription

Get-MsolUser | Format-Table ObjectId, UserPrincipalName, DisplayName, Licenses