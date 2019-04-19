
Write-Host "Enabling >TLS1.0"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "Downloading ultradefrag tool..."
(New-Object System.Net.WebClient).DownloadFile('https://downloads.sourceforge.net/project/ultradefrag/stable-release/6.1.0/ultradefrag-portable-6.1.0.bin.amd64.zip', 'C:\Windows\Temp\ultradefrag.zip')

Write-Host "Unzipping ultradefrag tool...."
Expand-Archive C:\Windows\Temp\ultradefrag.zip C:\Windows\Temp


Write-Host "Downloading sdelete tool...."
(New-Object System.Net.WebClient).DownloadFile('https://download.sysinternals.com/files/SDelete.zip', 'C:\Windows\Temp\SDelete.zip')

Write-Host "Unzipping sdelete tool...."
Expand-Archive C:\Windows\Temp\SDelete.zip C:\Windows\Temp

Write-Host "Deleting SoftwareDistribution download directory...."
Stop-Service wuauserv
Remove-Item -Recurse -Force C:\Windows\SoftwareDistribution\Download
New-Item C:\Windows\SoftwareDistribution\Download
# Start-Service wuauserv

Write-Host "Running ultradefrag..."
#cmd /c "C:\Windows\Temp\ultradefrag-portable-6.1.0.amd64\udefrag.exe --optimize --repeat C:"
Start-Process -FilePath 'C:\Windows\Temp\ultradefrag-portable-6.1.0.amd64\udefrag.exe' -ArgumentList '--optimize --repeat C:' -wait
  

Write-Host "Running sdelete..."
cmd /c "%SystemRoot%\System32\reg.exe ADD HKCU\Software\Sysinternals\SDelete /v EulaAccepted /t REG_DWORD /d 1 /f"
cmd /c "C:\Windows\Temp\sdelete.exe -q -z C:"

Write-Host "Done running ultradefrag and sdelete..."
