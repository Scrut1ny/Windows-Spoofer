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
goto:MENU

:choice1
cls
goto:SPOOF

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
goto:MENU

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
goto:MENU

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
taskkill /f /im explorer.exe >nul 2>&1
explorer.exe >nul 2>&1
echo. & echo  [+] Spoofing MAC Address... & echo.

:: SPOOFING MACAddress



:: SPOOFING REG

echo  [+] Spoofing BIOS... & echo.

:: BIOS

>nul 2>&1 REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardManufacturer" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardProduct" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardVersion" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSReleaseDate" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSVendor" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSVersion" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemFamily" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemManufacturer" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemProductName" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemSKU" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemVersion" /t REG_SZ /d "SPOOFED-%random%" /f

:: HwProfileGuid
>nul 2>&1 REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!RGUID!}" /f
:: >nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!RGUID!}" /f

:: UUID/GUID
>nul 2>&1 REG DELETE "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0000" /v "OriginalNetworkAddress" /f rem Microsoft Kernel Debug Network Adapter
>nul 2>&1 REG DELETE "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "OriginalNetworkAddress" /f rem Actual NIC
>nul 2>&1 REG DELETE "HKLM\SYSTEM\HardwareConfig\!GUID1!" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID!" /f

:: HardwareConfig
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BaseBoardManufacturer" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BaseBoardProduct" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BIOSReleaseDate" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BIOSVendor" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BIOSVersion" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemBiosVersion" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemFamily" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemManufacturer" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemProductName" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemSKU" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemVersion" /t REG_SZ /d "SPOOFED-%random%" /f
>nul 2>&1 REG DELETE "HKLM\SYSTEM\HardwareConfig" /v "LastConfig" /f

:: Cryptography MachineGuid
>nul 2>&1 REG ADD "HKLM\SOFTWARE\Microsoft\Cryptography" /v "MachineGuid" /t REG_SZ /d "!RGUID!" /f

:: CurrentVersion
>nul 2>&1 REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "BuildGUID" /t REG_SZ /d %Hex8%-%Hex1%-%Hex0%-%Hex1%-%Hex10% /f
>nul 2>&1 REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "BuildLab" /t REG_SZ /d %bi1%.rs1_release.17%bi2%-2100 /f
>nul 2>&1 REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "BuildLabEx" /t REG_SZ /d %bi1%.1944.amd64fre.rs1_release.17%bi2%-2100 /f
>nul 2>&1 REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "CurrentBuild" /t REG_SZ /d %bi1% /f
>nul 2>&1 REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "CurrentBuildNumber" /t REG_SZ /d %bi1% /f
>nul 2>&1 REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductId" /t REG_SZ /d %bi1% /f

:: Events
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\Connected" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\Disconnected" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\EmailImage" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\FaxImage" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\PrintImage" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\ScanButton" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\StillImage\Events\STIproxyEvent" /v "GUID" /t REG_SZ /d "{!RGUID!}" /f

:: Variables
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e965-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 4d36e965
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e967-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem --------
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\DeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f    rem 4d36e968
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\Driver" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f        rem --------
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\DriverRank" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f    rem --------
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\Service" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f       rem --------
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\Driver" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f        rem --------
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\Driver" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f        rem --------
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e96a-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 4d36e96a
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 4d36e96c
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}\Configuration\Variables\EnumName" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f      rem --------
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}\Configuration\Variables\FriendlyNameProperty" /v "Value" /t REG_SZ /d "{!RGUID!}" /f rem --------
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e980-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 4d36e980
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{5989fce8-9cd0-467d-8a6a-5419e31529d4}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 5989fce8
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{5c4c3332-344d-483c-8739-259e934c9cc8}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 5c4c3332
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{62f9c741-b25a-46ce-b54c-9bccce08b6f2}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 62f9c741
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{6bdd1fc6-810f-11d0-bec7-08002be2092f}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 6bdd1fc6
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{6bdd1fc6-810f-11d0-bec7-08002be2092f}\Configuration\Variables\EnumName" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f      rem -------- 
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{6bdd1fc6-810f-11d0-bec7-08002be2092f}\Configuration\Variables\FriendlyNameProperty" /v "Value" /t REG_SZ /d "{!RGUID!}" /f rem --------
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{6d807884-7d21-11cf-801c-08002be10318}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 6d807884
>nul 2>&1 REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{88bae032-5a81-49f0-bc3d-a4ff138216d6}\Configuration\Variables\BusDeviceDesc" /v "PropertyGuid" /t REG_SZ /d "{!RGUID!}" /f rem 88bae032

:: DELETING WIN LOGS/TRACES
echo  [+] Cleaning all traces...

>nul 2>&1 del /f/s/q/a "%appdata%\Zoom\logs\*"
>nul 2>&1 del /f/s/q/a "%appdata%\Zoom\reports\*"
>nul 2>&1 del /f/s/q/a "%appdata%\Zoom\installer.txt"
>nul 2>&1 del /f/s/q/a "%appdata%\Zoom\appsafecheck.txt"

>nul 2>&1 del /f/s/q/a "%appdata%\discord\Cache\*"
>nul 2>&1 del /f/s/q/a "%appdata%\discord\GPUCache\*"
>nul 2>&1 del /f/s/q/a "%appdata%\discord\Code Cache\*"

>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\UserviceProfiles\NetworkService\NTSER.dat"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\UserviceProfiles\LocalService\AppData\Local\Microsoft\Windows\qwavecache.dat"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\SchCache\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\memory.dmp"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\win.ini"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\debug"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\Logs"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\CbsTemp\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\ModemLogs\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\Prefetch\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\rescache\_merged\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Windows\SchCache\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\PerfLogs\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\desktop.ini"
>nul 2>&1 del /f/s/q/a "%systemdrive%\MSOCache\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Users\Public\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Recovery\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Amd\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Intel\*"
>nul 2>&1 del /f/s/q/a "%systemdrive%\Users\Public\*"

>nul 2>&1 del /f/s/q/a "%homepath%\AppData\Local\Microsoft\Windows\Explorer\iconcache*"
>nul 2>&1 del /f/s/q/a "%homepath%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"

>nul 2>&1 del /f/s/q/a "%windir%\SoftwareDistribution\Download\*"

echo. & echo  [+] Configuring NIC Settings... & echo.

:: Reset Data Usage
>nul 2>&1 net stop dps
>nul 2>&1 del /f/s/q/a "%windir%\System32\sru\*" rem Clearing Internet Log Files
>nul 2>&1 net start dps

:: Clear SSL State
>nul 2>&1 RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2 rem Clear Cookies
>nul 2>&1 RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 rem Clear Temporary Internet Files
>nul 2>&1 RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 16 rem Clear Form Data
>nul 2>&1 RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 32 rem Clear Saved Passwords

:: Other

>nul 2>&1 netsh interface ip delete destinationcache
>nul 2>&1 netsh interface ip delete neighbors
>nul 2>&1 netsh interface ip delete arpcache
>nul 2>&1 netsh interface httpstunnel reset
>nul 2>&1 netsh interface ip reset catalog
>nul 2>&1 netsh interface portproxy reset
>nul 2>&1 netsh interface udp reset
>nul 2>&1 netsh interface tcp reset
>nul 2>&1 netsh interface ip reset

>nul 2>&1 netsh winsock set autotuning off
>nul 2>&1 netsh winhttp reset autoproxy
>nul 2>&1 netsh winsock reset catalog
>nul 2>&1 netsh winhttp reset tracing
>nul 2>&1 netsh winhttp reset proxy
>nul 2>&1 netsh winsock reset

>nul 2>&1 netsh dhcpclient trace disable
>nul 2>&1 netsh http flush logbuffer
>nul 2>&1 netsh http delete cache
>nul 2>&1 netsh branchcache reset
>nul 2>&1 netsh trace stop
>nul 2>&1 netsh rpc reset

>nul 2>&1 netsh advfirewall reset
>nul 2>&1 netsh advfirewall firewall set rule group="Network Discovery" new enable=No

>nul 2>&1 arp -d *
>nul 2>&1 nbtstat -R
>nul 2>&1 nbtstat -RR

>nul 2>&1 bcdedit -set TESTSIGNING OFF
>nul 2>&1 certutil -URLCache * delete
>nul 2>&1 ipconfig/flushdns

for /f "skip=2 tokens=3*" %%a in ('netsh interface show interface') do (
	>nul 2>&1 netsh dnsclient set dnsservers name="%%a" source=dhcp
	>nul 2>&1 netsh interface ip set winsservers name="%%a" source=dhcp
	>nul 2>&1 netsh interface ip set address name="%%a" dhcp
	>nul 2>&1 netsh interface ip set dns name="%%a" dhcp
)

echo  [+] Emptying Recycle Bins... & echo.

>nul 2>&1 del /f/s/q/a %temp%\*
>nul 2>&1 del /f/s/q/a %systemdrive%\*.log,*.etl,*.tmp,*.hta

powershell Clear-RecycleBin -Force -ErrorAction SilentlyContinue

:AGAIN
echo. & echo. & cls & title Main Menu
wmic nicconfig where (IPEnabled=True) GET Description,SettingID,MACAddress
echo. & echo    RESTART PC NOW!
echo.
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
goto:SPOOF
:choice2
shutdown /r /t 0
:choice3
shutdown /s /t 0

:: GENERATING UUID/GUID
for /f "usebackq" %%a in (`powershell -c [guid]::NewGuid(^).ToString(^)`) do (
	set RGUID=%%a
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



rem Hostname/username change

wmic useraccount where caption='%USERNAME%' rename %user%
REG ADD "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "NV Hostname" /t REG_SZ /d %hostname% /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v Hostname /t REG_SZ /d %hostname% /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v ComputerName /t REG_SZ /d %hostname% /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName /t REG_SZ /d %hostname% /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOwner /t REG_SZ /d %user% /f

rem Windows PID change

REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductId /t REG_SZ /d 00331-%m4%-00001-A!_RndAlphaNum2! /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId /t REG_BINARY  /d A40000000%i3%00003030%i4%312D3836382D303030303030372D383535353700AA0000005831352D333%i5%3000000000000000C3AABF%Hex0%BA18B8878E89D%Hex0%000000000000396CC459B%i5%D0300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000%Hex1%6736 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId4 /t REG_BINARY  /d %Hex8%0400000030003000330037%Hex1%002D00300030003100370030002D003800360038002D003000300030003000300030002D00300033002D0031003000330033002D0037003600300031002E0030003000300030002D003200360035003200300031003700000000000000000000000000000000000000000000000000000000000000000062003900320065003%Hex8%80030002D0062003900%i3%035002D0034003800320031002D0039006300390034002D003100340030006600360033003200660036003300310032000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000%i4%6F0066006500730073006%Hex1%F006E0061006C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C3AABFA65BBA18B8%i4%89D24ED80000C61%Hex8%D0BEDFD25E%Hex1%45B89FFF45564B8%i4%4E87CB968EC7F4D18F6E5066261A0B704B9D2739558B7E97DF882AB087AB0D8A314BA9BB1E06029EA28D5800310035002D0033003900310037003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000056006F006C0075006D006%i4%A00470056004C004B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000056006F006C007%i4%D0065000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 /f

rem InternetExplorer PID change

REG ADD "HKLM\SOFTWARE\Microsoft\Internet Explorer\Registration" /v ProductId /t REG_SZ /d 00331-10000-00001-A!_RndAlphaNum2! /f
REG ADD "HKLM\SOFTWARE\Microsoft\Internet Explorer" /v svcKBNumber /t REG_SZ /d KB3170%d2% /f

rem Install date change

REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v InstallDate /t REG_DWORD /d 150%d2%%d1% /f
REG ADD "HKLM\SOFTWARE\Microsoft\Internet Explorer\Migration" /v "IE Installed Date" /t REG_BINARY /d 150%d2%%d1% /f

:: CKCL GUID

REG ADD "HKLM\SYSTEM\ControlSet001\Control\Diagnostics\Performance\BootCKCLSettings" /v GUID /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-3e%Hex10%} /f
REG ADD "HKLM\SYSTEM\ControlSet001\Control\Diagnostics\Performance\SecondaryLogonCKCLSettings" /v GUID /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-3e%Hex10%} /f
REG ADD "HKLM\SYSTEM\ControlSet001\Control\Diagnostics\Performance\ShutdownCKCLSettings" /v GUID /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-3e%Hex10%} /f

rem Windows WMI Guid (individual for each system)
rem REG ADD "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AppModel" /v GUID /t REG_SZ /d {A922A8BE-%Hex1%-%Hex0%-%Hex1%-92%Hex10%} /f

rem Enum ID (individual for each system)
rem REG ADD "HKLM\SYSTEM\ControlSet001\Enum\ACPI"

rem EDGE (individual for each system)
rem HKEY_USERS\SID\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ExtensionsStore\datastore\usage\dscc_inventory\ExtensionInventoryVersionGUID_DONOTUSEINSTORE
REG ADD "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ExtensionsStore\datastore\usage\dscc_inventory\ExtensionInventoryVersionGUID_DONOTUSEINSTORE" /v value /t REG_SZ /d {27720B92-%Hex1%-%Hex0%-%Hex1%-92%Hex10%} /f


rem WSUS change
net stop wuauserv
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /t REG_SZ /d %Hex8%-%Hex1%-%Hex0%-%Hex1%-c9%Hex10% /f  
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientIDValidation /t REG_BINARY /d A40000000%i3%00003030%i4%312D3836382D30303%Hex10%D383535353700AA0000005831352D333%i5%3000000000000000C3AABF%Hex0%BA18B8878E89D%Hex0%000000000000396CC459B%i5%D0300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000%Hex1%6736 /f 
net start wuauserv 

rem SID\Network Adapter GUID\DTC\DHCPv6 (CHANGE PATH TO SOFTWARE SIDCHG http:\\www.stratesave.com\html\sidchg.html)
C:\sidchg64\sidchg64.exe /F /R /KEY

rem VolumeID change
C:\antiOS\Volumeid64.exe C: !_RndAlphaNum!0-!_RndAlphaNum2!
