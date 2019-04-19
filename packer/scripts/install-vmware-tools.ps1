

Write-Host "Enabling >TLS1.0"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "Downloading vmware tools..."
#(New-Object System.Net.WebClient).DownloadFile('https://softwareupdate.vmware.com/cds/vmw-desktop/ws/15.0.4/12990004/windows/packages/tools-windows.tar', 'C:\Windows\Temp\vmware-tools.tar')
(New-Object System.Net.WebClient).DownloadFile('https://packages.vmware.com/tools/esx/latest/windows/VMware-tools-windows-10.3.5-10430147.iso', 'C:\Windows\Temp\vmware-tools.iso')


Write-Host "Mountain vmware tools ISO...."
$mountResult = Mount-DiskImage -ImagePath C:\Windows\Temp\vmware-tools.iso -PassThru
$driveLetter = ($mountResult | Get-Volume).DriveLetter

Write-Host "Running vmware tools setup/install...."
$vmwareToolsSetupExe = $driveLetter + ':\' + "setup64.exe"
cmd /c $vmwareToolsSetupExe /S /v"/qn REBOOT=R\"

Write-Host "Cleaning up vmware tools install...."



if exist "C:\Users\vagrant\windows.iso" (
    move /Y C:\Users\vagrant\windows.iso C:\Windows\Temp
)

if not exist "C:\Windows\Temp\windows.iso" (
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://softwareupdate.vmware.com/cds/vmw-desktop/ws/15.0.2/10952284/windows/packages/tools-windows.tar',
    'C:\Windows\Temp\vmware-tools.tar')" <NUL
    cmd /c ""C:\Program Files\7-Zip\7z.exe" x C:\Windows\Temp\vmware-tools.tar -oC:\Windows\Temp"
    FOR /r "C:\Windows\Temp" %%a in (VMware-tools-windows-*.iso) DO REN "%%~a" "windows.iso"
    rd /S /Q "C:\Program Files (x86)\VMWare"
)

cmd /c ""C:\Program Files\7-Zip\7z.exe" x "C:\Windows\Temp\windows.iso" -oC:\Windows\Temp\VMWare"
cmd /c C:\Windows\Temp\VMWare\setup.exe /S /v"/qn REBOOT=R\"

del /Q "C:\Windows\Temp\vmware-tools.tar"
del /Q "C:\Windows\Temp\windows.iso"
rd /S /Q "C:\Windows\Temp\VMware"
goto :done