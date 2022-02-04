::--------------------------------------
:: By: 0x00 / Anonymoushacker4926
:: Windows Spoofer
:: V5.0
::--------------------------------------

@echo off
setlocal EnableDelayedExpansion

>nul 2>&1 net sess||(powershell saps '%0'-Verb RunAs&exit /b)

:MENU
cls & color 4
:::
:::            ===================
:::            - WINDOWS SPOOFER -
:::   =====================================
:::   -  This batch script spoofs a ton   -
:::   -  of unique indentifiers in your   -
:::   -  system used to track you down.   -
:::   =====================================
:::
:::   [ 1 ] Spoof Windows
:::   [ 2 ] Check Serials
:::   [ 3 ] Check IP
:::   [ 4 ] Exit
:::

for /f "delims=: tokens=*" %%a in ('findstr /b ::: "%~f0"') do echo %%a

set /p choice= ">> "
if '%Choice%'=='1' goto :choice1
if '%Choice%'=='2' goto :choice2
if '%Choice%'=='3' goto :choice3
if '%Choice%'=='4' goto :choice4
cls
echo Choice "%Choice%" isn't a valid option. Please try again. 
goto :MENU

:choice1
cls
goto :SPOOF

:choice2
cls
color 2
echo.
echo  MAIN COMPONENTS
echo.
echo CPU(s): & echo. & wmic cpu get name,serialnumber
echo GPU(s): & echo. & wmic path win32_VideoController get name,PNPDeviceID
echo RAM Stick(s): & echo. & wmic memorychip get name,serialnumber
echo Motherboard: & echo. & wmic baseboard get product,serialnumber
echo SSD/HDD(s) & echo. & wmic diskdrive get Model,serialnumber
echo.
echo VIRTUAL ID's
echo.
echo SMBios: & echo. & wmic bios get serialnumber
echo MAC Address(s): & echo. & wmic nicconfig where (IPEnabled=True) GET Description,SettingID,MACAddress
echo.
pause
goto :MENU

:choice3
cls
color 3
title CHECKING NETWORK/IP...
for /f %%A in ('curl api.ipify.org') do set PublicIP=%%A
echo.&echo  External IP: !PublicIP!
echo.&echo  PINGING...
ping  8.8.8.8
echo.
pause
goto :MENU

:choice4
cls
color 5
title QUITTING...
echo Kinda sus...
exit

:SPOOF
cls
title SPOOFING IN PROGRESS...
echo. & echo  [+] Terminating Processes...
>nul 2>&1 taskkill /f /im (
	explorer.exe
	
)
>nul 2>&1 explorer.exe
echo. & echo  [+] Spoofing MAC Address... & echo.

:: SPOOFING MACAddress



:: SPOOFING REG

echo  [+] Spoofing BIOS... & echo.

:: BIOS
>nul 2>&1(
	REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardManufacturer" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardProduct" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardVersion" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSReleaseDate" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSVendor" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSVersion" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemFamily" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemManufacturer" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemProductName" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemSKU" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemVersion" /t REG_SZ /d "SPOOFED-%random%" /f
)

:: HwProfileGuid
>nul 2>&1(
	REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!RGUID!}" /f
	:: >nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!RGUID!}" /f
)

:: UUID/GUID
>nul 2>&1(
	REG DELETE "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0000" /v "OriginalNetworkAddress" /f rem Microsoft Kernel Debug Network Adapter
	REG DELETE "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "OriginalNetworkAddress" /f rem Actual NIC
	call :GUID1
	REG DELETE "HKLM\SYSTEM\HardwareConfig\!GUID1!" /f
	call :RGUID
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID!" /f
)

:: HardwareConfig
>nul 2>&1(
	call :GUID1
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BaseBoardManufacturer" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BaseBoardProduct" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BIOSReleaseDate" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BIOSVendor" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BIOSVersion" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemBiosVersion" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemFamily" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemManufacturer" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemProductName" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemSKU" /t REG_SZ /d "SPOOFED-%random%" /f
	REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemVersion" /t REG_SZ /d "SPOOFED-%random%" /f
	REG DELETE "HKLM\SYSTEM\HardwareConfig" /v "LastConfig" /f
	REG DELETE "HKLM\SYSTEM\HardwareConfig" /v "LastId" /f
)

:: Cryptography - MachineGuid
>nul 2>&1(
	call :RGUID
	REG ADD "HKLM\SOFTWARE\Microsoft\Cryptography" /v "MachineGuid" /t REG_SZ /d "!RGUID!" /f
)

:: SQMClient - MachineId
>nul 2>&1(
	call :RGUID
	REG ADD "HKLM\SOFTWARE\Microsoft\SQMClient" /v "MachineId" /t REG_SZ /d "{!RGUID!}" /f
)

:: CurrentVersion
>nul 2>&1(
	call :RGUID
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "BuildGUID" /t REG_SZ /d "!RGUID!" /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductId" /t REG_SZ /d %random%-%random%-%random%-%random% /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "RegisteredOwner" /t REG_SZ /d %random% /f
)

:: Events - GUID
>nul 2>&1(
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\Connected" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\Disconnected" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\EmailImage" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\FaxImage" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\PrintImage" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\ScanButton" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\STIproxyEvent" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
)

:: Variables
>nul 2>&1(
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e965-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 4d36e965
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e967-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem --------
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\DeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f    rem 4d36e968
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\Driver" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f        rem --------
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\DriverRank" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f    rem --------
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\Service" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f       rem --------
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\Driver" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f        rem --------
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\Driver" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f        rem --------
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e96a-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 4d36e96a
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 4d36e96c
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}\Configuration\Variables\EnumName" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f      rem --------
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}\Configuration\Variables\FriendlyNameProperty" /v "Value" /t REG_SZ /d "{!RGUID!}" /f rem --------
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e980-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 4d36e980
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{5989fce8-9cd0-467d-8a6a-5419e31529d4}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 5989fce8
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{5c4c3332-344d-483c-8739-259e934c9cc8}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 5c4c3332
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{62f9c741-b25a-46ce-b54c-9bccce08b6f2}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 62f9c741
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{6bdd1fc6-810f-11d0-bec7-08002be2092f}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 6bdd1fc6
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{6bdd1fc6-810f-11d0-bec7-08002be2092f}\Configuration\Variables\EnumName" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f      rem -------- 
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{6bdd1fc6-810f-11d0-bec7-08002be2092f}\Configuration\Variables\FriendlyNameProperty" /v "Value" /t REG_SZ /d "{!RGUID!}" /f rem --------
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{6d807884-7d21-11cf-801c-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 6d807884
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{88bae032-5a81-49f0-bc3d-a4ff138216d6}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 88bae032
)

:: CKCL GUID
>nul 2>&1(
	call :RGUID
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Diagnostics\Performance\BootCKCLSettings" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Diagnostics\Performance\SecondaryLogonCKCLSettings" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
	REG ADD "HKLM\SYSTEM\ControlSet001\Control\Diagnostics\Performance\ShutdownCKCLSettings" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
)

:: Internet Explorer PID
>nul 2>&1(
	REG ADD "HKLM\SOFTWARE\Microsoft\Internet Explorer" /v "svcKBNumber" /t REG_SZ /d "KB%random:~-5%%random:~-3%" /f
	REG ADD "HKLM\SOFTWARE\Microsoft\Internet Explorer\Registration" /v "ProductId" /t REG_SZ /d "!RGUID!" /f
)

:: VolumeID
>nul 2>&1(
	Volumeid64.exe %SystemDrive% %random:~-4%-%random:~-4%
)

:: DELETING WIN LOGS/TRACES
echo  [+] Cleaning all traces...
>nul 2>&1(
	del /f/s/q/a "%appdata%\Zoom\logs\*"
	del /f/s/q/a "%appdata%\Zoom\reports\*"
	del /f/s/q/a "%appdata%\Zoom\installer.txt"
	del /f/s/q/a "%appdata%\Zoom\appsafecheck.txt"

	del /f/s/q/a "%appdata%\discord\Cache\*"
	del /f/s/q/a "%appdata%\discord\GPUCache\*"
	del /f/s/q/a "%appdata%\discord\Code Cache\*"

	del /f/s/q/a "%systemdrive%\Windows\UserviceProfiles\NetworkService\NTSER.dat"
	del /f/s/q/a "%systemdrive%\Windows\UserviceProfiles\LocalService\AppData\Local\Microsoft\Windows\qwavecache.dat"
	del /f/s/q/a "%systemdrive%\Windows\SchCache\*"
	del /f/s/q/a "%systemdrive%\Windows\memory.dmp"
	del /f/s/q/a "%systemdrive%\Windows\win.ini"
	del /f/s/q/a "%systemdrive%\Windows\debug"
	del /f/s/q/a "%systemdrive%\Windows\Logs"
	del /f/s/q/a "%systemdrive%\Windows\CbsTemp\*"
	del /f/s/q/a "%systemdrive%\Windows\ModemLogs\*"
	del /f/s/q/a "%systemdrive%\Windows\Prefetch\*"
	del /f/s/q/a "%systemdrive%\Windows\rescache\_merged\*"
	del /f/s/q/a "%systemdrive%\Windows\SchCache\*"
	del /f/s/q/a "%systemdrive%\PerfLogs\*"
	del /f/s/q/a "%systemdrive%\desktop.ini"
	del /f/s/q/a "%systemdrive%\MSOCache\*"
	del /f/s/q/a "%systemdrive%\Users\Public\*"
	del /f/s/q/a "%systemdrive%\Recovery\*"
	del /f/s/q/a "%systemdrive%\Amd\*"
	del /f/s/q/a "%systemdrive%\Intel\*"
	del /f/s/q/a "%systemdrive%\Users\Public\*"

	del /f/s/q/a "%homepath%\AppData\Local\Microsoft\Windows\Explorer\iconcache*"
	del /f/s/q/a "%homepath%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"

	del /f/s/q/a "%windir%\SoftwareDistribution\Download\*"
)

echo. & echo  [+] Configuring NIC Settings... & echo.

:: Reset Data Usage
>nul 2>&1(
	net stop dps
	del /f/s/q/a "%windir%\System32\sru\*"
	net start dps
)

:: Clear SSL State
>nul 2>&1(
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2 rem Clear Cookies
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 rem Clear Temporary Internet Files
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 16 rem Clear Form Data
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 32 rem Clear Saved Passwords
)

:: Other
>nul 2>&1(
	netsh interface ip delete destinationcache
	netsh interface ip delete neighbors
	netsh interface ip delete arpcache
	netsh interface httpstunnel reset
	netsh interface ip reset catalog
	netsh interface portproxy reset
	netsh interface udp reset
	netsh interface tcp reset
	netsh interface ip reset

	netsh winsock set autotuning off
	netsh winhttp reset autoproxy
	netsh winsock reset catalog
	netsh winhttp reset tracing
	netsh winhttp reset proxy
	netsh winsock reset

	netsh dhcpclient trace disable
	netsh http flush logbuffer
	netsh http delete cache
	netsh branchcache reset
	netsh trace stop
	netsh rpc reset

	netsh advfirewall reset
	netsh advfirewall firewall set rule group="Network Discovery" new enable=No

	arp -d *
	nbtstat -R
	nbtstat -RR

	bcdedit -set TESTSIGNING OFF
	certutil -URLCache * delete
	ipconfig/flushdns

	for /f "skip=2 tokens=3*" %%a in ('netsh interface show interface') do (
		netsh dnsclient set dnsservers name="%%a" source=dhcp
		netsh interface ip set winsservers name="%%a" source=dhcp
		netsh interface ip set address name="%%a" dhcp
		netsh interface ip set dns name="%%a" dhcp
)

echo  [+] Emptying Recycle Bins... & echo.

>nul 2>&1(
	del /f/s/q/a %temp%\*
	del /f/s/q/a %systemdrive%\*.log,*.etl,*.tmp,*.hta
	powershell Clear-RecycleBin -Force -ErrorAction SilentlyContinue
)

:AGAIN
echo. & echo. & cls & title Main Menu
wmic nicconfig where (IPEnabled=True) GET Description,SettingID,MACAddress
echo. & echo    RESTART PC NOW! & echo.
echo  [ 1 ] Run again
echo.
echo  [ 2 ] Restart
echo  [ 3 ] Shutdown
echo.
set /p choice= ">> "
if '%Choice%'=='1' goto :choice1
if '%Choice%'=='1' goto :choice1
if '%Choice%'=='2' goto :choice2
if '%Choice%'=='3' goto :choice3
echo Choice "%choice%" isn't a valid option. Please try again.
goto :AGAIN
:choice1
goto :SPOOF
:choice2
shutdown /r /t 0
:choice3
shutdown /s /t 0

:: GENERATING UUID/GUID
for /f "usebackq" %%a in (`powershell -c [guid]::NewGuid(^).ToString(^)`) do (
	set "RGUID=%%a"
	exit /b
)

:: GENERATING MACAddress
for /f "usebackq" %%a in (`powershell -c ('{0:x}' -f (Get-Random 0xFFFFFFFFFFFF^)^).padleft(12^,^"0^"^)`) do (
	set "RMAC=%%a"
	exit /b
)

:: RETRIEVING UUID/GUID
for /f %%a in ('wmic csproduct get UUID ^| find "-"') do (
	set "GUID1={%%a}"
	exit /b
)
