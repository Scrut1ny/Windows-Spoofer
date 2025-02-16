function Get-LowerRandomIdentifier {
    return -join ((48..57 + 97..122) | Get-Random -Count 16) -replace '(.{8})(.{4})', '$1-$2-A'
}

function Get-UpperRandomString {
    return -join ((48..57 + 65..90) | Get-Random -Count 20 | ForEach-Object { [char]$_ })
}

function Get-RandomVolumeId {
    return (-join ((48..57 + 65..71) | Get-Random -Count 8 | ForEach-Object { [char]$_ }) -replace '(.{4})', '$1-').TrimEnd('-')
}

# Volume ID spoofing
$volumeIdPath = "$env:TEMP\Volumeid64.exe"

if (-not (Test-Path $volumeIdPath)) {
    $zipPath = "$env:TEMP\VolumeId.zip"
    Invoke-WebRequest https://download.sysinternals.com/files/VolumeId.zip -OutFile $zipPath -UseBasicParsing
    Expand-Archive $zipPath -DestinationPath $env:TEMP -Force
    Remove-Item $zipPath -Force
}

Get-PSDrive -PSProvider FileSystem | Where-Object Root -ne '' | ForEach-Object {
    $drive = $_.Root.TrimEnd('\')
    $id = Get-VolumeId
    Start-Process $volumeIdPath -Args "$drive", $id, "-nobanner", "-acceptEula" -NoNewWindow -Wait -ErrorAction SilentlyContinue
}

}

# Update DiskPeripheral identifiers
Get-ChildItem "HKLM:\HARDWARE\DESCRIPTION\System\MultifunctionAdapter\0\DiskController\0\DiskPeripheral\*" |
ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name Identifier -Value (Get-LowerRandomIdentifier) -Force
}

# Update SCSI device serial numbers
Get-ChildItem -Path 'HKLM:\HARDWARE\DEVICEMAP\Scsi' -Recurse -ErrorAction SilentlyContinue |
Where-Object { $_.PSPath -match 'Scsi Port \\d+\\Scsi Bus \\d+\\Target Id \\d+\\Logical Unit Id \\d+' } |
ForEach-Object {
    Set-ItemProperty -Path $_.PSPath -Name SerialNumber -Value (Get-UpperRandomString) -Force
}

# Volume ID spoofing - https://learn.microsoft.com/en-us/sysinternals/downloads/volumeid
$volumeIdPath = "$env:TEMP\Volumeid64.exe"

if (-not (Test-Path $volumeIdPath)) {
    $zipPath = "$env:TEMP\VolumeId.zip"
    Invoke-WebRequest https://download.sysinternals.com/files/VolumeId.zip -OutFile $zipPath -UseBasicParsing
    Expand-Archive $zipPath -DestinationPath $env:TEMP -Force
    Remove-Item $zipPath -Force
}

Get-PSDrive -PSProvider FileSystem | Where-Object Root -ne '' | ForEach-Object {
    $drive = $_.Root.TrimEnd('\')
    $id = (Get-RandomVolumeId).TrimEnd('-')
    Start-Process $volumeIdPath -Args "$drive", $id, "-nobanner", "-acceptEula" -NoNewWindow -Wait -ErrorAction SilentlyContinue > $null 2>&1
}
