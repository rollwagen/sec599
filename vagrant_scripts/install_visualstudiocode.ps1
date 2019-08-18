#############################################################################
##
## Install Visual Studio Code
##
#############################################################################

# Pre-req for Install-VSCode script...
Write-Host "Installing NuGet..."
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

Write-Host "Installing VSCode install script..."
Install-Script -Name Install-VSCode -Force

Write-Host "Installing Visual Studio Code..."
Install-VSCode

Write-Host "Create link on Desktop for vagrant user..."
New-Item -ItemType SymbolicLink -Path C:\Users\vagrant\Desktop\VSCode -Target 'C:\Program Files\Microsoft VS Code\Code.exe'
