::--------------------------------------
:: By: 0x00 / Anonymoushacker4926
:: Windows Spoofer
:: V4.0
::--------------------------------------

@echo off
setlocal EnableDelayedExpansion

:: Privilege Escalation - Credit: https://stackoverflow.com/a/62668457 -----------------------------------

>nul 2>&1 net sess||(powershell saps '%0'-Verb RunAs&exit /b)

::--------------------------------------------------------------------------------------------------------

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

for /f "delims=: tokens=*" %%G in ('findstr /b ::: "%~f0"') do @echo(%%G

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
for /f %%A in ('powershell Invoke-RestMethod api.ipify.org') do set PublicIP=%%A
echo.
echo  External IP: !PublicIP!
echo.
echo  PINGING...
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
taskkill /f /im Zoom.exe >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
explorer.exe >nul 2>&1
echo. & echo  [+] Spoofing MAC Address... & echo.

:: SPOOFING MACAddress

for /f "skip=5" %%F in ('getmac') do set "MAC=%%F"
echo  [+] CURRENT MAC: !MAC! & echo.
for /f "usebackq" %%A in (`powershell -command [BitConverter]::ToString([BitConverter]::GetBytes((Get-Random -Maximum 0xFFFFFFFFFFFF^)^)^, 0^, 6^).Replace(^':^'^, ^'-^'^)`) do set "MAC=%%A" & echo  [+] SPOOFED MAC: !MAC! & echo.
REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0000" /v "NetworkAddress" /t REG_SZ /d !MAC! /f >nul 2>&1 rem Microsoft Kernel Debug Network Adapter
REG ADD "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "NetworkAddress" /t REG_SZ /d !MAC! /f >nul 2>&1 rem Actual NIC
for /f "skip=2 tokens=3*" %%i in ('netsh interface show interface') do (netsh interface set interface name="%%j" admin=disabled & netsh interface set interface name="%%j" admin=enabled) >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
explorer.exe >nul 2>&1

:: SPOOFING REG

echo  [+] Spoofing BIOS... & echo.

:: SPOOFING REG BIOS - HKLM\HARDWARE\DESCRIPTION\System\BIOS

REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardManufacturer" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardProduct" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardVersion" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSReleaseDate" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSVendor" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSVersion" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemFamily" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemManufacturer" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemProductName" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemSKU" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemVersion" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1

:: SPOOFING HwProfileGuid - HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001

REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d !GUID! /f >nul 2>&1

:: SPOOFING UUID/GUID - HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\

REG DELETE "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0000" /v "OriginalNetworkAddress" /f >nul 2>&1 rem Microsoft Kernel Debug Network Adapter
REG DELETE "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "OriginalNetworkAddress" /f >nul 2>&1 rem Actual NIC
REG DELETE "HKLM\SYSTEM\HardwareConfig\!GUID1!" /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID!" /f >nul 2>&1

:: SPOOFING REG HardwareConfigs - HKLM\SYSTEM\HardwareConfig\

REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BaseBoardManufacturer" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BaseBoardProduct" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BIOSReleaseDate" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BIOSVendor" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "BIOSVersion" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemBiosVersion" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemFamily" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemManufacturer" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemProductName" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemSKU" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1
REG ADD "HKLM\SYSTEM\HardwareConfig\!GUID1!" /v "SystemVersion" /t REG_SZ /d SPOOFED-%random% /f >nul 2>&1

REG DELETE "HKLM\SYSTEM\HardwareConfig" /v "LastConfig" /f  >nul 2>&1














:: DELETING WINDOWS LOGS

echo  [+] Cleaning all traces...

del /f/s/q/a "%appdata%\Zoom\logs\*" >nul 2>&1
del /f/s/q/a "%appdata%\Zoom\reports\*" >nul 2>&1
del /f/s/q/a "%appdata%\Zoom\installer.txt" >nul 2>&1
del /f/s/q/a "%appdata%\Zoom\appsafecheck.txt" >nul 2>&1

del /f/s/q/a "%appdata%\discord\Cache\*" >nul 2>&1
del /f/s/q/a "%appdata%\discord\GPUCache\*" >nul 2>&1
del /f/s/q/a "%appdata%\discord\Code Cache\*" >nul 2>&1

del /f/s/q/a "%systemdrive%\Windows\UserviceProfiles\NetworkService\NTSER.dat" >nul 2>&1
del /f/s/q/a "%systemdrive%\Windows\UserviceProfiles\LocalService\AppData\Local\Microsoft\Windows\qwavecache.dat" >nul 2>&1
del /f/s/q/a "%systemdrive%\Windows\SchCache\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\Windows\memory.dmp" >nul 2>&1
del /f/s/q/a "%systemdrive%\Windows\win.ini" >nul 2>&1
del /f/s/q/a "%systemdrive%\Windows\debug" >nul 2>&1
del /f/s/q/a "%systemdrive%\Windows\Logs" >nul 2>&1
del /f/s/q/a "%systemdrive%\Windows\CbsTemp\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\Windows\ModemLogs\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\Windows\Prefetch\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\Windows\rescache\_merged\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\Windows\SchCache\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\PerfLogs\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\desktop.ini" >nul 2>&1
del /f/s/q/a "%systemdrive%\MSOCache\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\Users\Public\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\Recovery\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\Amd\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\Intel\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\Users\Public\*" >nul 2>&1

del /f/s/q/a "%windir%\SoftwareDistribution\Download\*" >nul 2>&1

echo. & echo  [+] Configuring NIC Settings... & echo.

:: ########################################################

netsh winsock reset >nul 2>&1
netsh winsock reset catalog >nul 2>&1
netsh winsock set autotuning off >nul 2>&1

netsh winhttp reset autoproxy >nul 2>&1
netsh winhttp reset proxy >nul 2>&1
netsh winhttp reset tracing >nul 2>&1

bcdedit -set TESTSIGNING OFF >nul 2>&1

ipconfig/flushdns >nul 2>&1

certutil -URLCache * delete >nul 2>&1

netsh dhcpclient trace disable >nul 2>&1
netsh http flush logbuffer >nul 2>&1
netsh http delete cache >nul 2>&1
netsh trace stop >nul 2>&1
netsh rpc reset >nul 2>&1
netsh branchcache reset >nul 2>&1

netsh interface ipv4 reset catalog >nul 2>&1
netsh interface ipv6 reset catalog >nul 2>&1
netsh interface ipv4 delete neighbors >nul 2>&1
netsh interface ipv4 delete arpcache >nul 2>&1
netsh interface ipv4 delete destinationcache >nul 2>&1
netsh interface ipv6 delete neighbors >nul 2>&1
netsh interface ipv6 delete destinationcache >nul 2>&1
netsh interface httpstunnel reset >nul 2>&1
netsh interface portproxy reset >nul 2>&1
netsh interface udp reset >nul 2>&1
netsh interface tcp reset >nul 2>&1
netsh interface ipv4 reset >nul 2>&1
netsh interface ipv6 reset >nul 2>&1

netsh advfirewall reset >nul 2>&1
netsh advfirewall firewall set rule group="Network Discovery" new enable=No >nul 2>&1

for /f "skip=2 tokens=3*" %%a in ('netsh interface show interface') do (
netsh dnsclient set dnsservers name="%%a" source=dhcp >nul 2>&1
netsh interface ipv4 set dns "%%a" dhcp >nul 2>&1
netsh interface ipv4 set address "%%a" dhcp >nul 2>&1
netsh interface ipv4 set winsservers "%%a" source=dhcp >nul 2>&1
netsh interface ipv6 set dns "%%a" dhcp >nul 2>&1
netsh interface set interface name="%%a" admin=disabled >nul 2>&1
netsh interface set interface name="%%a" admin=enabled >nul 2>&1)

ipconfig /release >nul 2>&1

ipconfig /renew >nul 2>&1

echo  [+] Emptying Recycle Bins... & echo.

del /f/s/q/a "%temp%\*" >nul 2>&1
del /f/s/q/a "%systemdrive%\*.log" >nul 2>&1
del /f/s/q/a "%systemdrive%\*.etl" >nul 2>&1
del /f/s/q/a "%systemdrive%\*.tmp" >nul 2>&1

powershell Clear-RecycleBin -Force -ErrorAction SilentlyContinue

:: ALL VARIABLES -------------------------------------------------------------------------------------

:: GENERATING UUID/GUID
for /f "usebackq" %%a in (`powershell -command '{'+[guid]::NewGuid(^).ToString(^)+'}'`) do set GUID=%%a

:: GENERATING MACAddress
for /f "usebackq" %%a in (`powershell -command [BitConverter]::ToString([BitConverter]::GetBytes((Get-Random -Maximum 0xFFFFFFFFFFFF^)^)^, 0^, 6^).Replace(^':^'^, ^'-^'^)`) do set MAC=%%a

:: RETRIEVING UUID/GUID
for /f %%a in ('wmic csproduct get UUID ^| find "-"') do (set "GUID1={%%a}")

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

