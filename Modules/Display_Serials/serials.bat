@echo off


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
wmic path win32_Processor get SerialNumber /value ^| find "="

echo - [31mGPU - (Graphical Processing Unit)[0m -----
wmic path win32_VideoController get name^,PNPDeviceID /value ^| find "="

echo - [31mRAM - (System Memory)[0m -----
wmic path win32_PhysicalMemory get SerialNumber /value ^| find "="

echo - [31mSSD/HDD - (Solid State/Hard Disk Drive(s))[0m ------
wmic path win32_DiskDrive get model^,SerialNumber /value ^| find "="

echo - [31mSMBIOS - (System Motherboard BIOS)[0m -----
wmic path win32_BaseBoard get SerialNumber /value ^| find "="
wmic path win32_ComputerSystemProduct get UUID /value ^| find "="

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

echo( && echo - [31mMAC Address - (Media Access Control)[0m -----
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




wmic path win32_BaseBoard get SerialNumber /value ^| find "="
wmic path win32_BIOS get SerialNumber /value ^| find "="
wmic path win32_ComputerSystemProduct get UUID /value ^| find "="
wmic path win32_DiskDrive get SerialNumber /value ^| find "="
wmic path win32_NetworkAdapter get MACAddress /value ^| find "="
wmic path win32_OperatingSystem get SerialNumber /value ^| find "="
wmic path win32_PhysicalMemory get SerialNumber /value ^| find "="
wmic path win32_Processor get SerialNumber /value ^| find "="
wmic path win32_VideoController get PNPDeviceID /value ^| find "="