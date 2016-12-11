function New-Student($username, $password, $displayName, $alternateEmail) {

    # Get the tenant name (license prefix).
    $tenant = (Get-MsolAccountSku)[0].AccountSkuId.Split(":")[0]
    $userSPN = $username + "@" + $tenant + ".onMicrosoft.com"

    Write-Host "Creating new Office 365 user account for $userSPN"

    # if using E3 licenses
    # $license = $tenant + ":ENTERPRISEPACK"

    # if using E5 licenses
    $license = $tenant + ":ENTERPRISEPREMIUM"

  
    # Create the user
    New-MsolUser -UserPrincipalName $userSPN `
                 -DisplayName $displayName `
                 -UsageLocation "US" `
                 -UserType Member `
                 -LicenseAssignment $license `
                 -AlternateEmailAddresses $alternateEmail `
                 -Password $password `
                 -PasswordNeverExpires $true

}

cls


$tenantName = "LabsForCBD365"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Connect-MsolService -Credential $credential


# New-Student -username "JamesB" -password  "pass@word1" -displayName "James Bond" -alternateEmail "Agent007@aol.com"

New-Student -username "FrankB" -password  "pass@word1" -displayName "Frank Burns" -alternateEmail "fb007@aol.com"
