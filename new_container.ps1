function new_container(){

    param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$rgp,
        [Parameter(Mandatory=$True,Position=2)]
        [string]$stg_acc,
        [Parameter(Mandatory=$True,Position=3)]
        [string]$container_name
         )

Get-AzureRmStorageAccount -ResourceGroupName $rgp -Name $stg_acc | ` 
New-AzureStorageContainer -Name $container_name -Permission Blob 
}

new_container -rgp "myTestRg003" -stg_acc "data002" -container_name "testcontainer006" 