function New-Student($username, $password, $displayName, $alternateEmail) {

    # Get the tenant name (license prefix).
    $tenant = (Get-MsolAccountSku)[0].AccountSkuId.Split(":")[0]

    # if using E3 licenses
    # $license = $tenant + ":ENTERPRISEPACK"

    # if using E5 licenses
    $license = $tenant + ":ENTERPRISEPREMIUM"

  
    # Create the user
    New-MsolUser -UserPrincipalName $username `
                 -DisplayName $displayName `
                 -UsageLocation "US" `
                 -UserType Member `
                 -LicenseAssignment $license `
                 -AlternateEmailAddresses $alternateEmail `
                 -Password $password `
                 -PasswordNeverExpires $true

}

cls

$cred = Get-Credential
Connect-MsolService -Credential $cred

#New-Student -username "User123@YOUR_TENANT.onmicrosoft.com" -password  "Password1" -displayName "User 123" -alternateEmail "john.doe@contoso.com"

New-Student -username "User1@CBD365.onmicrosoft.com" `
            -password  "pass@word1" `
            -displayName "User Uno" `
            -alternateEmail "uu@contoso.com"
