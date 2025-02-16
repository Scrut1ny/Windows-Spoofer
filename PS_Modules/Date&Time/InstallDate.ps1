# Generate random date between 2011-01-01 and 2022-12-31
$randomDate = Get-Random -Minimum ([datetime]'2011-01-01').Ticks -Maximum (([datetime]'2022-12-31').Ticks) | ForEach-Object {[datetime]$_}

# Convert to Unix timestamp and LDAP/FILETIME
$unixTimestamp = [int]($randomDate.ToUniversalTime() - [datetime]'1970-01-01').TotalSeconds
$ldapFileTime = [int64](($unixTimestamp + 11644473600) * 1e7)

# Update registry values with proper numeric types
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
Set-ItemProperty -Path $regPath -Name "InstallDate" -Value $unixTimestamp -Force
Set-ItemProperty -Path $regPath -Name "InstallTime" -Value $ldapFileTime -Force

# Ensure time service is running and reconfigure
Get-Service w32time | Where Status -ne Running | Start-Service
w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org,3.pool.ntp.org" /update
Restart-Service w32time -Force; w32tm /resync
