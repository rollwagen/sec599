Write-Host "Installing choco..."
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Write-Host "Finished installing choco..."

Write-Host "Installing Firefox."
choco install --confirm firefox
Write-Host "Installin VSCode."
choco install --confirm vscode

# Temporarily start wuauserv to allow RSAT tools to install b/c of error message:
#   ERROR: The running command stopped because the preference variable "ErrorActionPreference" or
#   common parameter is set to Stop: Service 'Windows Update (wuauserv)' cannot be started
Write-Host "Installing RSAT."
cmd /C "sc config wuauserv start=demand"
net stop wuauserv
ren c:\windows\SoftwareDistribution softwaredistribution.old
net start wuauserv
choco install --confirm rsat
net stop wuauserv
cmd /C "sc config wuauserv start=disabled"

Write-Host "Installing sysinternals."
choco install sysinternals --confirm --params "/InstallDir:C:\Users\vagrant\Desktop\sysinternals"

Write-Host "Installing putty."
choco install --confirm putty

Write-Host "Installing chrome."
choco install --confirm googlechrome

