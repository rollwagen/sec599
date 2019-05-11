#############################################################################
##
## Configure Network as part of Vagrant provisioning
##
#############################################################################

Param (
    $IPAddress = "192.168.5.5",
    $Netmask = "16",
    $DnsServerAddress = "192.168.5.5"
    # Ethernet interface name for lab "Ethernet_Lab"
)

#
# Detect OS as ethernet interfaces are numbered differntly server vs client it seems.
# e.g. for Windows 10 return "Microsoft Windows 10 Enterprise Evaluation"
#
$os = Get-WmiObject -Class Win32_OperatingSystem | ForEach-Object -MemberName Caption
 
# Get interface to configure.
# Per default Vagrant needs first ethernet interface in NAT mode.
# Second ethernet interface (name 'Ethernet1') can't be
# automatically configured by Vagrant, hence this script.
$InterfaceIndex = -1
if ($os.contains("Windows 10")) {
    $NetIPAddress = Get-NetIPAddress  | Where-Object {$_.InterfaceAlias -Like "Ethernet0*" -and $_.AddressFamily -eq "IPv4" -and $_.PrefixOrigin -ne "Dhcp"}
    $InterfaceIndex = $NetIPAddress.InterfaceIndex
} else {
    $NetIPAddress = Get-NetIPAddress  | Where-Object {$_.InterfaceAlias -Like "Ethernet1*" -and $_.AddressFamily -eq "IPv4"}
    $InterfaceIndex = $NetIPAddress.InterfaceIndex
}

Write-Host "Setting IP address to  $($IPAddress) / $($Netmask) ..."
New-NetIPAddress -InterfaceIndex $InterfaceIndex -IPAddress $IPAddress -PrefixLength $Netmask
Get-NetAdapter -InterfaceIndex $InterfaceIndex  | Rename-NetAdapter -NewName "Ethernet_Lab"

# If Domain Controller (name=DC) then don't setup DNS server.
# (as the DC is the DNS server)
if ($env:COMPUTERNAME -like "DC*" -or $DnsServerAddress -eq "") {
    Write-Host "Skipping setting DNS server."
} else {
    Write-Host "Setting DNS server to $($DnsServerAddress) ..."
    Set-DnsClientServerAddress -InterfaceIndex $InterfaceIndex -ServerAddress $DnsServerAddress
}
