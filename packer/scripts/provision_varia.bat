
rem        "./scripts/pin-powershell.bat",
rem        "./scripts/set-winrm-automatic.bat",
rem       "./scripts/uac-enable.bat",
rem        "./scripts/dis-updates.bat",
rem        "./scripts/compact.bat"


echo Ensure WinRM start type is set to auto
sc config winrm start=auto

echo Enable UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v EnableLUA /t REG_DWORD /d 1

echo Disable Updates - see https://www.windows-commandline.com/disable-automatic-updates-command-line/
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 1 /f
rem reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v NoAutoUpdate /d 1 /t REG_DWORD /f
sc config wuauserv start=disabled
rem net stop wuauserv

rem Manual perform update:  sc config wuauserv start=demand; net stop wuauserv; ren c:\windows\SoftwareDistribution softwaredistribution.old; net start wuauserv; sc config wuauserv start=disabled

