#Vnet
$VN = "$ENV:VNET_NAME"
#Resource Group
$RG = "$ENV:RESOURCEGROUP_NAME"
#Subnet
$SN = "$ENV:SUBNET_NAME"
#Subnet Address Prexifx
$SAP = "$ENV:ADDRESS_PREFIX"
#ServiceEndpoint
$EP = "$ENV:SERVICE_ENDPOINT" 

Write-Host "Importing the AzureRM module into the PowerShell session"
Import-Module AzureRM

Write-Host "Connect service principle account to Azure RM"
Connect-AzureRmAccount -ServicePrincipal -Credential $CREDS -TenantId $TID -Subscription $SID

<# In case service principal is not availale, use the below

Connect-AzureRmAccount
Select-AzureRmSubscription -SubscriptionName "XXXX" #>

#Get vnet
$VirtualNetwork = Get-AzureRmVirtualNetwork -ResourceGroupName $RG -Name $VN |  Get-AzureRmVirtualNetworkSubnetConfig -Name $SN

#Get existing service endpoints
$ServiceEndPoint = New-Object 'System.Collections.Generic.List[String]'
$VirtualNetwork.ServiceEndpoints | ForEach-Object { $ServiceEndPoint.Add($_.service) }
$ServiceEndPoint.Add($EP)

#Add new service endpoint
Get-AzureRmVirtualNetwork -ResourceGroupName $RG -Name $VN | Set-AzureRmVirtualNetworkSubnetConfig -Name $SN  -AddressPrefix $SAP -ServiceEndpoint $ServiceEndPoint | Set-AzureRmVirtualNetwork