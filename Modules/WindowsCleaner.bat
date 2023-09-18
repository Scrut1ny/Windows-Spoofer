@echo off


:: ====================================================================================================
:: Request Administrator Privileges
:: ====================================================================================================

fltmc >nul 2>&1 || (
    echo( && echo   [33m# Administrator privileges are required. && echo([0m
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo   [33m# Right-click on the script and select "Run as administrator".[0m
        >nul pause && exit 1
    )
    exit 0
)

:: ====================================================================================================


:: ====================================================================================================
:: Windows Cleaner
:: ====================================================================================================

rem Delete Old Windows Backup
if exist "%HOMEDRIVE%\Windows.old" (
	takeown /f "%HOMEDRIVE%\Windows.old" /a /r /d y
	icacls "%HOMEDRIVE%\Windows.old" /grant administrators:F /t
	rd /S /Q "%HOMEDRIVE%\Windows.old"
)

rem Delete all Temp, Prefetch, and Log Files
del /f/s/q "%WINDIR%\Prefetch\*"
del /f/s/q "%SystemDrive%\*.log"
del /f/s/q "%SystemDrive%\Windows\Temp\*"
del /f/s/q "%tmp%\*"

rem Clear all Event Logs
for /f "tokens=*" %%a in ('wevtutil.exe el') do (wevtutil.exe cl "%%a")

rem Clear ARP Cache
arp -d *

rem Flush DNS
ipconfig/flushdns

rem Emptying Recycle Bins & Resetting explorer.exe
powershell Clear-RecycleBin -Force -ErrorAction SilentlyContinue

:: ====================================================================================================