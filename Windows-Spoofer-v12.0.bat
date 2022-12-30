:: ==================================================
::  Windows Spoofer v12.0
:: ==================================================
::  Dev  - Scut1ny
::	Help - Mathieu, Sintrode, 
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
        >nul pause&&exit 1
    )
    exit 0
)

:: ==================================================




if "%~1"=="CheckSerials" (
    goto :CheckSerials
)




:: ==================================================

:MENU
mode con:cols=60 lines=20
cls && echo( && title https://github.com/Scrut1ny/Windows-Spoofer ^| v12.0 ^| Welcome: !user!
echo   ===============================
echo      [31mWindows Spoofer[0m ^>^> [32mv12.0[0m
echo   ===============================
echo    1 ^> Spoof Windows
echo    2 ^> Clear Traces
echo    3 ^> Check Serials
echo    4 ^> Check IP
echo   ===============================
echo     [34mhttps://github.com/Scrut1ny[0m
echo   ===============================
echo(
set /p "c=.  # "
if '%c%'=='1' goto :choice1
if '%c%'=='2' goto :choice2
if '%c%'=='3' goto :choice3
if '%c%'=='4' goto :choice3
cls&&echo(&&echo   [31m# "%c%" isn't a valid option, please try again.[0m&& >nul timeout /t 3
goto :MENU
exit /b

:choice1
goto :SPOOF
exit /b

:choice2
goto :MENU1
exit /b

:choice3
start "" "%~f0" CheckSerials
goto :MENU

echo(&>nul pause
goto :MENU
exit /b

:choice4
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

:MENU1
cls && echo( && echo   ===============================
echo        [31mClean Game Traces[0m
echo   ===============================
echo    1 ^> MW
echo    2 ^> Fortnite
echo    3 ^> Escape from Tarkov
echo    4 ^> 
echo    99 ^< Back
echo   ===============================
echo     [34mhttps://github.com/Scrut1ny[0m
echo   ===============================
echo(
set /p "c=.  # "
if '%c%'=='1' goto :clean1
if '%c%'=='2' goto :clean2
if '%c%'=='3' goto :clean3
if '%c%'=='4' goto :clean4
if '%c%'=='99' goto :clean99
cls && echo( && echo   [31m# "%c%" isn't a valid option, please try again.[0m && >nul timeout /t 3
goto :MENU
exit /b

:clean1
cls && echo( && echo   [] Cleaning all traces - Call of Duty: Modern Warfare && echo(
rem Activision: Call of Duty - Tracers - The game replaces/rebuilds next time you launch it.
tasklist | find /i "Battle.net.exe" && taskkill /F /IM battle.net.exe
del /F /S /Q %HOMEDRIVE%\*.log && del /F /S /Q %tmp%\*
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
goto :MENU1
exit /b

:clean2
cls && echo( && echo   [] Cleaning all traces - Epic Games: Fortnite && echo(
rem Epic Games: Fortnite
tasklist | find /i "EpicGamesLauncher.exe" && taskkill /F /IM EpicGamesLauncher.exe
tasklist | find /i "FortniteClient-Win64-Shipping.exe" && taskkill /F /IM FortniteClient-Win64-Shipping.exe
tasklist | find /i "FortniteClient-Win64-Shipping_BE.exe" && taskkill /F /IM FortniteClient-Win64-Shipping_BE.exe
tasklist | find /i "FortniteClient-Win64-Shipping_EAC.exe" && taskkill /F /IM FortniteClient-Win64-Shipping_EAC.exe
tasklist | find /i "taskkill /F /IM FortniteLauncher.exe" && taskkill /F /IM taskkill /F /IM FortniteLauncher.exe
del /F /S /Q %HOMEDRIVE%\*.log && del /F /S /Q %tmp%\*
goto :MENU1
exit /b

:clean3
>nul 2>&1 (
	rem Escape from Tarkov
)
goto :MENU1
exit /b

:clean4
goto :MENU1
exit /b

:clean99
goto :MENU
exit /b




:SPOOF
cls&title Spoofing Windows...
echo(&&echo   # [31mWARNING:[0m [33mDon't turn off system.[0m
echo(&&echo   # [35mTerminating Conflicting Processes[0m&&echo(




:: SPOOFING REG

echo   # [35mSpoofing Registry[0m&&echo(




:: ==================================================




if "%~1"=="CheckSerials" (
    goto :CheckSerials
)




:: ====================================================================================================
:: System Information
:: ====================================================================================================

>nul 2>&1 (
	rem Rename Computer System Name
	rem wmic computersystem where Caption='%ComputerName%' rename
	call :GEN_HEX 7 no_caps
	reg add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "NV Hostname" /t REG_SZ /d "System-Spoofed-!GEN_HEX[hex]!" /f
	reg add "HKLM\SYSTEM\ControlSet001\Control\ComputerName\ComputerName" /v "ComputerName" /t REG_SZ /d "System-Spoofed-!GEN_HEX[hex]!" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "RegisteredOwner" /t REG_SZ /d "System-Spoofed-!GEN_HEX[hex]!" /f
	rem SystemInformation
	call :lowerRGUID && reg add "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v "ComputerHardwareId" /t REG_SZ /d "{!lowerRGUID!}" /f
	call :lowerRGUID && reg add "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v "ComputerHardwareIds" /t REG_MULTI_SZ /d "{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0{!lowerRGUID!}\0" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: CurrentVersion
:: ====================================================================================================

>nul 2>&1 (
	rem WSUS change	
	net stop wuauserv
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v "SusClientId" /t REG_SZ /d "!lowerRGUID!" /f  
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v "SusClientIDValidation" /t REG_BINARY /d "%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%" /f 
	net start wuauserv

	reg delete "HKLM\SOFTWARE\Microsoft\Internet Explorer" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: SID (Security Identifiers)
:: ====================================================================================================

:: >nul 2>&1 (
:: for /f "tokens=7 delims=\" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" ^| find "S-1-5-21"') do (
:: reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18" /v "Sid" /t REG_BINARY /d "!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-4!" /f
:: reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\%%A" /v "Sid" /t REG_BINARY /d "!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-5!!random:~-1!" /f
:: PowerShell Rename-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\%%A" -NewName "S-1-5-21-!random:~-5!!random:~-5!-!random:~-5!!random:~-5!-!random:~-5!!random:~-5!-!random:~-4!" -Force
:: )
:: )

:: ====================================================================================================




:: ====================================================================================================
:: HwProfileGuid - GUID
:: ====================================================================================================

>nul 2>&1 (
	call :lowerRGUID
	reg add "HKLM\SYSTEM\ControlSet001\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!lowerRGUID!}" /f
	rem reg add "HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!lowerRGUID!}" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: MachineGuid - GUID
::
:: Part of a System Restore Point - Contains a UUID which is used/tracked by some ACs.
:: CMD > findstr "{" "%WINDIR%\System32\restore\MachineGuid.txt"
:: ====================================================================================================

>nul 2>&1 (
	if exist "%WINDIR%\System32\restore\MachineGuid.txt" (
		takeown /F "%WINDIR%\System32\restore\MachineGuid.txt"
		icacls "%WINDIR%\System32\restore\MachineGuid.txt" /grant %username%:(F^)
		attrib -r -s "%WINDIR%\System32\restore\MachineGuid.txt"
		call :lowerRGUID && echo {!lowerRGUID!}>"%WINDIR%\System32\restore\MachineGuid.txt"
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
:: HardwareConfig - GUID
::
:: This is a temporary spoof, after system shutdown/restart you need to spoof again.
:: C:\Windows\System32\Sysprep\sysprep.exe
:: ====================================================================================================

>nul 2>&1 (
	for /f "tokens=1,2delims=`" %%a in ("{!UUID!}`{!lowerRGUID!}") do (
		reg add "HKLM\SYSTEM\HardwareConfig" /v "LastConfig" /t REG_SZ /d "%%b" /f
		PowerShell Rename-Item -Path "'HKLM:\SYSTEM\HardwareConfig\%%a'" -NewName "'%%b'" -Force
	)
)

:: ====================================================================================================




:: ====================================================================================================
:: Cryptography - GUID
:: ====================================================================================================

>nul 2>&1 (
	call :lowerRGUID
	net stop cryptsvc
	reg add "HKLM\SOFTWARE\Microsoft\Cryptography" /v "MachineGuid" /t REG_SZ /d "!lowerRGUID!" /f
	net start cryptsvc
)

:: ====================================================================================================




:: ====================================================================================================
:: SQMClient - GUID | Product ID - Random
:: ====================================================================================================

>nul 2>&1 (
	rem User ID
	call :upperRGUID && reg add "HKCU\SOFTWARE\Microsoft\SQMClient" /v "UserId" /t REG_SZ /d "{!upperRGUID!}" /f
	rem Device/Machine ID
	call :upperRGUID && reg add "HKLM\SOFTWARE\Microsoft\SQMClient" /v "MachineId" /t REG_SZ /d "{!upperRGUID!}" /f
	rem Product ID
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductId" /t REG_SZ /d "%random:~-5%-%random:~-5%-%random:~-5%-%random:~-5%" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: NVIDIA - UUID/Serial Number
::
:: nvidia-smi -L
:: ====================================================================================================

>nul 2>&1 (
	call :lowerRGUID
	reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global" /v "ClientUUID" /t REG_SZ /d "{!lowerRGUID!}" /f
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
:: Monitor - Serial Number
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




:: ====================================================================================================
:: USB Devices - Serial Number
::
:: https://www.nirsoft.net/utils/usb_devices_view.html
::
:: ====================================================================================================

:: >nul 2>&1 (
:: 		for /f "skip=1 tokens=6 delims=\" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\USB"') do (
:: 				for /f "skip=1 tokens=7 delims=\" %%B in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\USB\%%A"') do (
:: 						call :GEN_HEX 7 no_caps && PowerShell Rename-Item -Path "'HKLM:\SYSTEM\CurrentControlSet\Enum\USB\%%A\%%B'" -NewName "'!random:~-5!!random:~-5!!random:~-5!'" -Force
:: 						call :GEN_HEX 7 no_caps && PowerShell Rename-Item -Path "'HKLM:\SYSTEM\CurrentControlSet\Enum\USB\%%A\%%B'" -NewName "'!random:~-5!!random:~-5!!random:~-5!'" -Force
:: 				)
:: 		)
:: )

:: ====================================================================================================




:: ====================================================================================================
:: GPU/PCI - Serial Number
:: ====================================================================================================

rem reg query loop through every instance of PNPDeviceID and spoof it

rem Looking at the PNPDeviceID value, break it up by "\".
rem The first piece it the bus type. For me, it is PCI.
rem The second section describes the card. There's a vendor code, model number, etc.
rem The last section contains a number separated by ampersands. The serial number is the second number in that list, formatted in hex.
rem Translate the hex to decimal
rem 
rem Need decimal to hex converter once variable is created to add back into the section below. 
rem
rem 	                                         This Section
rem 	                                           --------
rem PCI\VEN_10DE&DEV_1F08&SUBSYS_21673842&REV_A1\4&1C3D25BB&0&0019

:: ====================================================================================================




:: ====================================================================================================
:: DiskPeripheral - Identifier(s)
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
:: Physical Drives (SSD/HDD) - Serial Number(s) | Reset Physical Disk Status(es)
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
:: MAC Address(es)
:: ====================================================================================================

>nul 2>&1 (
	set "reg_path=HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}"
	call :GEN_HEX 12 only_caps && set "new_MAC=02-!GEN_HEX[hex]:~2,2!-!GEN_HEX[hex]:~4,2!-!GEN_HEX[hex]:~6,2!-!GEN_HEX[hex]:~8,2!-!GEN_HEX[hex]:~10,2!"

	for /f "tokens=1delims=[]" %%A in ('wmic nic where physicaladapter^=true get caption ^| find "["') do (
		set "Index=%%A" && set "Index=!Index:~-4!"
		rem Disables Power Saving Mode for Network Adapter(s), so wireless connection doesn't go down or stop background downloads etc.
		reg add "!reg_path!\!Index:~-4!" /v "PnPCapabilities" /t REG_DWORD /d "24" /f
		rem Changes the MAC Address using Hexidecimal formating, starting with "02" for compatibility.
		reg add "!reg_path!\!Index:~-4!" /v "NetworkAddress" /t REG_SZ /d "!new_MAC!" /f
		rem Deletes "OriginalNetworkAddress" registry keys made from TMAC MAC Address Changer, just in case ACs look for it.
		reg query "!reg_path!\!Index:~-4!" /v "OriginalNetworkAddress"
		if !ERRORLEVEL!==0 (
			reg delete "!reg_path!\!Index:~-4!" /v "OriginalNetworkAddress" /f
		)
	)

	for /f "skip=1delims=" %%A in ('wmic nic where netenabled^=true get netconnectionid') do (
		for /f %%B in ("%%A") do (
			netsh interface set interface name="%%B" admin=DISABLED
			netsh interface set interface name="%%B" admin=ENABLED
		)
	)
	rem Clear ARP/Route Tables - Contains MAC Address(es) used by ACs to track you after spoofing MAC Address(es).
	arp -d *
)

:: ====================================================================================================




:: ====================================================================================================
:: AMIBIOS DMI EDITOR
:: If you get any errors relating to PNP your motherboard isn't compatible with this version of AMIBIOS DMI EDITOR.
:: Some motherboards aren't compatible spoofing with this software.
:: 
:: https://www.thetechgame.com/Tutorials/id=28615/c=12091/mwhwid-ban-change-uuid-and-serial-of-ami-bios-motherboard.html
::
:: https://download.schenker-tech.de/package/dmi-edit-efi-ami/
:: https://github.com/hfiref0x/DSEFix
:: ====================================================================================================

rem Turn off Windows Test Mode
bcdedit /set TESTSIGNING OFF
rem Disable Windows Signature Enforcement
bcdedit.exe /set nointegritychecks on

echo(&&echo   # [35mSpoofing BIOS[0m


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

rem Enable Windows Signature Enforcement
bcdedit.exe /set nointegritychecks off
rem Turn on Windows Test Mode
bcdedit /set TESTSIGNING ON

:: ====================================================================================================




:: ====================================================================================================
:: VolumeID(s) | USN Journal ID(s)
:: ====================================================================================================

>nul 2>&1 (
	rem Changes all VolumeIDs XXXX-XXXX.
	curl -fksLO "https://download.sysinternals.com/files/VolumeId.zip" && tar -xf VolumeId.zip 
	for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%A:\" Volumeid64.exe %%A: !random:~-4!-!random:~-4! -nobanner
	del /F /Q "volumeid*" "Eula.txt"
	
	rem ACs use "USN Journal IDs" as a HWID tagging mechanism.
	for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%A:" fsutil usn deletejournal /d %%A:
)

:: ====================================================================================================




:: ====================================================================================================
:: General System Cleanup
:: ====================================================================================================

rem Delete Old Windows Backup
if exist "%HOMEDRIVE%\Windows.old" (
	takeown /f "%HOMEDRIVE%\Windows.old" /a /r /d y
	icacls "%HOMEDRIVE%\Windows.old" /grant administrators:F /t
	rd /S /Q "%HOMEDRIVE%\Windows.old"
)

rem Delete all Prefetch Files
del /F /S /Q "%WINDIR%\Prefetch\*"

rem Clear all Event Logs
for /f "tokens=*" %%a in ('wevtutil.exe el') do wevtutil.exe cl "%%a"
	
rem Emptying Recycle Bins & Resetting explorer.exe
powershell Clear-RecycleBin -Force -ErrorAction SilentlyContinue

:: ====================================================================================================




:: ====================================================================================================
:: Networking
:: ====================================================================================================

echo(&&echo   # [35mRevising Networking[0m

>nul 2>&1 (
	rem Delete all Network Data Usage & Disable it.
	sc stop "DPS" & sc config "DPS" start= disabled
	del /F /S /Q "%windir%\System32\sru\*"
	
	rem Clear SSL State
	certutil -URLCache * delete
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2 rem Clear Cookies
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 rem Clear Temporary Internet Files
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 16 rem Clear Form Data
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 32 rem Clear Saved Passwords
	
	rem Random
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
	netsh interface ipv4 set dnsservers "Ethernet" static 1.1.1.1 primary
	netsh interface ipv4 add dnsservers "Ethernet" 1.0.0.1 index=2
	rem netsh interface ipv6 set dnsservers "Ethernet" static 2606:4700:4700::1111 primary
	rem netsh interface ipv6 add dnsservers "Ethernet" 2606:4700:4700::1001 index=2
	
	rem Wi-Fi
	netsh interface ipv4 set dnsservers "Wi-Fi" static 1.1.1.1 primary
	netsh interface ipv4 add dnsservers "Wi-Fi" 1.0.0.1 index=2
	rem netsh interface ipv6 set dnsservers "Wi-Fi" static 2606:4700:4700::1111 primary
	rem netsh interface ipv6 add dnsservers "Wi-Fi" 2606:4700:4700::1001 index=2
	
	rem Resetting connections
	ipconfig/flushdns
	
	goto :AGAIN
)

taskkill /F /IM explorer.exe && explorer.exe

:: ====================================================================================================




:: ====================================================================================================
:: Obtaining & Displaying - Serial(s)/GUID(s)/UUID(s)/MAC Address(es)
:: ====================================================================================================

:CheckSerials
mode con:cols=105 lines=65
cls

echo %date% %time% && echo(
echo - [31mUser Account Name ^& SID[0m -----
wmic useraccount get name,sid

echo - [31mCPU - (Central Processing Unit)[0m -----
wmic cpu get serialnumber

echo - [31mGPU - (Graphical Processing Unit)[0m -----
wmic path win32_videocontroller get name^,pnpdeviceid

echo - [31mRAM - (System Memory)[0m -----
wmic memorychip get name^,serialnumber

echo - [31mSSD/HDD - (Solid State/Hard Disk Drive(s))[0m ------
wmic diskdrive get model^,serialnumber

echo - [31mSMBIOS - (System Motherboard BIOS)[0m -----
wmic baseboard get serialnumber
wmic csproduct get uuid

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

>nul pause
exit /b 0

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
:: Generating/Retrieving - GUID/Random
:: ====================================================================================================

:: Generating Random Hexidecimal Value - Serial Number / MAC Address / etc.
:GEN_HEX
if %2==no_caps (
    set GEN_HEX[map]=0123456789abcdef
    set GEN_HEX[round]=16
) else if %2==only_caps (
    set GEN_HEX[map]=0123456789ABCDEF
    set GEN_HEX[round]=16
) else (
    set GEN_HEX[map]=0123456789ABCDEFabcdef
    set GEN_HEX[round]=22
)
if defined GEN_HEX[hex] (
    set GEN_HEX[hex]=
)
for /l %%A in (1,1,%1) do (
    set /a "GEN_HEX[rnd]=!RANDOM! %%!GEN_HEX[round]!"
    for %%B in (!GEN_HEX[rnd]!) do (
        set GEN_HEX[hex]=!GEN_HEX[hex]!!GEN_HEX[map]:~%%B,1!
    )
)
for %%A in (
    map
    rnd
    round
) do (
    if defined GEN_HEX[%%A] (
        set GEN_HEX[%%A]=
    )
)
exit /b

:: Generating lowercase GUID
:lowerRGUID
for /f "usebackq" %%A in (`powershell [guid]::NewGuid(^).ToString(^)`) do (
	set "lowerRGUID=%%A"
)
exit /b

:: Generating uppercase GUID
:upperRGUID
for /f "usebackq" %%A in (`powershell [guid]::NewGuid(^).toString(^).ToUpper(^)`) do (
	set "upperRGUID=%%A"
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
