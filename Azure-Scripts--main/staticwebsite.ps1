# Set up Azure resources
$resourceGroupName = "myResourceGroup"
$storageAccountName = "mystorageaccount"
$containerName = "mycontainer"
$location = "eastus"

# Create resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location

# Create storage account
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName `
    -Name $storageAccountName -SkuName Standard_LRS `
    -Location $location

# Enable static website
$staticWebsite = Set-AzStorageAccountStaticWebsite -ResourceGroupName $resourceGroupName `
    -AccountName $storageAccountName -IndexDocument index.html -ErrorDocument 404.html

# Create container for website files
New-AzStorageContainer -Name $containerName `
    -Context $staticWebsite.Context -Permission Blob

# Upload website files to container
Set-AzStorageBlobContent -File "path/to/website/files" `
    -Container $containerName -Context $staticWebsite.Context
