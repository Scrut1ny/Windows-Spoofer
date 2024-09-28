# Define start and end dates
$startDate = [datetime]::new(2011, 1, 1)
$endDate = [datetime]::new(2022, 12, 31)

# Generate a random date within the defined range
$randomDate = $startDate.AddSeconds((Get-Random -Maximum ($endDate - $startDate).TotalSeconds))

# Convert the random date to Unix timestamp and then to LDAP/FILETIME
# https://www.epochconverter.com/ldap
$unixTimestamp = [int][double]::Parse(($randomDate.ToUniversalTime() - [datetime]'1970-01-01').TotalSeconds)
$ldapFileTime = ($unixTimestamp + 11644473600) * 1e7  # Use scientific notation for clarity

# Set the InstallDate and InstallTime in the registry
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
Set-ItemProperty -Path $registryPath -Name "InstallDate" -Value "$unixTimestamp" -Force
Set-ItemProperty -Path $registryPath -Name "InstallTime" -Value "$ldapFileTime" -Force

# Ensure the Windows Time service is running
if ((Get-Service w32time).Status -eq 'Stopped') {
    Start-Service w32time
}

# Configure the NTP settings and resync
w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org,3.pool.ntp.org" /update
Restart-Service w32time -Force
w32tm /resync
