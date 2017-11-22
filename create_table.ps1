function table(){

    param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$Rgp,
        [Parameter(Mandatory=$True,Position=2)]
        [string]$stgAcc,
        [Parameter(Mandatory=$True,Position=3)]
        [string]$tablename,
        [Parameter(Mandatory=$True,Position=4)]
        [string]$Partionkey="",
        [Parameter(Mandatory=$True,Position=5)]
        [string]$rowkey="",
        [Parameter(Mandatory=$True,Position=6)]
        $table_pararmeters=@()
        )

    $tab = Get-AzureRmStorageAccount -ResourceGroupName "$Rgp" -Name "$stgAcc"  | `
    Get-AzureStorageTable -Name "$table_name" 

    Add-StorageTableRow -table $tab -partitionKey $Partionkey -rowKey $rowkey -property $table_pararmeters
     
}

 table -Rgp "myTestRg003" -stgAcc "mysamplestoacc002" -tablename "TestTable" -Partionkey "Teacher" -rowkey "105" -table_pararmeters @{"Student_Name"="Sandy";"Class"=8;"Section"="B";  `
 "English"=75;"Math"=86;"Science"=92;"Social"=86;"Total_Workingdays"=90;"Total_presentdays"=83}

