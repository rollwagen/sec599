#############################################################################
##
## Join a member server to the Active Directory Domain.
##
#############################################################################


Param (
    $DCIPAddress = "192.168.5.5",
    $DomainName  = "seclabs.lab",
    $NetbiosName = "SECLABS"
    # Ethernet interface name lab '"Ethernet_Lab"'
    # $DomainAdminPassword = "Admin123"
)

Write-Host "Start joining AD domain..."
$Password = "Admin123" | ConvertTo-SecureString -asPlainText -Force
$Username = "Administrator" 
$Credential = New-Object PSCredential($Username, $Password)
Add-Computer -DomainName $DomainName -Credential $Credential
Write-Host "End joining AD domain..."

Write-Host "Restarting computer..."
Restart-Computer -Force