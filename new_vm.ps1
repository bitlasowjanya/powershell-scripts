function new_vm(){

    param(
        [Parameter(Mandatory=$True,Position=1)]
        [string]$Rgp,
        [Parameter(Mandatory=$True,Position=2)]
        [string]$loc,
        [Parameter(Mandatory=$True,Position=3)]
        [string]$subNet_name,
        [Parameter(Mandatory=$True,Position=4)]
        [string]$vNet_name,
        [Parameter(Mandatory=$True,Position=5)]
        [string]$ip_name,
        [Parameter(Mandatory=$True,Position=6)]
        [string]$inbound_rule1,
        [Parameter(Mandatory=$True,Position=7)]
        [string]$inbound_rule2,
        [Parameter(Mandatory=$True,Position=8)]
        [string]$nsg_name,
        [Parameter(Mandatory=$True,Position=9)]
        [string]$nic_name,
        [Parameter(Mandatory=$True,Position=10)]
        [string]$stg_name,
        [Parameter(Mandatory=$True,Position=11)]
        [string]$vm_name,
        [Parameter(Mandatory=$True,Position=12)]
        [string]$comp_name,
        [Parameter(Mandatory=$True,Position=13)]
        [string]$sku_name
        )

New-AzureRmResourceGroup -Name $Rgp -Location $loc

$subnet=New-AzureRmVirtualNetworkSubnetConfig -Name $subNet_name -AddressPrefix 10.0.0.0/24 

$Vrtualnetwork=New-AzureRmVirtualNetwork -Name $vNet_name -ResourceGroupName $Rgp -Location $loc -AddressPrefix 10.0.0.0/16 -Subnet $subnet

$IPaddr=New-AzureRmPublicIpAddress -Name $ip_name -ResourceGroupName $Rgp -Location $loc -AllocationMethod Dynamic

$inboundrule1=New-AzureRmNetworkSecurityRuleConfig -Name $inbound_rule1 -Description "Allow Rule" -Protocol Tcp -Access Allow -SourcePortRange * -DestinationPortRange 3389 -Priority 100 -Direction Inbound -SourceAddressPrefix * -DestinationAddressPrefix *
$inboundrule2=New-AzureRmNetworkSecurityRuleConfig -Name $inbound_rule2 -Description "Allow Rule" -Protocol Tcp -Access Allow -SourcePortRange * -DestinationPortRange 80 -Priority 101 -Direction Inbound -SourceAddressPrefix * -DestinationAddressPrefix *
#$outbound_rule=New-AzureRmNetworkSecurityRuleConfig -Name "Rdp_rule" -Description "Allow Rule" -Protocol Tcp -SourcePortRange * -DestinationPortRange 80 -Access Allow -Priority 100 -Direction Outbound
 
$NSG=New-AzureRmNetworkSecurityGroup -Name $nsg_name -ResourceGroupName $Rgp -Location $loc -SecurityRules $inboundrule1,$inboundrule2

$nic=(Get-AzureRmVirtualNetwork -Name $vNet_name -ResourceGroupName $Rgp).Subnets   
New-AzureRmNetworkInterface -Name $nic_name -ResourceGroupName $Rgp -Location $loc -SubnetId $nic.Id | select id
$nic_id=(Get-AzureRmNetworkInterface -Name $nic_name -ResourceGroupName $Rgp).Id.ToString() 

#$stg_Acc=New-AzureRmStorageAccount -ResourceGroupName $Rgp -Name $stg_name -Location $loc -SkuName Standard_LRS -Kind Storage

$credential=Get-Credential
$vmconfig=New-AzureRmVMConfig -VMName $vm_name -VMSize "Standard_B1s" | `
Set-AzureRmVMOperatingSystem -Windows -ComputerName $comp_name -ProvisionVMAgent -EnableAutoUpdate  -Credential $credential | `
Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus $sku_name -Version "latest" | ` 
Add-AzureRmVMNetworkInterface -Id $nic_id


$VirtualMachine = New-AzureRmVM -ResourceGroupName $Rgp -Location $loc -VM $vmconfig 

}

 new_vm -Rgp "testRsgp01" -loc "Central US" -subNet_name "testSnet01" -vNet_name "testvnet01" -ip_name "dynamicIp" -inbound_rule1 "rdp_rule" -inbound_rule2 "http" `
 -nsg_name "testNsg01" -nic_name "testnic01" -stg_name "teststg01" -vm_name "testServer01" -comp_name "winServer" -sku_name "2016-Datacenter" 
  
   