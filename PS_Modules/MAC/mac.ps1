# Spoof MAC Address
$newMac = ('{0:X}' -f (Get-Random -Maximum 0xFFFFFFFFFFFF)).PadLeft(12, "0") -replace '^(.)(.)', ('$1' + (Get-Random -InputObject 'A','E','2','6')) -replace '\$', ''
$adapter = (Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1).Name
Set-NetAdapter -Name "$adapter" -MacAddress "$newMac" -Confirm:$false