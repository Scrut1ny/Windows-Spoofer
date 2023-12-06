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

call :RSG
set "Instance1=!string!"
call :RSG
set "Instance2=!string!"

ping -n 1 9.9.9.9 >nul
if %errorlevel% 0 (
	rem Changes all Volume Serial Numbers: XXXX-XXXX.
	>nul 2>&1 curl -fksL -o "%tmp%\VolumeId.zip" "https://download.sysinternals.com/files/VolumeId.zip" && powershell Expand-Archive -Force "%tmp%\VolumeId.zip" "%tmp%"
	for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%A:\" "%tmp%\Volumeid64.exe" %%A: !Instance1!-!Instance2! -nobanner >nul 2>&1
	del /F /Q "%tmp%\volumeid*" >nul 2>&1
	del /F /Q "%tmp%\Eula.txt" >nul 2>&1
) else (
	echo  # No internet
)

:: ====================================================================================================


:: ====================================================================================================
:: 4 character long "A-F, 0-9" random string generator
:: ====================================================================================================

:RSG
set "char=ABCDEF0123456789"
set "char_length=16"
set "length=4"
set "string="

for /L %%a in (1,1,!length!) do (
    set /A "index=!random! %% !char_length!"
    for %%b in (!index!) do set "string=!string!!char:~%%b,1!"
)
exit /b 0

:: ====================================================================================================