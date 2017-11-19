function uploadBlob(){

    param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$Rgp,
        [Parameter(Mandatory=$True,Position=2)]
        [string]$stgAcc,
        [Parameter(Mandatory=$True,Position=3)]
        [string]$container,
        [Parameter(Mandatory=$True,Position=4)]
        [string]$fileName
        )


    Get-AzureRmStorageAccount -ResourceGroupName "$Rgp" -Name "$stgAcc" | `
    Get-AzureStorageContainer -Name "$container" | `
    Set-AzureStorageBlobContent -Container "$container" -File "$fileName" -BlobType Block


}
uploadBlob -Rgp "myTestRg003" -stgAcc "mysamplestoacc002" -container "mytestcontainer002" -fileName "C:\D\aws-login.ppk"