$publishers = "MicrosoftWindowsServer", "MicrosoftVisualStudio", "MicrosoftSQLServer", "MicrosoftSharePoint", "MicrosoftRServer"

$location = "southcentralus"

foreach($publisher in $publishers){
  $offers = Get-AzureRmVMImageOffer -Location $location -PublisherName $publisher
  foreach($offer in $offers){
    Get-AzureRmVMImageSku -Location $location -PublisherName $publisher -Offer $offer.Offer | select * | Format-Table PublisherName, Offer, Skus
  }
}

