Write-Host -ForegroundColor Yellow "text text"


Write-Host "Creating Jenni's Account..."
New-ADUser `
     -Name "Jenni Books" `
     -GivenName "Jennifer" `
     -Surname "Books" `
     -SamAccountName jennifer.books `
     -UserPrincipalName jennifer.books@seclabs.lab `
     -AccountPassword (ConvertTo-SecureString "P$$rmonth78" -asplaintext -force) `
     -PassThru | Enable-ADAccount

Write-Host "Creating Nick's Account..."
New-ADUser `
     -Name "Nick Fuss" `
     -GivenName "Nick" `
     -Surname "Fuss" `
     -SamAccountName nick.fuss `
     -UserPrincipalName nick.fuss@seclabs.lab `
     -AccountPassword (ConvertTo-SecureString "=ancyGorilla63" -asplaintext -force) `
     -PassThru | Enable-ADAccount

New-ADGroup `
     -Name "SECLABS Remote Desktop Users" `
     -SamAccountName "SECLABS Remote Desktop Users" `
     -GroupCategory Security `
     -GroupScope Global `
     -DisplayName "SECLABS Remote Desktop Users" `
     -Description "Members of this group can RDP into workstations."

Add-ADGroupMember -Identity "SECLABS Remote Desktop Users" -Members jennifer.books, nick.fuss

# Alternative would be a GPO Restricted Group, see
# https://wiki.samba.org/index.php/Managing_local_groups_on_domain_members_via_GPO_restricted_groups
# However, looks like not possible via Powershell.
# Hence, just adding locally on the member servers.
### IF statement if respective host is up?
Invoke-Command -ComputerName JUMPHOST -ScriptBlock {
     Add-LocalGroupMember -Group  "Remote Desktop Users" -Member "SECLABS\SECLABS Remote Desktop Users"
}
# Add-ADGroupMember "Remote Desktop Users" -Members "SECLABS Remote Desktop Users"

#@TODO - copy this script to DC desktop
#@TODO - JUMPHOST   Update-Help ... Chrome ...Sysinternals..Putty...RSAT tools..RDP files/shortcuts...VSCode (?)
#@TODO - powersettings windows  Powercfg /Change standby-timeout-ac 0dit

