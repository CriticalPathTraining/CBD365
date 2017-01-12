cls
$tenantName = "LabsForCBD365"
$tenantAdminAccountName = "Student"
$tenantDomain = $tenantName + ".onMicrosoft.com"
$tenantAdminSPN = $tenantAdminAccountName + "@" + $tenantDomain

$credential = Get-Credential -UserName $tenantAdminSPN -Message "Enter password"
Login-AzureRmAccount -Credential $credential | Out-Null

$publishers = "MicrosoftWindowsServer", "MicrosoftVisualStudio", "MicrosoftSQLServer", "MicrosoftSharePoint", "MicrosoftRServer"

$location = "southcentralus"

"Azure VM Image SKUs" | Out-File "AzureVmImageSkus.txt"

foreach($publisher in $publishers){
  $offers = Get-AzureRmVMImageOffer -Location $location -PublisherName $publisher
  foreach($offer in $offers){
    $Skus  = Get-AzureRmVMImageSku -Location $location -PublisherName $publisher -Offer $offer.Offer 
    foreach($Sku in $Skus){
        $vmImages = Get-AzureRmVMImage -Location $location -PublisherName $Sku.PublisherName -Offer $Sku.Offer -Skus $Sku.Skus | Format-Table PublisherName, Offer, Skus, Version
        $vmImages 
        $vmImages | Out-File "AzureVmImageSkus.txt" -Append
    }

    
  }
}

