

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
Dismount-DiskImage -ImagePath C:\Windows\Temp\vmware-tools.iso
Remove-Item  C:\Windows\Temp\vmware-tools.iso
