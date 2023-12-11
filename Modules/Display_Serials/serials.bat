@echo off
mode con:cols=105 lines=65 & cls

:: ====================================================================================================
:: Obtaining & Displaying - Serial(s)/GUID(s)/UUID(s)/MAC Address(es)
::
:: Get-WMIObject -List| Where{$_.name -match "^Win32_"} | Sort Name | Format-Table Name
:: ====================================================================================================

chcp 65001>nul

echo  • [31mSID[0m
wmic path Win32_UserAccount get name,sid
echo  • [31mBIOS[0m
wmic path Win32_BIOS get Manufacturer,SerialNumber
echo  • [31mMotherboard[0m
wmic path Win32_BaseBoard get Product,SerialNumber
echo  • [31mSMBIOS UUID[0m
wmic path Win32_ComputerSystemProduct get Name,UUID,Vendor
echo  • [31mChassis[0m
wmic path Win32_SystemEnclosure get Manufacturer,SerialNumber
echo  • [31mCPU[0m
wmic path Win32_Processor get Name,SerialNumber
echo  • [31mHDDs[0m
wmic path Win32_DiskDrive get Model,SerialNumber
echo  • [31mGPU[0m
wmic path Win32_VideoController get Name,PNPDeviceID
echo  • [31mNICs[0m
wmic path Win32_NetworkAdapter where "NetEnabled='true'" get Name,MACAddress
echo  • [31mProduct ID[0m
wmic path Win32_OperatingSystem get Caption,SerialNumber
echo  • [31mRAM[0m
wmic path Win32_PhysicalMemory get Manufacturer,SerialNumber
echo  • [31mVolumeID[0m
chcp 437>nul
for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
	if exist "%%A:\" (
		for /f "tokens=5" %%B in ('vol %%A: ^| find "-"') do (
			if not "The system cannot find the path specified."=="%%B:" (
				echo (%%A:^) ^> %%B
			)
		)
	)
)

pause >nul
exit /b 0

:: ====================================================================================================