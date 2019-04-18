
#        "./scripts/pin-powershell.bat",
        "./scripts/set-winrm-automatic.bat",
        "./scripts/uac-enable.bat",
        "./scripts/dis-updates.bat",
        "./scripts/compact.bat"


echo Ensure WinRM start type is set to auto
sc config winrm start=auto

echo Enable UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v EnableLUA /t REG_DWORD /d 1

echo Disable Updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 1 /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
sc config wuauserv start=disabled
net stop wuauserv
