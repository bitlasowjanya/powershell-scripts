


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
    New-AzureStorageContainer -Name "$container" -Permission Blob | `
    Set-AzureStorageBlobContent -Container "$container" -File "$fileName" -BlobType Block


}


uploadBlob -Rgp "myTestRg003" -stgAcc "mysamplestoacc002" -container "mytestcontainer004" -fileName "C:\D\sowjanya\testxml.xml"