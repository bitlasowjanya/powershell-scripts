function table(){

    param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$Rgp,
        [Parameter(Mandatory=$True,Position=2)]
        [string]$stgAcc,
        [Parameter(Mandatory=$True,Position=3)]
        [string]$tableName
        )

Get-AzureRmStorageAccount -ResourceGroupName "$Rgp" -Name "$stgAcc" | `
New-AzureStorageTable -Name "$tableName" 
}
table -Rgp "myTestRg003" -stgAcc "mysamplestoacc002" -tableName "table002"