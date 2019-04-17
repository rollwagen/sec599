
#        "./scripts/pin-powershell.bat",
        "./scripts/set-winrm-automatic.bat",
        "./scripts/uac-enable.bat",
        "./scripts/dis-updates.bat",
        "./scripts/compact.bat"


echo Ensure WinRM start type is set to auto
sc config winrm start= auto

echo Enable UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v EnableLUA /t REG_DWORD /d 1
