#############################################################################
##
## Install Active Directory Services, tooling, and DNS Server.
##
#############################################################################

# Remote Server Administration Tools (RSAT)
Write-Host "Installing Remote Server Administration Tools (RSAT)...."
Add-WindowsFeature "RSAT-AD-Tools"

# Active Directory Domain Services
Write-Host "Installing AD Domain Services..."
Install-WindowsFeature AD-domain-services -IncludeAllSubFeature -IncludeManagementTools

# DNS Server
Write-Host "Installing DNS Server..."
Install-WindowsFeature Dns -IncludeAllSubFeature -IncludeManagementTools

# Group Policy Management
Write-Host "Installing Group Policy Management (GPMC)..."
Install-WindowsFeature GPMC -IncludeAllSubFeature -IncludeManagementTools

dnscmd $env:COMPUTERNAME /ResetListenAddresses ((Get-NetIPAddress -InterfaceAlias "Ethernet_Lab" -AddressFamily IPv4).IPAddress)

