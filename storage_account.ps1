function storage_account(){

    param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$rgp,
        [Parameter(Mandatory=$True,Position=2)]
        [string]$stg_name,
        [Parameter(Mandatory=$True,Position=3)]
        [string]$location
         )


    New-AzureRmStorageAccount $rgp -Name $stg_name -SkuName Standard_LRS -Location $location -Kind Storage 
}

storage_account -rgp "myTestRg003" -stg_name "data002" -location "central us"