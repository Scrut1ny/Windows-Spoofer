function Get-UpperRandomString {
    $RandomString = -join (1..8 | ForEach {[char]((65..71) + (48..57) | Get-Random)})
	$FormattedRandomString = ($RandomString -replace '(.{4})(.{4})', '$1-$2')
    return $FormattedRandomString
}


if (-not (Test-Path "$env:temp\Volumeid64.exe")) {
    $pingResult = Test-Connection -ComputerName 9.9.9.9 -Count 1 -Quiet

    if (-not $pingResult) {
        Write-Host "No internet connection"
        exit 1
    }

    Set-Location -Path $env:temp
    Invoke-WebRequest -Uri "https://download.sysinternals.com/files/VolumeId.zip" -OutFile "VolumeId.zip" -UserAgent "Mozilla/5.0" -UseBasicParsing
    Expand-Archive -Path "$env:temp\VolumeId.zip" -DestinationPath "$env:temp"

    .\Volumeid64.exe | ForEach-Object {
        $driveLetter = $_.Substring(0, 1)
        $volumeId = "$($_.Substring(1, 4))-$($_.Substring(5, 4))"
        if (Test-Path "$driveLetter:\") {
            Start-Process -FilePath "$env:temp\Volumeid64.exe" -ArgumentList "$driveLetter:", $volumeId, "-nobanner" -NoNewWindow -Wait
        }
    }
}
