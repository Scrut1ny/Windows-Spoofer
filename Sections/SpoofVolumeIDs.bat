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
:: VolumeID
:: ====================================================================================================

call :4HEX
set "Instance1=!randomString!"
call :4HEX
set "Instance2=!randomString!"

>nul 2>&1 ping -n 1 9.9.9.9
if errorlevel 0 (
	rem Changes all VolumeIDs XXXX-XXXX.
	>nul 2>&1 curl -fksL -o "%tmp%\VolumeId.zip" "https://download.sysinternals.com/files/VolumeId.zip" && powershell Expand-Archive -Force "%tmp%\VolumeId.zip" "%tmp%"
	for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%A:\" "%tmp%\Volumeid64.exe" %%A: !Instance1!-!Instance2! -nobanner >nul 2>&1
	>nul 2>&1 del /F /Q "%tmp%\volumeid*" "%tmp%\Eula.txt"
) else (
	echo  # No internet
)

:: ====================================================================================================


:: ====================================================================================================
:: 4 Digit long "A-F, 0-9" random string generator
:: ====================================================================================================

:4HEX
set "characters=ABCDEF0123456789"
set "length=4"
set "randomString="

for /L %%i in (1,1,%length%) do (
    set /A "index=!random! %% 16"
    for %%j in (!index!) do set "randomString=!randomString!!characters:~%%j,1!"
)
exit /b

:: ====================================================================================================
