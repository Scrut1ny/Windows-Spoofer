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
:: HwProfileGuid
:: ====================================================================================================

>nul 2>&1 (
	call :lowerRGUID
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!lowerRGUID!}" /f
)

:: ====================================================================================================


:: ====================================================================================================
:: Cryptography
:: ====================================================================================================

>nul 2>&1 (
	call :lowerRGUID
	reg add "HKLM\SOFTWARE\Microsoft\Cryptography" /v "MachineGuid" /t REG_SZ /d "!lowerRGUID!" /f
)

:: ====================================================================================================


:: ====================================================================================================
:: SQMClient (Device ID)
:: ====================================================================================================

>nul 2>&1 (
	call :upperRGUID
	reg add "HKLM\SOFTWARE\Microsoft\SQMClient" /v "MachineId" /t REG_SZ /d "{!upperRGUID!}" /f
)

:: ====================================================================================================


:: ====================================================================================================
:: ProductId (Product ID)
:: ====================================================================================================
:: wmic os get SerialNumber

set "numInstances=4"
set "ProductID="

for /L %%i in (1,1,!numInstances!) do (
    call :RSG
    set "Instance[%%i]=!string!"
    if %%i neq 1 set "ProductID=!ProductID!-"
    set "ProductID=!ProductID!!Instance[%%i]!"
)

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductId" /t REG_SZ /d "!ProductID!" /f >nul

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
for /f "usebackq" %%A in (`powershell [guid]::NewGuid(^).ToString(^).ToUpper(^)`) do (
	set "upperRGUID=%%A"
)
exit /b


:: 5 character long "A-Z, 0-9" random string generator
:RSG
set "char=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
set "char_length=36"
set "length=5"
set "string="

for /L %%a in (1,1,!length!) do (
    set /A "index=!random! %% !char_length!"
    for %%b in (!index!) do set "string=!string!!char:~%%b,1!"
)

exit /b 0
