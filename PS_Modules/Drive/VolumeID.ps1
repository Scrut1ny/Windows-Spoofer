function Get-UpperRandomString {
    $randomChars = 65..71 + 48..57
    $randomString = -join (1..8 | ForEach-Object { [char](Get-Random -InputObject $randomChars) })
    return ($randomString -replace '(.{4})(.{4})', '$1-$2')
}

$tempPath = $env:temp
$volumeIdPath = "$tempPath\Volumeid64.exe"
$zipPath = "$tempPath\VolumeId.zip"
$testIP = "9.9.9.9"

if (-not (Test-Path $volumeIdPath)) {
    if (-not (Test-Connection -ComputerName $testIP -Count 1 -Quiet)) {
        Write-Host "No internet connection"
        exit 1
    }

    Set-Location -Path $tempPath
    Invoke-WebRequest -Uri "https://download.sysinternals.com/files/VolumeId.zip" -OutFile "VolumeId.zip" -UserAgent "Mozilla/5.0" -UseBasicParsing
    Expand-Archive -Path $zipPath -DestinationPath $tempPath -Force

    Get-ChildItem -Path "$tempPath\Volumeid64.exe" | ForEach-Object {
        $driveLetter = $_.Name.Substring(0, 1)
        $volumeId = "$($_.Name.Substring(1, 4))-$($_.Name.Substring(5, 4))"
        if (Test-Path "$driveLetter:\") {
            Start-Process -FilePath $volumeIdPath -ArgumentList "$driveLetter:", $volumeId, "-nobanner" -NoNewWindow -Wait
        }
    }
}
