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

(
	call :RSG
	wmic computersystem where name="%computername%" call rename name="DESKTOP-!string!"
) >nul 2>&1

:: ====================================================================================================


:: ====================================================================================================
:: 7 Character long "A-Z, 0-9" random string generator
:: ====================================================================================================

:RSG
set char=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
set char_length=36
set length=7
set string=

for /L %%a in (1,1,!length!) do (
    set /A "index=!random! %% !char_length!"
    for %%b in (!index!) do set string=!string!!char:~%%b,1!
)

exit /b 0

:: ====================================================================================================