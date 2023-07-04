@echo off


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
:: Delete all USN Journal IDs
:: ====================================================================================================

:: Anti-Cheats use "USN Journal IDs" as a HWID tagging mechanism.

>nul 2>&1 (
	for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%A:" fsutil usn deletejournal /d %%A:
)

:: ====================================================================================================