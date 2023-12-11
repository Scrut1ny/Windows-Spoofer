:: ==================================================
::  Windows Spoofer v12.0
:: ==================================================
::  Dev  - Scut1ny
::  Help - Mathieu, Sintrode, 
::  Link - https://github.com/Scrut1ny/Windows-Spoofer
:: ==================================================


@echo off
pushd "%~dp0"
setlocal EnableDelayedExpansion
mode con:cols=60 lines=20

fltmc >nul 2>&1 || (
    echo( && echo   [33m# Administrator privileges are required. && echo([0m
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo   [33m# Right-click on the script and select "Run as administrator".[0m
        >nul pause && exit 1
    )
    exit 0
)

:: ==================================================


