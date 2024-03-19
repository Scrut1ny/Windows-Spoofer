function Get-LowerRandomIdentifier {
    $Identifier = -join (1..16 | ForEach {[char]((97..122) + (48..57) | Get-Random)})
    $FormattedIdentifier = ($Identifier -replace '(.{8})(.{8})', '$1-$2-A')
    return $FormattedIdentifier
}


function Get-UpperRandomString {
    $Identifier = -join (1..20 | ForEach {[char]((65..90) + (48..57) | Get-Random)})
    return $Identifier
}


# DiskPeripheral - Identifier(s)
$keys = Get-ItemProperty "HKLM:\HARDWARE\DESCRIPTION\System\MultifunctionAdapter\0\DiskController\0\DiskPeripheral\*" | Get-ItemProperty | ForEach-Object {$_.PSChildName}

foreach ($key in $keys) {
    $newIdentifier = Get-LowerRandomIdentifier
    Set-ItemProperty -Path "HKLM:\HARDWARE\DESCRIPTION\System\MultifunctionAdapter\0\DiskController\0\DiskPeripheral\$key" -Name 'Identifier' -Type String -Value "$newIdentifier" -Force
}


# Physical Drives (SATA/NVMe)
foreach ($PortNumber in 0..9) {
    foreach ($LogicalUnitIdNumber in 0..9) {
        $registryPath = "HKLM:\HARDWARE\DEVICEMAP\Scsi\Scsi Port $PortNumber\Scsi Bus 0\Target Id 0\Logical Unit Id $LogicalUnitIdNumber"

        if (Test-Path -Path $registryPath) {
			$NewString = Get-UpperRandomString
            Set-ItemProperty -Path $registryPath -Name 'SerialNumber' -Type String -Value "$NewString" -Force
        }
    }
}
