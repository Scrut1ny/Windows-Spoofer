# Generating a random date between Jan 1, 2011, and Dec 31, 2022
$start = [datetime]::new(2011, 1, 1)
$end = [datetime]::new(2022, 12, 31)
$randomDate = $start.AddSeconds((Get-Random -Maximum (($end - $start).TotalSeconds)))

# Converting the DateTime object to Unix timestamp
$unixTimestamp = [int][double]::Parse(($randomDate.ToUniversalTime() - [datetime]'1970-01-01T00:00:00').TotalSeconds)

# Calculating LDAP/FILETIME timestamp directly
$LDAP_FILETIME_timestamp = ($unixTimestamp + 11644473600) * 10000000

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "InstallDate" -Value "$unixTimestamp" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "InstallTime" -Value "$LDAP_FILETIME_timestamp" -Force

if ((Get-Service w32time).Status -eq 'Stopped') {
	Start-Service -Name w32time
}

w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org" /update
Restart-Service -Name w32time -Force ; w32tm /resync
