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
:: HwProfileGuid - GUID
:: ====================================================================================================

>nul 2>&1 (
	call :lowerRGUID
	reg add "HKLM\SYSTEM\ControlSet001\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!lowerRGUID!}" /f
)

:: ====================================================================================================


:: ====================================================================================================
:: Cryptography - GUID
:: ====================================================================================================

>nul 2>&1 (
	call :lowerRGUID
	reg add "HKLM\SOFTWARE\Microsoft\Cryptography" /v "MachineGuid" /t REG_SZ /d "!lowerRGUID!" /f
)

:: ====================================================================================================


:: ====================================================================================================
:: SQMClient - GUID
:: ====================================================================================================

>nul 2>&1 (
	call :upperRGUID
	reg add "HKLM\SOFTWARE\Microsoft\SQMClient" /v "MachineId" /t REG_SZ /d "{!upperRGUID!}" /f
)

:: ====================================================================================================


:: ====================================================================================================
:: System Information
:: ====================================================================================================

>nul 2>&1 (
	call :lowerRGUID
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v "ComputerHardwareId" /t REG_SZ /d "{!lowerRGUID!}" /f
	call :lowerRGUID
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v "ComputerHardwareIds" /t REG_MULTI_SZ /d "{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0" /f
)

:: ====================================================================================================


:: Generating lowercase GUID
:lowerRGUID
for /f "usebackq" %%A in (`powershell [guid]::NewGuid(^).ToString(^)`) do (
	set "lowerRGUID=%%A"
)
exit /b


:: Generating uppercase GUID
:upperRGUID
for /f "usebackq" %%A in (`powershell [guid]::NewGuid(^).toString(^).ToUpper(^)`) do (
	set "upperRGUID=%%A"
)
exit /b