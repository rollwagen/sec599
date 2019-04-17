
Write-Host "Downloading ultradefrag tool..."
(New-Object System.Net.WebClient).DownloadFile('https://downloads.sourceforge.net/project/ultradefrag/stable-release/6.1.0/ultradefrag-portable-6.1.0.bin.amd64.zip', 'C:\Windows\Temp\ultradefrag.zip')

Write-Host "Unzipping ultradefrag tool...."
Expand-Archive C:\Windows\Temp\ultradefrag.zip C:\Windows\Temp


Write-Host "Downloading sdelete tool...."
(New-Object System.Net.WebClient).DownloadFile('https://download.sysinternals.com/files/SDelete.zip', 'C:\Windows\Temp\SDelete.zip')

Write-Host "Unzipping sdelete tool...."
Expand-Archive C:\Windows\Temp\SDelete.zip C:\Windows\Temp


#TODO
net stop wuauserv
rmdir /S /Q C:\Windows\SoftwareDistribution\Download
mkdir C:\Windows\SoftwareDistribution\Download
net start wuauserv
