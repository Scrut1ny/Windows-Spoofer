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
:: Monitor - Serial Number (Apex Legends Tracks This)
::
:: https://www.nirsoft.net/utils/monitor_info_view.html
::
:: ====================================================================================================

:: POWERSHELL ERROR: Rename-Item : Requested registry access is not allowed.

:: >nul 2>&1 (
:: 		for /f "skip=1 tokens=6 delims=\" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY"') do (
:: 				for /f "skip=1 tokens=7 delims=\" %%B in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\%%A"') do (
:: 						call :GEN_HEX 7 no_caps && PowerShell Rename-Item -Path "'HKLM:\SYSTEM\CurrentControlSet\Enum\DISPLAY\%%A\%%B'" -NewName "'!random:~-1!&!GEN_HEX[hex]!&!random:~-1!&UID!random:~-5!'" -Force
:: 						call :GEN_HEX 7 no_caps && PowerShell Rename-Item -Path "'HKLM:\SYSTEM\CurrentControlSet\Enum\DISPLAY\%%A\%%B'" -NewName "'!random:~-1!&!GEN_HEX[hex]!&!random:~-1!&UID!random:~-5!'" -Force
:: 				)
:: 		)
:: )

:: ====================================================================================================