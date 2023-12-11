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

(
	if not exist "%tmp%\Volumeid64.exe" (
		ping 9.9.9.9 -n 1 > nul
		if not !errorlevel! equ 0 (
			echo No internet connection
			exit /b 1
		)
		pushd "%tmp%"
		curl -A "Mozilla/5.0" -fksLo "%tmp%\VolumeId.zip" "https://download.sysinternals.com/files/VolumeId.zip" && tar -xf "%tmp%\VolumeId.zip"
		call :RSG
		for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%A:\" "%tmp%\Volumeid64.exe" %%A: !string:~0,4!-!string:~-4! -nobanner
	)
) >nul 2>&1

:: ====================================================================================================


:: ====================================================================================================
:: 8 character long "A-F, 0-9" random string generator
:: ====================================================================================================

:RSG
set char=ABCDEF0123456789
set char_length=16
set length=8
set string=

for /L %%a in (1,1,!length!) do (
    set /A "index=!random! %% !char_length!"
    for %%b in (!index!) do set string=!string!!char:~%%b,1!
)
exit /b 0

:: ====================================================================================================