:: ==============================
::     Windows Spoofer v6.0
:: ==============================
:: Dev  - Scut1ny
:: Link - https://github.com/Scrut1ny/Windows-Spoofer
:: ==============================

@echo off
setlocal EnableDelayedExpansion

fltmc >nul 2>&1 || (
    echo(&echo   [33m# Administrator privileges are required.&echo([0m
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo   [33m# Right-click on the script and select "Run as administrator".[0m
        >nul pause&exit 1
    )
    exit 0
)

:MENU
cls&title https://github.com/Scrut1ny/Windows-Spoofer ^| v6.0
echo(
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

for /f "delims=[] tokens=2" %%a in ('ping -4 %ComputerName% ^| findstr="["') do set LIP=%%a
for /f %%a in ('curl -fs api.ipify.org') do set PIP4=%%a
for /f %%a in ('curl -fs api64.ipify.org') do set PIP6=%%a
for /f "delims=, tokens=1,2,3,4,5,6,7,8,9" %%a in ('curl -fs http://ip-api.com/csv/!PIP4!?fields=66846719') do set IPInfo=%%a

if !ERRORLEVEL!==0 (
	echo(
	echo 
	echo(
	
goto :MENU
exit /b

:SPOOF
cls&title Spoofing Windows...

echo(&echo   # [31mWARNING:[0m [33mDon't turn off system.[0m

echo(&echo   # [35mTerminating Conflicting Processes[0m&echo(

>nul 2>&1(
	ipconfig/release
	net stop msiserver rem https://www.minitool.com/news/windows-installer-service.html
)




:: ====================================================================================================
:: MAC Address
:: ====================================================================================================

>nul 2>&1(
	rem REG delete "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0000" /v "OriginalNetworkAddress" /f rem Microsoft Kernel Debug Network Adapter
	rem REG delete "HKLM\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "OriginalNetworkAddress" /f rem Actual NIC
)

:: ====================================================================================================




:: SPOOFING REG

echo   # [35mSpoofing Registry (HWID - SID - GUID/UUID - Time/Dates...)[0m&echo(




:: ====================================================================================================
:: SID
:: ====================================================================================================

>nul 2>&1(
	for /f "tokens=7 delims=\" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" ^| find "S-1-5-21"') do (
		set SID=%%a
	)
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-18" /v "Sid" /t REG_BINARY /d "%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-4%" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\!SID!" /v "Sid" /t REG_BINARY /d "%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-1%" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: Monitor
:: ====================================================================================================

>nul 2>&1(
	set counter=-1
	for /f "skip=1 tokens=7 delims=\" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\Default_Monitor"') do (
		set /a counter+=1
		set display[!counter!]=%%a
	)
call :RGUID
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\Default_Monitor\!display[0]!" /v "ClassGUID" /t REG_SZ /d "{!RGUID!}" /f
call :RGUID
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\Default_Monitor\!display[1]!" /v "ClassGUID" /t REG_SZ /d "{!RGUID!}" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: MSSMBIOS
:: ====================================================================================================

>nul 2>&1(
	net stop winmgmt /Y
	reg add "HKLM\SYSTEM\CurrentControlSet\Services\mssmbios\Data" /v "AcpiData" /t REG_BINARY /d "4D%random:~-5%73C00000001F4414C41534B4141204D2049000000092007014D534654130001000000000000000000000000F0000000000000007F0000000046414350140100000680414C41534B4141204D204920000009200701414D4920130001000000CCBC00905CBB00010900B2000000A0A1000000080000000000000408000000000000415049435E0100000315414C41534B4141204D204920000009200701414D4920130001000000E0FE010000000008000001000000000802020100000000080404010000000008060849565253D000000002D8414D44202000416D645461626C6501000000414D44200000000041302000000000000000000010B04800020040000000B8FE00000000000000006E8F0480485045543800000001BD414C41534B4141204D204900000009200701414D49200500000001822210004000000000D0FE0000000000EE3700465044544400000001EC414C41534B4141204D204920000009200701414D492013000001000010010000000000B051BB000000000100100100000000009057BB0000000053534454988C0000021A414D44000000416D645461626C65020000004D5346540000000453534454988C0000021A414D44000000416D645461626C65020000004D5346540000000453534454988C0000021A414D44000000416D645461626C65020000004D53465400000004464944549C00000001C1414C41534B4141204D204900000009200701414D49201300010024464944047800314154584830310000B0D2A30ACD9BE99A9ADB36CD0819803B3035003153534454988C0000021A414D44000000416D645461626C65020000004D5346540000000453534454988C0000021A414D44000000416D645461626C65020000004D5346540000000443524154D00B000001FA414D44000000416D645461626C6501000000414D442001000000300000000100000000000000002800000500000000000000000000000C00000000000000434449542900000001E7414D44000000416D645461626C6501000000414D442001000000010000000A53534454988C0000021A414D44000000416D645461626C65020000004D5346540000000453534454988C0000021A414D44000000416D645461626C65020000004D5346540000000457534D54280000000165414C41534B4141204D204920000009200701414D4920130001000700000053534454988C0000021A414D44000000416D645461626C65020000004D53465400000004" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Services\mssmbios\Data" /v "BiosData" /t REG_BINARY /d "0A%random:~-5%07E004D0048007A0000000400000004000000480D00002C00000043006F006D0070006F006E0065006E007400200049006E0066006F0072006D006100740069006F006E0000000300000010000000000000000000000000000000000000002600000043006F006E00660069006700750072006100740069006F006E002000440061007400610000000900000010000000FFFFFFFFFFFFFFFF0000000000000000160000004900640065006E007400690066006900650072000000010000004600000041004D004400360034002000460061006D0069006C00790020003200330020004D006F00640065006C002000380020005300740065007000700069006E00670020003200000028000000500072006F0063006500730073006F0072004E0061006D00650053007400720069006E0067000000010000006000000041004D0044002000520079007A0065006E00200035002000320036003000300020005300690078002D0043006F00720065002000500072006F0063006500730073006F00720020002000200020002000200020002000200020002000200000001C0000005500700064006100740065002000530074006100740075007300000004000000040000000100000022000000560065006E0064006F0072004900640065006E007400690066006900650072000000010000001A000000410075007400680065006E0074006900630041004D0044000000" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Services\mssmbios\Data" /v "RegistersData" /t REG_BINARY /d "%random:~-5%000000000000D0000004175746863414D44656E7469000000000000000000000000000000000000000001000000820F800000080C0B0B32D87EFFFB8B170000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000005000000400000004000000003000000110000000000000000000000000000000000000000000000060000000400000000000000010000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000A0000000000000000000000000000000000000000000000000000000000000000000000000000000B0000000000000000000000000000000000000000000000000000000000000000000000000000000C0000000000000000000000000000000000000000000000000000000000000000000000000000000D000000000000000000000000000000000000000000000000000000000000000000000001000000800000C0014D00000000000000000000000000000000000000000000000000000000000000000000000000801F0000804175746863414D44656E7469000000000000000000000000000000000000000001000080820F800000000020FF33C235FFFBD32F000000000000000000000000000000000000000002000080414D442052797A656E20352032363030000000000000000000000000000000000000000003000080205369782D436F72652050726F636573000000000000000000000000000000000000000004000080736F722020202020202020202020200000000000000000000000000000000000000000000500008040FF40FF40FF40FF400108204001044000000000000000000000000000000000000000000600008000640026006400664061000240818000000000000000000000000000000000000000000007000080000000001B000000000000009967000000000000000000000000000000000000000000000800008030300000071000000B400000000000000000000000000000000000000000000000000000090000800000000000000000000000000000000000000000000000000000000000000000000000000A000080010000000080000000000000FFBC010000000000000000000000000000000000000000000B0000800000000000000000000000000000000000000000000000000000000000000000000000000C0000800000000000000000000000000000000000000000000000000000000000000000000000000D0000800000000000000000000000000000000000000000000000000000000000000000000000000E0000800000000000000000000000000000000000000000000000000000000000000000000000000F0000800000000000000000000000000000000000000000000000000000000000000000000000001000008000000000000000000000000000000000000000000000000000000000000000000000000011000080000000000000000000000000000000000000000000000000000000000000000000000000120000800000000000000000000000000000000000000000000000000000000000000000000000001300008000000000000000000000000000000000000000000000000000000000000000000000000014000080000000000000000000000000000000000000000000000000000000000000000000000000150000800000000000000000000000000000000000000000000000000000000000000000000000001600008000000000000000000000000000000000000000000000000000000000000000000000000017000080000000000000000000000000000000000000000000000000000000000000000000000000180000800000000000000000000000000000000000000000000000000000000000000000000000001900008040F040F000000000000000000000000000000000000000000000000000000000000000001A0000800300000000000000000000000000000000000000000000000000000000000000000000001B000080FF03000000000000000000000000000000000000000000000000000000000000000000001C0000800000000000000000000000000000000000000000000000000000000000000000000000001D0000800000000000000000000000000000000000000000000000000000000000000000000000001E0000800B00000005010000000000000000000000000000000000000000000000000000000000001F0000800F0000006F0100000F0000000000000000000000000000000000000000000000" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Services\mssmbios\Data" /v "SMBiosData" /t REG_BINARY /d "%random:~-5%800CE090000001A0000010200F003FF8098FB7F01000000030D0511FFFF1000416D65726963616E204D6567617472656E647320496E7465726E6174696F6E616C2C204C4C432E00412E4B330030342F32332F323032310000011B010001020304000000000000000000000000000000000605064D6963726F2D5374617220496E7465726E6174696F6E616C20436F2E2C204C74642E004D532D3742373900322E3000546F2062652066696C6C6564206279204F2E452E4D2E00546F2062652066696C6C6564206279204F2E452E4D2E00546F2062652066696C6C6564206279204F2E452E4D2E0000020F02000102030405090603000A004D6963726F2D5374617220496E7465726E6174696F6E616C20436F2E2C204C74642E00583437302047414D494E4720504C555320284D532D374237392900322E30004A323136323334383939002020202020202020202020202020202020202020202000546F2062652066696C6C6564206279204F2E452E4D2E0000031603000103020304030303030000000000010003054D6963726F2D5374617220496E7465726E6174696F6E616C20436F2E2C204C74642E00322E300020202020202020202020202020202020202020202020002020202020202020202020202020202020202020202000546F2062652066696C6C6564206279204F2E452E4D2E00000911040001A50D040400000C01000000084A36423200000911050001A508040301000C01000000E34A36423100000911060001A508040302000C01000000E44A36443100000911070001A508040303000C01000000E54A37423100000911080001A508040304000C01000000E64A38423400000911090001A508040305000C01000000E74A384431000009110A00010605040306000C01000000F04A38423300000B050B0001546F2062652066696C6C6564206279204F2E452E4D2E00000C050C0001546F2062652066696C6C6564206279204F2E452E4D2E000020140D000000000000000000000000000000000000002C090E00FFFF010100000012170F0003020200000000000000800000008000000080000010171000030303000000080F00040000000000000000000000131F110000000000FFFFFF00100002000000000000000000000000000000000000071312000180014002400210001000010605074C31202D204361636865000007131300018101000C000C10001000010605074C32202D2043616368650000071314000182010040004010001000010605084C33202D20436163686500000430150001036B02820F8000FFFB8B17038B64003C0F480D413112001300140004050606060CFC006B00060006000C00414D3400416476616E636564204D6963726F20446576696365732C20496E632E00414D442052797A656E20352032363030205369782D436F72652050726F636573736F722020202020202020202020200020202020202020002020202020202000556E6B6E6F776E0000121716000302020000000000000080000000800000008000001128170010001600FFFFFFFF0000020001020204005508030400050000000000550800000000000044494D4D2030005030204348414E4E454C204100556E6B6E6F776E002020202020202000556E6B6E6F776E0000121718000302020000000000000080000000800000008000001128190010001800400040000020090001021A804055080304000501000000005508B004B004B00444494D4D2031005030204348414E4E454C204100556E6B6E6F776E00202020202020202000343430302043313920536572696573000014231A0000000000FFFFFF0019001100FFFFFF00000000000000000000000000000000000012171B0003020200000000000000800000008000000080000011281C0010001B00FFFFFFFF0000020001020204005508030400050000000000550800000000000044494D4D2030005030204348414E4E454C204200556E6B6E6F776E002020202020202000556E6B6E6F776E000012171D0003020200000000000000800000008000000080000011281E0010001D00400040000020090001021A804055080304000501000000005508B004B004B00444494D4D2031005030204348414E4E454C204200556E6B6E6F776E00202020202020202000343430302043313920536572696573000014231F0000000000FFFFFF001E001100FFFFFF0000000000000000000000000000000000000809200001000212104A313530300055534220332E3000000809210001000212104A313530310055534220332E3000000809220001000212104A31353032005553422D4300000809230001000212104A313530330055534220332E3000000809240001000212104A313530340055534220332E310000080925000100020B1F4A31353033004E6574776F726B00000809260001220200204A313730340053617461204578707265737300000809270001220200204A313730350053617461204578707265737300000809280001220200204A3137303100695341544100000809290001220200204A31373032006953415441000008092A0001220200204A31373033006953415441000008092B0001220200204A31373036006953415441000008092C00010002001C4A313130300048444D49000008092D00010002001C4A313130310048444D49000008092E00010002001C4A31313032004450000008092F000100021F1D4A323130300046726F6E7420417564696F0000080930000100021F1D4A3231303100417564696F204A61636B00000809310001220200204A313730300053617461204578707265737300000911320001AA0D040307000401000000194A313000000911330001A90B030308000401000000FF4A33363030205063696520783820736C6F7400000911340001A80A010320000401000000FF4A33373037205063696520783420736C6F7400000911350001A80A030302000401000000FF4A33373030205043494520783420736C6F742066726F6D2050726F6D6F6E746F727900000911360001A608030303000401000000FF4A33373032205043494520783120736C6F742066726F6D2050726F6D6F6E746F727900000911370001A608030304000401000000FF4A33373033205043494520783120736C6F742066726F6D2050726F6D6F6E746F727900000911380001A608040305000401000020084A33373031204D2E3220574C414E2F425420736C6F740000290B39000105010000030042726F6164636F6D203537363200008F103A00000102030405060708090A0B5642494F532D3030303000524149442D31342E382E302E31303432005058454C312D76322E312E312E3500414D492D417074696F5600475345532D352F3500526176656E50492D524156454E5F50495F56455253494F4E004D6174697373652D4C495445004E2F41004E2F41004E2F41004E2F41004E2F4100007F043B000000" /f
	net start winmgmt /Y
)

:: ====================================================================================================




:: ====================================================================================================
:: NVIDIA
:: ====================================================================================================

>nul 2>&1(
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
:: BIOS
:: ====================================================================================================

>nul 2>&1(
	reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardManufacturer" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardProduct" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BaseBoardVersion" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSReleaseDate" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSVendor" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "BIOSVersion" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemFamily" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemManufacturer" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemProductName" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemSKU" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\HARDWARE\DESCRIPTION\System\BIOS" /v "SystemVersion" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: HwProfileGuid
:: ====================================================================================================

>nul 2>&1(
	call :RGUID
	reg add "HKLM\SYSTEM\ControlSet001\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!RGUID!}" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001" /v "HwProfileGuid" /t REG_SZ /d "{!RGUID!}" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: MachineGuid
:: ====================================================================================================

rem Contains a UUID which is tracked & used by Anti-Cheats.

>nul 2>&1(
	DEL /F /Q "%HOMEDRIVE%\System32\restore\MachineGuid.txt"
)

:: ====================================================================================================




:: ====================================================================================================
:: HardwareConfig
:: ====================================================================================================

>nul 2>&1(
	call :RGUID
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "BaseBoardManufacturer" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "BaseBoardProduct" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "BIOSReleaseDate" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "BIOSVendor" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "BIOSVersion" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "BootDriverFlags" /t REG_DWORD /d "0" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "EnclosureType" /t REG_DWORD /d "3" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "Id" /t REG_DWORD /d "0" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "LastUse" /t REG_BINARY /d "%random:~-2%ACBEC%random:~-2%E1AD%random:~-3%" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "SystemBiosVersion" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "SystemFamily" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "SystemManufacturer" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "SystemProductName" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "SystemSKU" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
	reg add "HKLM\SYSTEM\HardwareConfig\!RGUID!" /v "SystemVersion" /t REG_SZ /d "SPOOFED-%random:~-5%" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: Cryptography
:: ====================================================================================================

>nul 2>&1(
	call :RGUID
	net stop cryptsvc
	reg add "HKLM\SOFTWARE\Microsoft\Cryptography" /v "MachineGuid" /t REG_SZ /d "!RGUID!" /f
	DEL /F /S /Q "%HOMEDRIVE%\System32\catroot2\dberr.txt"
	DEL /F /S /Q "%HOMEDRIVE%\System32\catroot2.log"
	DEL /F /S /Q "%HOMEDRIVE%\System32\catroot2.jrs"
	DEL /F /S /Q "%HOMEDRIVE%\System32\catroot2.edb"
	DEL /F /S /Q "%HOMEDRIVE%\System32\catroot2.chk"
	net start cryptsvc
)

:: ====================================================================================================




:: ====================================================================================================
:: Physical Drives
:: ====================================================================================================

>nul 2>&1(
    for /f "tokens=5 delims=\" %%A in ('reg query "HKLM\HARDWARE\DEVICEMAP\Scsi"') do (
        reg add "HKLM\HARDWARE\DEVICEMAP\Scsi\%%A\Scsi Bus 0\Target Id 0\Logical Unit Id 0" /v "DeviceIdentifierPage" /t REG_BINARY /d "%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-2%" /f
        reg add "HKLM\HARDWARE\DEVICEMAP\Scsi\%%A\Scsi Bus 0\Target Id 0\Logical Unit Id 0" /v "InquiryData" /t REG_BINARY /d "%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-5%%random:~-2%" /f
        reg add "HKLM\HARDWARE\DEVICEMAP\Scsi\%%A\Scsi Bus 0\Target Id 0\Logical Unit Id 0" /v "SerialNumber" /t REG_SZ /d "%random:~-5%%random:~-5%%random:~-5%" /f
    )
)

:: ====================================================================================================




:: ====================================================================================================
:: DiskPeripheral Identifier
:: ====================================================================================================

>nul 2>&1 (
    for /f "tokens=10 delims=\" %%A in ('2^>nul reg query "HKLM\HARDWARE\DESCRIPTION\System\MultifunctionAdapter\0\DiskController\0\DiskPeripheral"') do (
        reg add "HKLM\HARDWARE\DESCRIPTION\System\MultifunctionAdapter\0\DiskController\0\DiskPeripheral\%%A" /v "Identifier" /t REG_SZ /d "%random:~-5%%random:~-3%-%random:~-5%%random:~-3%-A" /f
    )
)

:: ====================================================================================================




:: ====================================================================================================
:: SQMClient
:: ====================================================================================================

>nul 2>&1(
	call :RGUID
	reg add "HKCU\SOFTWARE\Microsoft\SQMClient" /v "MachineId" /t REG_SZ /d "{!RGUID!}" /f
	reg add "HKLM\SOFTWARE\Microsoft\SQMClient" /v "MachineId" /t REG_SZ /d "{!RGUID!}" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: SystemInformation
:: ====================================================================================================

>nul 2>&1(
	rem System Name
	reg add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "Hostname" /t REG_SZ /d "%random:~-5%" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "NV Hostname" /t REG_SZ /d "%random:~-5%" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v "ComputerName" /t REG_SZ /d "%random:~-5%" /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v "ComputerName" /t REG_SZ /d "%random:~-5%" /f
	rem SystemInformation
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v "BIOSReleaseDate" /t REG_SZ /d "0%random:~-1%/1%random:~-1%/%random:~-4%" /f
	call :RGUID
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v "ComputerHardwareId" /t REG_SZ /d "{!RGUID!}" /f
	call :RGUID
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v "ComputerHardwareIds" /t REG_MULTI_SZ /d "{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}"\0"{!RGUID!}" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: CurrentVersion
:: ====================================================================================================

>nul 2>&1(
	call :RGUID
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "BuildGUID" /t REG_SZ /d "!RGUID!" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "DigitalProductId" /t REG_BINARY /d "A4%random:~-5%00300000036303437312D3436342D313734353137392D32343434329BCCB84B60916EDDF5BFA0BCA94E703DB16744F61B839018FEBAE6B73951DAD9022A04BB7700ECB0F148A4E92725099A9FEDEB4C1FB559F2C6E2663F76A56C5A08EE453A1E717E268CD7567A01DEAB94A2C2B3745385C7E805AF2C639EB412280EE3847C3716FDCB6A368A433C1C6DA768111ACA6FDB8B2F7996E00D871035FA78B9EC21734640BE4FE72%random:~-5%" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "DigitalProductId4" /t REG_BINARY /d "F8%random:~-5%000000000300039003000310039002D00300031003800360038002D003900340039002D003100340032003600360039002D00350038002D0039003200310037002D00370030003900300098003000300030003000320030003100360000000000000000000000000000000000000000000000000000000000000000000000000000000000380035006400360033006500660039002D0038003600650064002D0034006400610063002D0038003500380033002D0037006400640030003600390038003100380031006600320000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000048006F006D0065004200610073006900630000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000043681595728B7A010A675222F920AEEB6461EE02802353350F862A2470E4A92E8A9F2DBA072C5FA7DD32363B579EC30D1E0938DCACCF483DE18737FD7B4B59CDD79974F8B77D56D389B1145E03E26F664200360039002D00320035003500300031000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000520065007400610069006C000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000520065007400610069006C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "DisplayVersion" /t REG_SZ /d "00H0" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "InstallDate" /t REG_DWORD /d "5a%random:~-4%e6" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "InstallTime" /t REG_QWORD /d "1d%random:~-5%e23fc090" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductId" /t REG_SZ /d "%random:~-4%-%random:~-4%-%random:~-4%-%random:~-5%" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "RegisteredOwner" /t REG_SZ /d "%random%" /f

	rem WSUS change	
	net stop wuauserv
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v "SusClientId" /t REG_SZ /d "!RGUID!" /f  
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v "SusClientIDValidation" /t REG_BINARY /d "%random:~-5%%random:~-5%2C53003400310%random:~-5%4E00580030004D00330031003%random:~-5%00320033005A002000200020002000200006001A7DDA710C0600D8613A05B44A%random:~-5%03100360032003300340038003900390054006F00200062006500%random:~-5%60069006C006C006500640020006200790020004F002E0045002E%random:~-5%%random:~-5%" /f 
	net start wuauserv

	reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Migration" /v "IE Installed Date" /t REG_BINARY /d "" /f
	reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\Registration" /v "ProductId" /t REG_SZ /d "!RGUID!" /f rem InternetExplorer PID change
	reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer" /v "svcKBNumber" /t REG_SZ /d "KB%random:~-5%%random:~-3%" /f
)

:: ====================================================================================================




:: ====================================================================================================
:: VolumeID - Shadow Copies - USN Journal ID
:: ====================================================================================================

>nul 2>&1(
	rem Spoofs VolumeID xxxx-xxxx
	Volumeid64.exe %HOMEDRIVE% %random:~-4%-%random:~-4% -nobanner
	Volumeid64.exe D: %random:~-4%-%random:~-4% -nobanner
	
	rem Resets all status's of the physical disk(s).
	powershell Reset-PhysicalDisk *
	
	rem deletes all volume shadow copies.
	wmic shadowcopy delete /nointeractive
	vssadmin delete shadows /all /quiet
	
	rem Anti-Cheats use "USN Journal IDs" as a HWID tagging mechanism, so we delete them.
	fsutil usn deleteJournal /d %HOMEDRIVE%
	fsutil usn deleteJournal /d D:
	fsutil usn deleteJournal /d E:
	fsutil usn deleteJournal /d F:
)

:: ====================================================================================================


pause

:: ====================================================================================================
:: Windows Logs, Traces, Networking, etc
:: ====================================================================================================

echo   # [35mCleaning Traces[0m

:: Files

>nul 2>&1(
	DEL /F /S /Q "%LOCALAPPDATA%\Microsoft\CLR_v4.0\UsageTraces\*"
	DEL /F /S /Q "%LOCALAPPDATA%\Microsoft\CLR_v4.0_32\UsageTraces\*"
	DEL /F /S /Q "%LOCALAPPDATA%\Microsoft\Windows\WebCache\*"
	DEL /F /S /Q "%HOMEDRIVE%\UserviceProfiles\NetworkService\NTSER.dat"
	DEL /F /S /Q "%HOMEDRIVE%\UserviceProfiles\LocalService\AppData\Local\Microsoft\Windows\qwavecache.dat"
	DEL /F /S /Q "%HOMEDRIVE%\memory.dmp"
	DEL /F /S /Q "%HOMEDRIVE%\win.ini"
	DEL /F /S /Q "%HOMEDRIVE%\debug"
	DEL /F /S /Q "%HOMEDRIVE%\Logs"
	DEL /F /S /Q "%HOMEDRIVE%\CbsTemp\*"
	DEL /F /S /Q "%HOMEDRIVE%\ModemLogs\*"
	DEL /F /S /Q "%HOMEDRIVE%\Prefetch\*"
	DEL /F /S /Q "%HOMEDRIVE%\rescache\_merged\*"
	DEL /F /S /Q "%HOMEDRIVE%\SchCache\*"
	DEL /F /S /Q "%HOMEDRIVE%\PerfLogs\*"
	DEL /F /S /Q "%HOMEDRIVE%\desktop.ini"
	DEL /F /S /Q "%HOMEDRIVE%\MSOCache\*"
	DEL /F /S /Q "%HOMEDRIVE%\Recovery\*"
	DEL /F /S /Q "%HOMEDRIVE%\AMD"
	DEL /F /S /Q "%HOMEDRIVE%\Intel"
	DEL /F /S /Q "%HOMEDRIVE%\Users\Public\*"
	DEL /F /S /Q "%HOMEDRIVE%\Performance\WinSAT\winsat.log"
	DEL /F /S /Q "%HOMEDRIVE%\debug\PASSWD.LOG"
	DEL /F /S /Q "%HOMEDRIVE%\Logs\SIH\*"
	DEL /F /S /Q "%HOMEDRIVE%\Traces\WindowsUpdate\*"
	DEL /F /S /Q "%HOMEDRIVE%\System32\LogFiles\setupcln\*"
	DEL /F /S /Q "%HOMEDRIVE%\Logs\NetSetup\*"
	DEL /F /S /Q "%homepath%\AppData\Local\Microsoft\Windows\Explorer\iconcache*"
	DEL /F /S /Q "%homepath%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"
	DEL /F /S /Q "%windir%\SoftwareDistribution\Download\*"
	
	IF EXIST "%HOMEDRIVE%\Windows.old" (
		takeown /f "%HOMEDRIVE%\Windows.old" /a /r /d y
		icacls "%HOMEDRIVE%\Windows.old" /grant administrators:F /t
		rd /s /q "%HOMEDRIVE%\Windows.old"
	)
	
	DEL /F /S /Q %tmp%\*
	DEL /F /S /Q %HOMEDRIVE%\*.log *.etl *.tmp *.hta
	
	rem Emptying Recycle Bins & Resetting explorer.exe
	powershell Clear-RecycleBin -Force -ErrorAction SilentlyContinue
	taskkill /F /IM explorer.exe&explorer.exe
)

:: Networking

>nul 2>&1(
	rem delete all Network Data Usage & Disable it.
	sc stop "DPS" & sc config "DPS" start= disabled
	DEL /F /S /Q "%windir%\System32\sru\*"
	
	rem Clear SSL State
	certutil -URLCache * delete
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2 rem Clear Cookies
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 rem Clear Temporary Internet Files
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 16 rem Clear Form Data
	RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 32 rem Clear Saved Passwords
	
	rem Misc
	arp -d * rem Clear ARP/Route Tables - Contains MAC Address's used by anti-cheats to track you.
	netsh int ip delete arpcache
	netsh int ip delete destinationcache
	netsh int ip delete neighbors
	netsh int ip reset catalog
	netsh int ip reset
	netsh int ipv4 reset
	netsh int ipv6 reset
	netsh int httpstunnel reset
	netsh int portproxy reset
	netsh int udp reset
	netsh int tcp reset
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
	nbtstat -R
	nbtstat -RR
	bcdedit -set TESTSIGNING OFF
	ipconfig/flushdns
	
	rem Switching to DHCP.
	for /f "tokens=3*" %%A in ('netsh interface show interface ^| findstr Ethernet') do (
		netsh dnsclient set dnsservers name="%%A" source=dhcp
		netsh interface ip set winsservers name="%%A" source=dhcp
		netsh interface ip set address name="%%A" dhcp
		netsh interface ip set dns name="%%A" dhcp
	)
	
	rem Resetting connections
	ipconfig/renew
	net start msiserver
)

goto :AGAIN
exit /b 0

:: ====================================================================================================




:: ====================================================================================================
:: Obtaining Serials
:: ====================================================================================================

:CheckSerials
cls

>>%~dp0\HWID.txt (
	echo(&echo - [31mWindows Product ID[0m ----------&echo(
	wmic os get serialnumber
	echo -------------------------------

	echo(&echo - [31mCPU SN[0m ----------------------&echo(
	wmic cpu get serialnumber
	echo -------------------------------

	echo(&echo - [31mRAM SN[0m ----------------------&echo(
	wmic memorychip get name^,serialnumber
	echo -------------------------------

	echo(&echo - [31mBIOS SN[0m ---------------------&echo(
	wmic bios get serialnumber
	echo -------------------------------

	echo(&echo - [31mSMBIOS SN[0m -------------------&echo(
	wmic csproduct get UUID
	echo -------------------------------

	echo(&echo - [31mMotherboard SN[0m --------------&echo(
	wmic baseboard get serialnumber
	echo -------------------------------

	echo(&echo - [31mChassis[0m ---------------------&echo(
	wmic systemenclosure get serialnumber
	echo -------------------------------

	echo(&echo - [31mHD SN[0m -----------------------&echo(
	wmic diskdrive get Model^,serialnumber
	echo -------------------------------

	echo(&echo - [31mVolumeID SN[0m -----------------&echo(
	call :VolumeID_SN
	echo C: ^> !VolID!
	echo(
	echo -------------------------------

	echo(&echo - [31mMAC SN[0m ----------------------&echo(
	wmic nicconfig where (IPEnabled=True^) GET Description^,SettingID^,MACAddress
	echo -------------------------------

	echo(&echo - [31mGPU SN[0m ----------------------&echo(
	wmic path win32_VideoController get name^,PNPDeviceID
	echo -------------------------------

	echo(&echo - [31mNVIDIA SN[0m -------------------&echo(
	call :NVIDIA_SN
	echo SerialNumber
	echo !NVIDIA!
	echo(&echo -------------------------------
)

>nul pause&goto :MENU

:: VolumeID ---------------------------------------------------
:VolumeID_SN
for /f "tokens=5" %%A in ('vol %HOMEDRIVE% ^| find "-"') do (
    set "VolID=%%A"
)
exit /b
:: ------------------------------------------------------------

:: NVIDIA -----------------------------------------------------
:NVIDIA_SN
for /f "tokens=3" %%A in ('reg query "HKLM\SOFTWARE\NVIDIA Corporation\Global\CoProcManager" ^| find "ChipsetMatchID"') do (
	set "NVIDIA=%%A"
)
exit /b
:: ------------------------------------------------------------

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
for /f "usebackq" %%a in (`powershell [guid]::NewGuid(^).ToString(^)`) do (
	set RGUID=%%a
)

:: GENERATING MAC Address
:RMAC
for /f "usebackq" %%a in (`powershell ('{0:x}' -f (Get-Random 0xFFFFFFFFFFFF^)^).padleft(12^,^"0^"^)`) do (
	set RMAC=%%a
)

:: ====================================================================================================




exit /b 0
