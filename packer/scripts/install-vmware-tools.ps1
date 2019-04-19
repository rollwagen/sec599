
Write-Host "Enabling >TLS1.0 for iso download over https..."
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "Downloading vmware tools..."
(New-Object System.Net.WebClient).DownloadFile('https://packages.vmware.com/tools/esx/latest/windows/VMware-tools-windows-10.3.5-10430147.iso', 'C:\Windows\Temp\vmware-tools.iso')

Write-Host "Mountain vmware tools ISO...."
$mountResult = Mount-DiskImage -ImagePath C:\Windows\Temp\vmware-tools.iso -PassThru
$driveLetter = ($mountResult | Get-Volume).DriveLetter

Write-Host "Running vmware tools setup/install...."
$vmwareToolsSetupExe = $driveLetter + ':\' + "setup64.exe"
cmd /c "$vmwareToolsSetupExe /s /l C:\\Windows\\Temp\\vmware_tools.log /v`"/qn REBOOT=R`""

Write-Host "Cleaning up vmware tools install...."
Dismount-DiskImage -ImagePath C:\Windows\Temp\vmware-tools.iso
Remove-Item  C:\Windows\Temp\vmware-tools.iso
