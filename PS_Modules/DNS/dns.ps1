# Quad9 DNS servers
$Ipv4PrimaryDns = '9.9.9.9'
$Ipv4BackupDns = '149.112.112.112'
$Ipv6PrimaryDns = '2620:fe::fe'
$Ipv6BackupDns = '2620:fe::9'

Get-NetAdapter | Where-Object Status -eq 'Up' | ForEach-Object {
    Set-DnsClientServerAddress -InterfaceIndex $_.ifIndex -ServerAddresses $Ipv4PrimaryDns, $Ipv4BackupDns, $Ipv6PrimaryDns, $Ipv6BackupDns
}

Clear-DnsClientCache