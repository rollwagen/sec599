
Import-Module ADDSDeployment

$DomainName  = "seclabs.lab"
$NetbiosName = "SECLABS"
$SafeModeAdminPassword = "Seclabs123"
$DomainAdminPassword = "Admin123"

# Set domain Administrator account password
Write-Host "Setting Domain Admin password..."
$Password = $DomainAdminPassword | ConvertTo-SecureString -asPlainText -Force
Set-LocalUser Administrator -PasswordNeverExpires $true -Password $Password

Write-Host "Start installing Active Directory Forest..." 
Install-ADDSForest `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode "Win2012R2" `
    -DomainName $DomainName `
    -DomainNetbiosName $NetbiosName `
    -ForestMode "Win2012R2" `
    -InstallDns `
    -LogPath "C:\Windows\NTDS\logs" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -safemodeadministratorpassword (ConvertTo-SecureString $SafeModeAdminPassword -asplaintext -force) `
    -NoRebootOnCompletion:$false `
    -Force
Write-Host "Done installing Active Directory Forest..."


# See https://github.com/dbroeglin/windows-lab/issues/1
Write-Host "Start sleeping until reboot to prevent vagrant connection failures..."
Start-Sleep 230
Write-Host "Done sleeping."
