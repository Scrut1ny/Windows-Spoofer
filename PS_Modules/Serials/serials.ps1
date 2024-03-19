
# Restart "winmgmt" to update WMIC modified values
Restart-Service -Force -Name "winmgmt"

# [SMBIOS DMI] - System Information
Write-Host "  # [31m[SMBIOS DMI] - System Information[0m"
wmic path Win32_BIOS get Manufacturer,SerialNumber
wmic path Win32_ComputerSystemProduct get Name,UUID,Vendor

# [SMBIOS DMI] - Base/Main/Motherboard
Write-Host " # [31m[SMBIOS DMI] - Base/Main/Motherboard[0m"
wmic path Win32_BaseBoard get Product,SerialNumber

# [SMBIOS DMI] - System Enclosure/Chassis
Write-Host " # [31m[SMBIOS DMI] - System Enclosure/Chassis[0m"
wmic path Win32_SystemEnclosure get Manufacturer,SerialNumber

# [SMBIOS DMI] - Processor/CPU
Write-Host " # [31m[SMBIOS DMI] - Processor/CPU[0m"
wmic path Win32_Processor get Name,SerialNumber

# [SMBIOS DMI] - RAM
Write-Host " # [31m[SMBIOS DMI] - RAM[0m"
wmic path Win32_PhysicalMemory get Manufacturer,SerialNumber

# NVIDIA UUID
Write-Host " # [31mNVIDIA UUID(s)[0m"
nvidia-smi -L

# NIC
Write-Host "`n # [31mNIC(s)[0m"
wmic path Win32_NetworkAdapter where netenabled=true get MACAddress,Name,NetConnectionId

# Hard Drive
Write-Host " # [31mHard Drive(s)[0m"
wmic path Win32_DiskDrive get Model,SerialNumber

# VolumeID
Write-Host " # [31mVolumeID(s)[0m"
foreach ($driveLetter in ('A'..'Z')) {
    if (Test-Path -Path "{$driveLetter}:\") {
        $volumeInfo = Get-Volume -DriveLetter $driveLetter | Select-Object -ExpandProperty FileSystemLabel
        if ($volumeInfo -ne "The system cannot find the path specified.") {
            Write-Output "$driveLetter > $volumeInfo"
        }
    }
}

# Monitor Name & Serial
function Get-MonitorSerial {
    $monitors = Get-CimInstance -Namespace root/wmi -ClassName WmiMonitorID -ErrorAction SilentlyContinue |
                Where-Object { $_.SerialNumberID -ne $null } |
                ForEach-Object {
                    $name = [System.Text.Encoding]::ASCII.GetString($_.UserFriendlyName)
                    $serial = [System.Text.Encoding]::ASCII.GetString($_.SerialNumberID)
                    if ($name) {
                        Write-Host "${name}: $serial"
                    } else {
                        Write-Host "Monitor: $serial"
                    }
                }
}

Get-MonitorSerial

# Product ID
Write-Host " # [31mProduct ID[0m"
wmic path Win32_OperatingSystem get Caption,SerialNumber

pause
