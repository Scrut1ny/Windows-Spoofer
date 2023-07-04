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
:: Hostname
:: ====================================================================================================

>nul 2>&1 (
	call :20HEX
	wmic computersystem where name="%computername%" call rename name="!randomString!"
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
