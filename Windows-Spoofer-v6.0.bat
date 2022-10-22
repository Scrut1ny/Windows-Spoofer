:: ==================================================
::  Windows Spoofer v6.0
:: ==================================================
::  Dev  - Scut1ny
::  Link - https://github.com/Scrut1ny/Windows-Spoofer
:: ==================================================




:: ==================================================

@echo off
pushd "%~dp0"
setlocal EnableDelayedExpansion
mode con:cols=60 lines=20

fltmc >nul 2>&1 || (
    echo(&echo   [33m# Administrator privileges are required.&echo([0m
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo   [33m# Right-click on the script and select "Run as administrator".[0m
        >nul pause&exit 1
    )
    exit 0
)

:: ==================================================




:: ==================================================

:A
cls&title # Login Screen&echo(

set /p "user=.  [44m# Username:[30;40m"
cls&echo(
set /p "pass=[0m.  [44m# Password:[30;40m"
if "!user!"=="Scrutiny" if "!pass!"=="420" goto :MENU
if "!user!"=="Test" if "!pass!"=="69" goto :MENU

cls&color 07&echo(&echo   # [31mIncorrect Username or Password.[0m& >nul timeout /t 2
goto :A

:: ==================================================




:: ==================================================

:MENU
mode con:cols=60 lines=20
cls&title https://github.com/Scrut1ny/Windows-Spoofer ^| v6.0 ^| Welcome: !user!
echo   ===============================
echo       [31mWindows Spoofer[0m ^>^> [32mv5.5[0m
echo   ===============================
echo    1 ^> Spoof Windows
echo    2 ^> Check Serials
echo    3 ^> Check IP
echo   ===============================
echo     [34mhttps://github.com/Scrut1ny[0m
echo   ===============================
echo(
set /p "c=.  # "
if '%c%'=='1' goto :choice1
if '%c%'=='2' goto :choice2
if '%c%'=='3' goto :choice3
cls&echo(&echo   [31m# "%c%" isn't a valid option, please try again.[0m& >nul timeout /t 3
goto :MENU
exit /b

:choice1
cls
goto :SPOOF
exit /b

:choice2
goto :CheckSerials
exit /b

echo(&>nul pause
goto :MENU
exit /b

:choice3
cls&title Contacting ISP
mode con:cols=60 lines=25

for /f %%a in ('curl -fs api.ipify.org') do set PIP4=%%a

for /f "tokens=1,2 delims=:" %%a in ('curl -kfs "http://ip-api.com/!PIP4!?fields=66846719"') do (
    if not "%%b"=="" (
        call :deANSIfy %%a field
        call :deANSIfy %%b value
        
        set "!field!=!value!"
        echo !field! : !value!
    )
)

pause >nul
goto :MENU
exit /b

::-------------------------------------------------------------------------------
:: Strips ANSI sequences from a given string
::
:: Arguments: %1 - The string to process
::            %2 - The variable to store the value in
:: Returns:   None
::-------------------------------------------------------------------------------
:deANSIfy
set "string=%~1"
for %%A in (39 92 94 95 96) do set "string=!string:[%%Am=!"
for /f "usebackq delims=" %%A in ('!string!') do set "string=%%~A"
set "%~2=!string!"
exit /b

:SPOOF
cls&title Spoofing Windows...

echo(&echo   # [31mWARNING:[0m [33mDon't turn off system.[0m

echo(&echo   # [35mTerminating Conflicting Processes[0m&echo(

>nul 2>&1 (
	net stop msiserver rem https://www.minitool.com/news/windows-installer-service.html
)




:: SPOOFING REG

echo   # [35mSpoofing Registry[0m&echo(




:: ====================================================================================================
:: MAC Address
:: ====================================================================================================

arp -d * rem Clear ARP/Route Tables - Contains MAC Address's used by anti-cheats to track you.

:: ====================================================================================================




:: ====================================================================================================
:: SID
:: ====================================================================================================

>nul 2>&1 (
	for /f "tokens=7 delims=\" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" ^| find "S-1-5-21"') do (
		reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18" /v "Sid" /t REG_BINARY /d "!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-4!" /f
		reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\!SID!" /v "Sid" /t REG_BINARY /d "!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-1!" /f
		PowerShell Rename-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\%%A" -NewName "S-1-5-21-!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-4!-1001" -Force
		PowerShell Rename-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\%%A" -NewName "S-1-5-21-!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-4!-1001" -Force
	)
)

:: ====================================================================================================




:: ====================================================================================================
:: Monitor | Serial Number
:: ====================================================================================================

REM NEEDS REWORKING

rem Serial Number > 5&  14465d9b  &0&UID0
rem Add DISPLAY\MSI3EA2 not just DISPLAY\Default_Monitor

>nul 2>&1 (
	set counter=-1
	for /f "skip=1 tokens=7 delims=\" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\Default_Monitor"') do (
		set /a counter+=1
		set display[!counter!]=%%a
	)
	call :RGUID && PowerShell Rename-Item -Path "'HKLM:\SYSTEM\CurrentControlSet\Enum\DISPLAY\Default_Monitor\!display[0]!'" -NewName "'!random:~-1!&!random:~-5!!random:~-5!&0&UID!random:~-5!'" -Force
	call :RGUID && PowerShell Rename-Item -Path "'HKLM:\SYSTEM\CurrentControlSet\Enum\DISPLAY\Default_Monitor\!display[1]!'" -NewName "'!random:~-1!&!random:~-5!!random:~-5!&0&UID!random:~-5!'" -Force
)

:: ====================================================================================================




:: ====================================================================================================
:: NVIDIA | UUID | Serial Number
::
:: nvidia-smi -L
:: ====================================================================================================

>nul 2>&1 (
	call :RGUID
	reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global" /v "ClientUUID" /t REG_SZ /d "{!RGUID!}" /f
	reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\CoProcManager" /v "ChipsetMatchID" /t REG_SZ /d "%random:~-5%%random:~-5%%random:~-3%B%random:~-2%" /f
	reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\CoProcManager" /v "DriverInstallationDate" /t REG_SZ /d "%random:~-2%-%random:~-2%%random:~-4%" /f rem Anti-Cheats Check for installation dates too.
	rem Uninstall NVIDIA telemetry tasks
	IF EXIST "%ProgramFiles%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL" (
		rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetryContainer
		rundll32 "%PROGRAMFILES%\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage NvTelemetry
	)
	rem delete NVIDIA residual telemetry files
	DEL /s %HOMEDRIVE%\System32\DriverStore\FileRepository\NvTelemetry*.dll
	RD /S /Q "%ProgramFiles(x86)%\NVIDIA Corporation\NvTelemetry"
	RD /S /Q "%ProgramFiles%\NVIDIA Corporation\NvTelemetry"
	rem Opt out from NVIDIA telemetry
	reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d "0" /f 
	reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d "0" /f 
	reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d "0" /f 
	reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d "0" /f 
	reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\Startup" /v "SendTelemetryData" /t REG_DWORD /d "0" /f
	rem Disable NVIDIA telemetry services
	schtasks /change /TN NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /DISABLE
	schtasks /change /TN NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /DISABLE
	schtasks /change /TN NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /DISABLE
)

:: ====================================================================================================




:: ====================================================================================================
:: HwProfileGuid | GUID
:: ====================================================================================================

>nul 2>&1 (
	call :RGUID
	reg add "HKLM\SYSTEM\ControlSet001\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!RGUID!}" /f
	rem reg add "HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!RGUID!}" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: MachineGuid | GUID
::
:: Part of a System Restore Point - Contains a UUID which is used/tracked by some ACs.
:: CMD > findstr "{" "%WINDIR%\System32\restore\MachineGuid.txt"
:: ====================================================================================================

>nul 2>&1 (
	IF EXIST "%WINDIR%\System32\restore\MachineGuid.txt" (
		takeown /F "%WINDIR%\System32\restore\MachineGuid.txt"
		icacls "%WINDIR%\System32\restore\MachineGuid.txt" /grant %username%:(F^)
		attrib -r -s "%WINDIR%\System32\restore\MachineGuid.txt"
		call :RGUID && echo {!RGUID!}>"%WINDIR%\System32\restore\MachineGuid.txt"
		attrib +s +r "%WINDIR%\System32\restore\MachineGuid.txt"
		icacls "%WINDIR%\System32\restore\MachineGuid.txt" /remove:g %username%
		takeown /F "%WINDIR%\System32\restore\MachineGuid.txt" /A
		rem Deletes all volume shadow copies.
		wmic shadowcopy delete /nointeractive
		vssadmin delete shadows /all /quiet
	)
)

:: ====================================================================================================




:: ====================================================================================================
:: HardwareConfig | GUID
::
:: This is a temporary spoof, after system shutdown/restart you need to spoof again.
:: C:\Windows\System32\Sysprep\sysprep.exe
:: ====================================================================================================

>nul 2>&1 (
	for /f "tokens=1,2delims=`" %%a in ("{!UUID!}`{!RGUID!}") do (
		reg add "HKLM\SYSTEM\HardwareConfig" /v "LastConfig" /t REG_SZ /d "%%b" /f
		PowerShell Rename-Item -Path "'HKLM:\SYSTEM\HardwareConfig\%%a'" -NewName "'%%b'" -Force
	)
)

:: ====================================================================================================




:: ====================================================================================================
:: Cryptography | GUID
:: ====================================================================================================

>nul 2>&1 (
	call :RGUID
	net stop cryptsvc
	reg add "HKLM\SOFTWARE\Microsoft\Cryptography" /v "MachineGuid" /t REG_SZ /d "!RGUID!" /f
	net start cryptsvc
)

:: ====================================================================================================




:: ====================================================================================================
:: GPU/PCI PNPDeviceID - DeviceInstance | Serial Number
:: ====================================================================================================

rem reg query loop through every instance of PNPDeviceID and spoof it

rem Looking at the PNPDeviceID value, break it up by "\".
rem The first piece it the bus type. For me, it is PCI.
rem The second section describes the card. There's a vendor code, model number, etc.
rem The last section contains a number separated by ampersands. The serial number is the second number in that list, formatted in hex.
rem Translate the hex to decimal
	
rem PCI\VEN_10DE&DEV_1F08&SUBSYS_21673842&REV_A1\4&  1C3D25BB  &0&0019

:: ====================================================================================================




:: ====================================================================================================
:: DiskPeripheral | Identifier(s)
:: ====================================================================================================

>nul 2>&1 (
	for /f "tokens=10 delims=\" %%A in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\MultifunctionAdapter\0\DiskController\0\DiskPeripheral"') do (
		for /l %%B in (0,1,%%A) do (
			if "%%A"=="%%B" (
				reg add "HKLM\HARDWARE\DESCRIPTION\System\MultifunctionAdapter\0\DiskController\0\DiskPeripheral\%%B" /v "Identifier" /t REG_SZ /d "!random:~-5!!random:~-3!-00000000-A" /f
			)
		)
	)
)

:: ====================================================================================================



:: ====================================================================================================
:: Physical Drives | SSD / HDD Serial Number(s) | Reset Physical Disk Status(es)
:: ====================================================================================================

>nul 2>&1 (
	for /f "tokens=3" %%A in ('reg query "HKLM\HARDWARE\DEVICEMAP\Scsi" /s /f "Scsi Port" /k') do (
		for /l %%B in (0,1,%%A) do (
			if "%%A"=="%%B" (
				reg add "HKLM\HARDWARE\DEVICEMAP\Scsi\Scsi Port %%A\Scsi Bus 0\Target Id 0\Logical Unit Id 0" /v "SerialNumber" /t REG_SZ /d "!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!" /f
				powershell Reset-PhysicalDisk *
			)
		)
	)
)

:: ====================================================================================================




:: ====================================================================================================
:: SQMClient
:: ====================================================================================================

>nul 2>&1 (
	call :RGUID
	reg add "HKCU\SOFTWARE\Microsoft\SQMClient" /v "UserId" /t REG_SZ /d "{!RGUID!}" /f
	reg add "HKLM\SOFTWARE\Microsoft\SQMClient" /v "MachineId" /t REG_SZ /d "{!RGUID!}" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: SystemInformation
:: ====================================================================================================

>nul 2>&1 (
	rem System Name
	reg add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "Hostname" /t REG_SZ /d "%random:~-5%" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "NV Hostname" /t REG_SZ /d "%random:~-5%" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v "ComputerName" /t REG_SZ /d "%random:~-5%" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v "ComputerName" /t REG_SZ /d "%random:~-5%" /f
	rem SystemInformation
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v "BIOSReleaseDate" /t REG_SZ /d "0%random:~-1%/1%random:~-1%/%random:~-4%" /f
	call :RGUID && reg add "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v "ComputerHardwareId" /t REG_SZ /d "{!RGUID!}" /f
	call :RGUID && reg add "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v "ComputerHardwareIds" /t REG_MULTI_SZ /d "{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: CurrentVersion
:: ====================================================================================================

>nul 2>&1 (
	call :RGUID
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "BuildGUID" /t REG_SZ /d "!RGUID!" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "DigitalProductId" /t REG_BINARY /d "%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "DigitalProductId4" /t REG_BINARY /d "%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "InstallDate" /t REG_DWORD /d "5a%random:~-4%e6" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "InstallTime" /t REG_QWORD /d "1d%random:~-5%e23fc090" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductId" /t REG_SZ /d "%random:~-4%-%random:~-4%-%random:~-4%-%random:~-5%" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "RegisteredOwner" /t REG_SZ /d "%random%%random%%random%%random%" /f

	rem WSUS change	
	net stop wuauserv
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v "SusClientId" /t REG_SZ /d "!RGUID!" /f  
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v "SusClientIDValidation" /t REG_BINARY /d "%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%" /f 
	net start wuauserv

	reg delete "HKLM\SOFTWARE\Microsoft\Internet Explorer" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: AMIBIOS DMI EDITOR
:: If you get any errors relating to PNP your motherboard isn't compatible with this version of AMIBIOS DMI EDITOR.
:: 
:: https://www.thetechgame.com/Tutorials/id=28615/c=12091/mwhwid-ban-change-uuid-and-serial-of-ami-bios-motherboard.html
::
:: https://download.schenker-tech.de/package/dmi-edit-efi-ami/
:: https://github.com/hfiref0x/DSEFix
:: ====================================================================================================

rem Disable Windows Signature Enforcement

>nul 2>&1 (
	curl -fksLo "dmi-edit-win64-ami.zip" "https://download.schenker-tech.de/package/dmi-edit-efi-ami/?wpdmdl=3997&ind=1647077068432" && tar -xf dmi-edit-win64-ami.zip

	rem System Information - Serial Number & System UUID
	for /f "tokens=2 delims==" %%A in ('wmic csproduct get IdentifyingNumber /value ^| find "="') do (
		for /f "delims=" %%B in ("%%~A") do (
			if not "To be filled by O.E.M."=="%%B" (
				if not "Unknown"=="%%B" (
					AMIDEWINx64.EXE /SS "!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!"
				)
			)
		)
	)
	AMIDEWINx64.EXE /SU AUTO

	rem Base Board/Module Information - Baseboard Serial Number
	for /f "tokens=2 delims==" %%A in ('wmic baseboard get serialnumber /value ^| find "="') do (
		for /f "delims=" %%B in ("%%~A") do (
			if not "To be filled by O.E.M."=="%%B" (
				if not "Unknown"=="%%B" (
					AMIDEWINx64.EXE /BS "!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!"
				)
			)
		)
	)

	rem System Enclosure or Chassis - Serial Number
	for /f "tokens=2 delims==" %%A in ('wmic systemenclosure get serialnumber /value ^| find "="') do (
		for /f "delims=" %%B in ("%%~A") do (
			if not "To be filled by O.E.M."=="%%B" (
				if not "Unknown"=="%%B" (
					AMIDEWINx64.EXE /CS "!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!"
				)
			)
		)
	)

	rem Processor Information - Serial Number
	for /f "tokens=2 delims==" %%A in ('wmic cpu get serialnumber /value ^| find "="') do (
		for /f "delims=" %%B in ("%%~A") do (
			if not "To be filled by O.E.M."=="%%B" (
				if not "Unknown"=="%%B" (
					AMIDEWINx64.EXE /PSN "!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!"
				)
			)
		)
	)

	rem Memory Device - Serial Number(s)

	del /F /Q "AMIDEWINx64.EXE" "amifldrv64.sys" "amigendrv64.sys" "example.bat" "readme.txt" "dmi-edit-win64-ami.zip"
)

:: ====================================================================================================




:: ====================================================================================================
:: VolumeID - USN Journal ID
:: ====================================================================================================

>nul 2>&1 (
	rem Spoofs all VolumeIDs XXXX-XXXX.
	curl -fksLO "https://download.sysinternals.com/files/VolumeId.zip" && tar -xf VolumeId.zip 
	for %%a in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%a:\" Volumeid64.exe %%a: !random:~-4!-!random:~-4! -nobanner
	del /F /Q "volumeid*" "Eula.txt"
	
	rem Anti-Cheats use "USN Journal IDs" as a HWID tagging mechanism, so we delete them.
	for %%a in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%a:" fsutil usn deletejournal /d %%a:
)

:: ====================================================================================================




:: ====================================================================================================
:: Windows Logs/Traces/misc. - Networking - Remove Windows "Activate Windows" Watermark
:: ====================================================================================================

echo   # [35mCleaning Traces[0m

:: Files

>nul 2>&1 (
	rem Activision: Call of Duty - Tracers - The game replaces/rebuilds next time you launch it.
	tasklist | find /i "Battle.net.exe" && taskkill /F /IM battle.net.exe || echo Battle.net was not running.
	reg delete "HKEY_CURRENT_USER\SOFTWARE\Activision" /f
	reg delete "HKEY_CURRENT_USER\SOFTWARE\Blizzard Entertainment" /f
	reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Blizzard Entertainment" /f
	del /F /Q "%CODFOLDER%\Data\data\shmem"
	del /F /Q "%CODFOLDER%\main\data0.dcache"
	del /F /Q "%CODFOLDER%\main\data1.dcache"
	del /F /Q "%CODFOLDER%\main\toc0.dcache"
	del /F /Q "%CODFOLDER%\main\toc1.dcache"
	REM del /F /Q "%CODFOLDER%\main\recipes\cmr_hist"
	rmdir /S /Q "%appdata%\Battle.net"
	rmdir /S /Q "%DOCSFOLDER%\Call of Duty Modern Warfare"
	rmdir /S /Q "%localappdata%\Activision"
	rmdir /S /Q "%localappdata%\Battle.net"
	rmdir /S /Q "%localappdata%\Blizzard Entertainment"
	rmdir /S /Q "%localappdata%\CrashDumps"
	rmdir /S /Q "%programdata%\Battle.net"
	rmdir /S /Q "%programdata%\Blizzard Entertainment"
	
	rem Epic Games: Fortnite
	tasklist | find /i "EpicGamesLauncher.exe" && taskkill /F /IM EpicGamesLauncher.exe
	tasklist | find /i "FortniteClient-Win64-Shipping.exe" && taskkill /F /IM FortniteClient-Win64-Shipping.exe
	tasklist | find /i "FortniteClient-Win64-Shipping_BE.exe" && taskkill /F /IM FortniteClient-Win64-Shipping_BE.exe
	tasklist | find /i "FortniteClient-Win64-Shipping_EAC.exe" && taskkill /F /IM FortniteClient-Win64-Shipping_EAC.exe
	tasklist | find /i "taskkill /F /IM FortniteLauncher.exe" && taskkill /F /IM taskkill /F /IM FortniteLauncher.exe
	
	
	rem Delete Old Windows Backup
	IF EXIST "%HOMEDRIVE%\Windows.old" (
		takeown /f "%HOMEDRIVE%\Windows.old" /a /r /d y
		icacls "%HOMEDRIVE%\Windows.old" /grant administrators:F /t
		rd /S /Q "%HOMEDRIVE%\Windows.old"
	)
	
	del /F /S /Q "%WINDIR%\Prefetch\*"
	for /f "tokens=*" %%1 in ('wevtutil.exe el') do wevtutil.exe cl "%%1" rem Clear Event Logs
	del /F /S /Q %HOMEDRIVE%\*.log *.etl *.tmp *.hta && del /F /S /Q %tmp%\*
	
	rem Emptying Recycle Bins & Resetting explorer.exe
	powershell Clear-RecycleBin -Force -ErrorAction SilentlyContinue
	taskkill /F /IM explorer.exe&&explorer.exe
)

:: Networking

echo(&&echo   # [35mRevising Networking[0m

>nul 2>&1 (
	rem delete all Network Data Usage & Disable it.
	sc stop "DPS" & sc config "DPS" start= disabled
	DEL /F /S /Q "%windir%\System32\sru\*"
	
	rem Clear SSL State
	certutil -URLCache * delete
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2 rem Clear Cookies
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 rem Clear Temporary Internet Files
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 16 rem Clear Form Data
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 32 rem Clear Saved Passwords
	
	arp -d * rem Clear ARP/Route Tables - Contains MAC Address's used by anti-cheats to track you.
	nbtstat -R
	nbtstat -RR
	netsh branchcache reset
	netsh dhcpclient trace disable
	netsh http flush
	netsh nap reset
	netsh routing reset
	netsh rpc reset
	netsh trace stop
	netsh winhttp reset
	netsh winsock reset
	netsh winsock set autotuning off
	netsh interface reset all
	
	rem Switching DNS servers to bypass some ISP censorship.
	
	rem Ethernet
	netsh interface ipv4 set dns "Ethernet" static 1.1.1.1 primary
	netsh interface ipv4 add dns "Ethernet" 1.0.0.1 index=2
	rem netsh interface ipv6 set dns "Ethernet" static 2606:4700:4700::1111 primary
	rem netsh interface ipv6 add dns "Ethernet" 2606:4700:4700::1001 index=2
	
	rem WIFI
	netsh interface ipv4 set dns "WIFI" static 1.1.1.1 primary
	netsh interface ipv4 add dns "WIFI" 1.0.0.1 index=2
	rem netsh interface ipv6 set dns "WIFI" static 2606:4700:4700::1111 primary
	rem netsh interface ipv6 add dns "WIFI" 2606:4700:4700::1001 index=2
	
	rem Resetting connections
	ipconfig/flushdns
	net start msiserver
	
	goto :AGAIN
)

:: Removing Windows "Activate Windows" Watermark
echo(&&echo   # [35mRevising Networking[0m

>nul 2>&1 (
	bcdedit -set TESTSIGNING OFF
	reg add "HKCU\Control Panel\Desktop" /v "PaintDesktopVersion" /d "0" /f
	taskkill /F /IM explorer.exe&&explorer.exe
)

:: ====================================================================================================




:: ====================================================================================================
:: Obtaining Serials
:: ====================================================================================================

:CheckSerials
mode con:cols=105 lines=65
cls

rem (
echo %date% %time% && echo(
echo - [31mUser Account Name ^& SID[0m -----
wmic useraccount get name,sid

echo - [31mCPU - (Central Processing Unit)[0m -----
wmic cpu get serialnumber

echo - [31mGPU - (Graphical Processing Unit)[0m -----
wmic path win32_VideoController get name^,PNPDeviceID

echo - [31mRAM - (System Memory)[0m -----
wmic memorychip get name^,serialnumber

echo - [31mSSD/HDD - (Solid State/Hard Disk Drive(s))[0m ------
wmic diskdrive get Model^,serialnumber

echo - [31mSMBIOS - (System Motherboard BIOS)[0m -----
wmic baseboard get serialnumber
wmic csproduct get UUID

echo - [31mChassis[0m -----
wmic systemenclosure get serialnumber

echo - [31mVolumeID[0m -----
for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%A:\" (
        for /f "tokens=5" %%B in ('vol %%A: ^| find "-"') do (
            if not "The system cannot find the path specified."=="%%B:" (
                echo (%%A:^) ^> %%B
            )
        )
    )
)

echo(&&echo - [31mMAC Address - (Media Access Control)[0m -----
wmic nicconfig where (IPEnabled=True^) GET Description^,SettingID^,MACAddress

echo - [31mMachineGuid[0m -----
call :MachineGuid && echo MachineGuid
echo !MachineGuid! && echo(

echo - [31mNVIDIA[0m -----
call :NVIDIA_SN && echo SerialNumber
echo !NVIDIA! && echo(

echo - [31mWindows Product ID[0m -----
wmic os get serialnumber

rem ) >"%tmp%\HWID.txt" && explorer.exe %tmp%\HWID.txt
>nul pause&goto :MENU

:: ====================================================================================================




:AGAIN
echo(&echo(&cls&title Main Menu
echo(&echo    RESTART PC NOW!&echo(
echo  [1] Run again
echo  [2] Check Serials
echo  [3] Restart
echo  [4] Shutdown
echo(
set /p c=".  # "
if %c%==1 goto :c1
if %c%==2 goto :c2
if %c%==3 goto :c3
if %c%==4 goto :c4
echo Choice "%c%" isn't a valid option. Please try again.
goto :AGAIN
:c1
goto :SPOOF
:c2
goto :CheckSerials
:c3
shutdown /r /t 0
:c4
shutdown /s /t 0




:: ====================================================================================================
:: Generation
:: ====================================================================================================

:: GENERATING UUID/GUID
:RGUID
for /f "usebackq" %%A in (`powershell [guid]::NewGuid(^).ToString(^)`) do (
	set "RGUID=%%A"
)
exit /b

:: Retrieving UUID/GUID
:UUID
for /f "tokens=2 delims==" %%A in ('wmic csproduct get uuid /value ^| find "="') do (
	set "UUID=%%A"
)
exit /b

:: Retrieving NVIDIA ChipsetMatchID
:NVIDIA_SN
for /f "tokens=3" %%A in ('reg query "HKLM\SOFTWARE\NVIDIA Corporation\Global\CoProcManager" ^| find "ChipsetMatchID"') do (
	set "NVIDIA=%%A"
)
exit /b

:: Retrieving MachineGuid
:MachineGuid
for /f "delims=" %%A in ('findstr "{" "%WINDIR%\System32\restore\MachineGuid.txt"') do (
	set "MachineGuid=%%A"
)
exit /b

:: ====================================================================================================




exit /b 0
