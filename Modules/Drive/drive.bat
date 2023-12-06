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
:: DiskPeripheral - Identifier(s)
:: ====================================================================================================

>nul 2>&1 (
	for /f "tokens=10 delims=\" %%A in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\MultifunctionAdapter\0\DiskController\0\DiskPeripheral"') do (
		for /l %%B in (0,1,%%A) do (
			if "%%A"=="%%B" (
				call :RSG
				reg add "HKLM\HARDWARE\DESCRIPTION\System\MultifunctionAdapter\0\DiskController\0\DiskPeripheral\%%B" /v "Identifier" /t REG_SZ /d "!string:~0,8!-!string:~-8!-A" /f
			)
		)
	)
)

:: ====================================================================================================


:: ====================================================================================================
:: Physical Drives (SSD/HDD) - Serial Number(s) | Reset Physical Disk Status(es)
:: ====================================================================================================
:: wmic path win32_DiskDrive get SerialNumber /value

>nul 2>&1 (
	for /f "tokens=3" %%A in ('reg query "HKLM\HARDWARE\DEVICEMAP\Scsi" /s /f "Scsi Port" /k') do (
		for /f "delims=:" %%B in ("%%A") do (
			for /l %%C in (0,1,%%B) do (
				if "%%A"=="%%B" (
					call :RSG
					reg add "HKLM\HARDWARE\DEVICEMAP\Scsi\Scsi Port %%A\Scsi Bus 0\Target Id 0\Logical Unit Id 0" /v "SerialNumber" /t REG_SZ /d "!string!" /f
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

:RSG
set "char=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
set "char_length=62"
set "length=20"
set "string="

for /L %%a in (1,1,!length!) do (
    set /A "index=!random! %% !char_length!"
    for %%b in (!index!) do set "string=!string!!char:~%%b,1!"
)

exit /b 0

:: ====================================================================================================