
function fileShare(){

    param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$Rgp,
        [Parameter(Mandatory=$True,Position=2)]
        [string]$stgAcc,
        [Parameter(Mandatory=$True,Position=3)]
        [string]$fileShare
        )

Get-AzureRmStorageAccount -ResourceGroupName "$Rgp" -Name "$stgAcc" | ` 
New-AzureStorageShare -Name "$fileShare"
}


fileShare -Rgp "myTestRg003" -stgAcc "mysamplestoacc002" -fileShare "testfile"