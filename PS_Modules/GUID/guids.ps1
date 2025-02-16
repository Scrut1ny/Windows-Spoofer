function Get-RandomGuid {
    return [guid]::NewGuid().ToString().ToUpper()
}

function Get-RandomProductId {
    return (-join (1..20 | ForEach {[char]((65..90) + (48..57) | Get-Random)}) -replace '(.{5})', '$1-').TrimEnd('-')
}

# HwProfileGuid
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001' -Name 'HwProfileGuid' -Type String -Value "{$(Get-RandomGuid)}" -Force

# Cryptography
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Cryptography' -Name 'MachineGuid' -Type String -Value "$(Get-RandomGuid)" -Force

# SQMClient (Device ID)
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\SQMClient' -Name 'MachineId' -Type String -Value "$(Get-RandomGuid)" -Force

# ProductId (Product ID)
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name 'ProductId' -Type String -Value "$(Get-RandomProductId)" -Force
