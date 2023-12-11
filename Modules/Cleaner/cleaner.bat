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
:: Terminate all Conflicting Processes
:: ====================================================================================================

(
	:Ubisoft_Tasks
	rem Ubisoft
	tasklist | find /i "UbisoftGameLauncher.exe" && taskkill /T /F /IM "UbisoftGameLauncher.exe"
	tasklist | find /i "upc.exe" && taskkill /T /F /IM "upc.exe"
	tasklist | find /i "RainbowSix" && taskkill /T /F /IM "RainbowSix*"
	goto :menu
	exit /b
	
	
	
	:Valorant_Tasks
	rem Valorant
	tasklist | find /i "" && taskkill /T /F /IM ""
	tasklist | find /i "" && taskkill /T /F /IM ""
	tasklist | find /i "" && taskkill /T /F /IM ""
	exit /b
	
	
	
	:Fortnite_Tasks
	rem Epic Games: Fortnite
	tasklist | find /i "EpicGamesLauncher.exe" && taskkill /T /F /IM "EpicGamesLauncher.exe"
	tasklist | find /i "Fortnite" && taskkill /T /F /IM "Fortnite*"
	exit /b



	:COD_Tasks
	rem Activision: Call of Duty
	tasklist | find /i "battle.net.exe" && taskkill /T /F /IM "battle.net.exe"
	tasklist | find /i "" && taskkill /T /F /IM ""
	tasklist | find /i "" && taskkill /T /F /IM ""
	exit /b
) >nul 2>&1

:: ====================================================================================================


:: ====================================================================================================
:: Clean / Remove cashe, logs, and tracers
:: ====================================================================================================

(
	:Ubisoft_Files
	rem Ubisoft
	del /f/s/q "%ProgramFiles(x86)%\Ubisoft\Ubisoft Game Launcher\cache\*"
	del /f/s/q "%ProgramFiles(x86)%\Ubisoft\Ubisoft Game Launcher\crashes\*"
	del /f/s/q "%ProgramFiles(x86)%\Ubisoft\Ubisoft Game Launcher\logs\*"
	del /f/s/q "%ProgramFiles(x86)%\Ubisoft\Ubisoft Game Launcher\savegames\*"
	exit /b



	:Valorant_Files
	rem Valorant
	del /f/s/q "%LOCALAPPDATA%\VALORANT\saved\*"
	exit /b



	:Fortnite_Files
	rem Epic Games: Fortnite
	exit /b
	


	:COD_Files
	rem Activision: Call of Duty
	del /F /S /Q %HOMEDRIVE%\*.log && del /F /S /Q %tmp%\*
	reg delete "HKCU\SOFTWARE\Activision" /f
	reg delete "HKCU\SOFTWARE\Blizzard Entertainment" /f
	reg delete "HKLM\SOFTWARE\WOW6432Node\Blizzard Entertainment" /f
	del /F /Q "%CODFOLDER%\Data\data\shmem"
	del /F /Q "%CODFOLDER%\main\data0.dcache"
	del /F /Q "%CODFOLDER%\main\data1.dcache"
	del /F /Q "%CODFOLDER%\main\toc0.dcache"
	del /F /Q "%CODFOLDER%\main\toc1.dcache"
	REM del /F /Q "%CODFOLDER%\main\recipes\cmr_hist"
	rmdir /S /Q "%appdata%\Battle.net"
	rmdir /S /Q "%DOCSFOLDER%\Call of Duty Modern Warfare"
	rmdir /S /Q "%LOCALAPPDATA%\Activision"
	rmdir /S /Q "%LOCALAPPDATA%\Battle.net"
	rmdir /S /Q "%LOCALAPPDATA%\Blizzard Entertainment"
	rmdir /S /Q "%LOCALAPPDATA%\CrashDumps"
	rmdir /S /Q "%programdata%\Battle.net"
	rmdir /S /Q "%programdata%\Blizzard Entertainment"
	exit /b
) >nul 2>&1

:: ====================================================================================================


:: ====================================================================================================
:: Delete all USN Journal IDs
:: ====================================================================================================
:: Anti-Cheats use "USN Journal IDs" as a HWID tagging mechanism.

(
	for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%A:" fsutil usn deletejournal /n %%A:
) >nul 2>&1

:: ====================================================================================================


:: ====================================================================================================
:: Windows Cleaner
:: ====================================================================================================

(
	rem Delete Old Windows Backup
	if exist "%HOMEDRIVE%\Windows.old" (
		takeown /f "%HOMEDRIVE%\Windows.old" /a /r /d y
		icacls "%HOMEDRIVE%\Windows.old" /grant administrators:F /t
		rd /S /Q "%HOMEDRIVE%\Windows.old"
	)

	rem Delete all Temp, Prefetch, and Log Files
	del /f/s/q "%WINDIR%\Prefetch\*"
	del /f/s/q "%SystemDrive%\*.log"
	del /f/s/q "%SystemDrive%\Windows\Temp\*"
	del /f/s/q "%tmp%\*"

	rem Clear all Event Logs
	for /f "tokens=*" %%a in ('wevtutil.exe el') do (wevtutil.exe cl "%%a")

	rem Clear ARP Cache
	arp -d *

	rem Flush DNS
	ipconfig/flushdns

	rem Emptying Recycle Bins & Resetting explorer.exe
	powershell Clear-RecycleBin -Force -ErrorAction SilentlyContinue
) >nul 2>&1

:: ====================================================================================================