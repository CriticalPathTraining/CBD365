function New-User($username, $password, $displayName, $alternateEmail) {

    Write-Host "Creating new Office 365 user account for $userSPN"

    $tenantDomain = (Get-AzureADTenantDetail)[0].VerifiedDomains[0].Name
    $userSPN = $username + "@" + $tenantDomain

    $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $PasswordProfile.Password = "Pass@word1"

    New-AzureADUser -UserPrincipalName $userSPN `
                     -DisplayName $displayName `
                     -PasswordProfile $PasswordProfile `
                     -MailNickName $username `
                     -UsageLocation "US" `
                     -AccountEnabled $true

    $license = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
    $licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses    
    $licenseServiceName = "ENTERPRISEPREMIUM"  # Office 365 E5 SKU
    
    # Find the SkuID of the license we want to add
    $license.SkuId = (Get-AzureADSubscribedSku | Where-Object -Property SkuPartNumber -Value $licenseServiceName -EQ ).SkuID

    # Add Office license to $licenses object
    $licenses.AddLicenses = $license

    # get ObjectId for user
    $userObjectId = (Get-AzureADUser -ObjectId $userSPN).ObjectId
    
    # Call the Set-AzureADUserLicense cmdlet to set the license.
    Set-AzureADUserLicense -ObjectId $userObjectId -AssignedLicenses $licenses
}

cls

$tenantName = "pbibc"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Connect-AzureAD -Credential $credential

New-User -username "BobB" -password  "pass@word1" -displayName "BobBarker" -alternateEmail "BobB@aol.com"
