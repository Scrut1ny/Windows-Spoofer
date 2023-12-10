# FOSS Windows 10/11 Spoofer
This is a Windows spoofer based on Free and Open Source Software (FOSS), meticulously programmed and comprehensively documented. I have invested considerable time and effort into refining this spoofer, ensuring seamless functionality across all modules. My motivation stemmed from the observation that numerous existing spoofers suffer from poor programming, excessive bloat, and unnecessary system actions. Frustrated with the lack of reliable options, I undertook extensive research and programming to create a genuinely effective, free, and open-source solution.

## Support
  * Supported ✔️
    * Operating System(s)
      * <img src="https://external-content.duckduckgo.com/ip3/www.microsoft.com.ico" width="16" height="16"> - Windows 11 23H2
      * <img src="https://external-content.duckduckgo.com/ip3/www.microsoft.com.ico" width="16" height="16"> - Windows 10 22H2
    * Motherboard Manufacture(s)
      * <img src="https://external-content.duckduckgo.com/ip3/www.asus.com.ico" width="16" height="16"> - ASUS
      * <img src="https://external-content.duckduckgo.com/ip3/us.msi.com.ico" width="16" height="16"> - MSI (Micro-Star International)
      * <img src="https://external-content.duckduckgo.com/ip3/www.asrock.com.ico" width="16" height="16"> - ASRock
      * <img src="https://external-content.duckduckgo.com/ip3/www.gigabyte.com.ico" width="16" height="16"> - Gigabyte / Aorus
      * <img src="https://external-content.duckduckgo.com/ip3/www.biostar-usa.com.ico" width="16" height="16"> - Biostar
      * <img src="https://external-content.duckduckgo.com/ip3/www.supermicro.com.ico" width="16" height="16"> - Supermicro
      * <img src="https://duckduckgo.com/i/c01ed58d.png" width="16" height="16"> - ECS (Elitegroup Computer Systems)
  * Unsupported ❌
    * Operating System(s)
      * <img src="https://external-content.duckduckgo.com/ip3/www.linux.org.ico" width="16" height="16"> - Linux
    * Motherboard Manufacture(s)
      * <img src="https://external-content.duckduckgo.com/ip3/www.acer.com.ico" width="16" height="16"> - Acer
      * <img src="https://external-content.duckduckgo.com/ip3/www.dell.com.ico" width="16" height="16"> - Dell
      * <img src="https://external-content.duckduckgo.com/ip3/www.hp.com.ico" width="16" height="16"> - HP
      * <img src="https://external-content.duckduckgo.com/ip3/www.lenovo.com.ico" width="16" height="16"> - Lenovo

## Spoofing Options 📑
 * Permanent
   * SerialNumber
     * `Randomly Generated`
     * `To be filled by O.E.M.`
     * `Unknown`
     * `Null`
 * Temporary

## Spoofing Functions ⚙️
 * Device name
 * GUIDs
   * HwProfileGuid
   * Cryptography (MachineGuid)
   * SQMClient (Device ID)
   * ProductId (Product ID)
   * System Information (ComputerHardwareId(s))
   * MachineGuid.txt
 * SMBIOS
 * VolumeID(s)
 * Disk(s) / Drive(s)
   * DiskPeripheral - Identifier(s)
   * SCSI Ports - SerialNumber(s)
 * DMI (AMI BIOS)
   * System Information - Serial Number
   * System Information - UUID
   * Base Board/Module Information - Baseboard Serial Number
   * System Enclosure or Chassis - Serial Number
   * Processor Information - Serial Number
 * NIC(s)
 * Custom DNS

## Flushing/Cleaning/Deletion Functions 🗑️
 * DNS Cashe
 * ARP Cache
 * Prefetch
 * Temp Files
 * `*.log` Files
 * USN Journal ID(s)
 * Ubisoft, Valorant, cache
 * Old Windows Backup

## Windows Activation
<img src="https://external-content.duckduckgo.com/ip3/massgrave.dev.ico" width="16" height="16"> - [MAS](https://github.com/massgravel/Microsoft-Activation-Scripts) Activation
```
irm https://massgrave.dev/get | iex
```

## BIOS Keys by Manufacturer
```
shutdown /r /fw /f /t 0
```
|Manufacturer|Key/Sequence|
|-|-|
| Acer | F2 |
| ASRock | F2 or DEL |
| Asus | DEL or F2 |
| Dell | F2 or F12 |
| Gigabyte | DEL or F2 |
| HP | ESC or F10 |
| Lenovo | F1 or F2 |
| MSI | DEL or F2 |
| Samsung | F2 |
| Sony | F1, F2, or F3 |
| Toshiba | F2 or ESC |
| Intel NUC | F2 |

## UEFI and BIOS
 * BIOS (Basic Input/Output System):
  * Legacy technology.
  * Typically uses MBR (Master Boot Record) for booting.
  * Limited to 16-bit processor mode.
  * Has a text-based user interface.
  * Generally slower boot times.

 * UEFI (Unified Extensible Firmware Interface):
  * Modern firmware standard.
  * Supports both MBR and GPT (GUID Partition Table).
  * Operates in 32-bit or 64-bit processor modes.
  * Can have a graphical user interface.
  * Generally faster boot times.

## Guides
 * [Evasion Techniques](https://evasions.checkpoint.com/)
 * [UC - All methods of retrieving unique identifiers(HWIDs) on your PC](https://www.unknowncheats.me/forum/anti-cheat-bypass/333662-methods-retrieving-unique-identifiers-hwids-pc.html)
