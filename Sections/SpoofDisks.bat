@echo off
setlocal EnableDelayedExpansion


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
:: Physical Drives (SSD/HDD) - Serial Number(s) | Reset Physical Disk Status(es)
:: ====================================================================================================

:: wmic path win32_DiskDrive get SerialNumber /value

>nul 2>&1 (
	for /f "tokens=3" %%A in ('reg query "HKLM\HARDWARE\DEVICEMAP\Scsi" /s /f "Scsi Port" /k') do (
		for /f "delims=search:" %%B in ("%%A") do (
			for /l %%C in (0,1,%%B) do (
				if "%%A"=="%%B" (
					call :20HEX
					reg add "HKLM\HARDWARE\DEVICEMAP\Scsi\Scsi Port %%A\Scsi Bus 0\Target Id 0\Logical Unit Id 0" /v "SerialNumber" /t REG_SZ /d "!randomString!" /f
				)
			)
		)
	)
	powershell Reset-PhysicalDisk *
)

:: ====================================================================================================


:: ====================================================================================================
:: 20 Digit long "a-z, A-Z, 0-9" random string generator
:: ====================================================================================================

:20HEX
set "characters=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
set "length=20"
set "randomString="

for /L %%i in (1,1,%length%) do (
    set /A "index=!random! %% 62"
    for %%j in (!index!) do set "randomString=!randomString!!characters:~%%j,1!"
)
exit /b 0

:: ====================================================================================================
