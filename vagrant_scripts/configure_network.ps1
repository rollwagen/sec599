
Param (
    $IPAddress = "192.168.5.5",
    $Netmask = "16",
    $DnsServerAddress = ""
    
)

# Get interface to configure.
# Per default Vagrant needs first ethernet interface in NAT mode.
# Second ethernet interface (name 'Ethernet1') can't be
# automatically configured by Vagrant, hence this script.

$NetIPAddress = Get-NetIPAddress  | Where-Object {$_.InterfaceAlias -Like "Ethernet1*" -and $_.AddressFamily -eq "IPv4"}
$InterfaceIndex = $NetIPAddress.InterfaceIndex

Write-Host "Setting IP address to  $($IPAddress) / $($Netmask) ..."
New-NetIPAddress -InterfaceIndex $InterfaceIndex -IPAddress $IPAddress -PrefixLength $Netmask

if ($env:COMPUTERNAME -like "DC*" -or $DnsServerAddress -eq "") {
    Write-Host "Skipping setting DNS server."
} else {
    Write-Host "Setting DNS server to $($DnsServerAddress) ..."
    Set-DnsClientServerAddress -InterfaceIndex $InterfaceIndex -ServerAddress $DnsServerAddress
}