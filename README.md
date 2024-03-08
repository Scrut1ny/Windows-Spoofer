<h1 align="center">FOSS Windows 10 & 11 Spoofer</h1>

This is a Free and Open Source Windows 10/11 spoofer. It's carefully programmed and thoroughly documented. I've dedicated a significant amount of time to refine it, ensuring smooth functionality across all modules. My motivation came from noticing issues with existing spoofers, such as poor programming, excessive bloat, and unnecessary system actions. Frustrated with the lack of reliable options, I conducted extensive research and programming to develop a truly effective, free, and open-source solution. Inspired by [vektort13](https://github.com/vektort13) and his projects [antiOS_batch](https://github.com/vektort13/antiOS_batch) and [AntiOS](https://github.com/vektort13/AntiOS), I aimed to enhance and expand upon his work, making it 10 times better with additional functionality. Join the new project, Antidetect, and remember to stay elusive!

> [!IMPORTANT]
> By using these scripts, you acknowledge and agree that you are doing so at your own risk. The provider of these scripts makes no warranties, either express or implied, regarding their safety, reliability, or suitability for any purpose. You assume full responsibility for any consequences, damages, or loss that may arise from their use. The provider shall not be liable for any direct, indirect, incidental, consequential, or punitive damages resulting from the use of these scripts.

## Support 🔧
  * Supported ✅
    * Operating System(s)
      * <img src="https://external-content.duckduckgo.com/ip3/www.microsoft.com.ico" width="16" height="16"> - Windows 11
      * <img src="https://external-content.duckduckgo.com/ip3/www.microsoft.com.ico" width="16" height="16"> - Windows 10
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

## Spoofing Functions ⚙️
| Spoof Function | Support |
|-|-|
| Local Windows User Account | ✅ |
| Local Computer Name (Device Name) | ✅ |
| Network Computer Name (NetBIOS Name) | ✅ |
| Custom DNS | ✅ |
| Registry | ✅ |
| MAC Address | ✅ |
| VolumeID | ✅ |
| SMBIOS DMI | ✅ |
| Disk (HDD/SSD/NVMe) Serials | ❌ |
| RAM Serials | ❌ |
| GPU Serials | ❌ |
| NVIDIA UUID | ✅ |
| Monitor Serials | ❌ |
| PnP Device Serials | ❌ |
| ARP | ❌ |

## Flushing/Cleaning/Deletion Functions 🗑️
| Cleaning Function | Support |
|-|-|
| DNS Cache | ✅ |
| ARP Cache | ✅ |
| Prefetch Files | ✅ |
| `%TMP%\*` Files | ✅ |
| `*.log` Files | ✅ |
| USN Journal ID(s) | ✅ |
| Ubisoft, Valorant, cache | ✅ |
| Old Windows Backup | ✅ |

## Spoofing Software
* [VolumeID](https://learn.microsoft.com/en-us/sysinternals/downloads/volumeid)
  * [⬇️ Download Link](https://download.sysinternals.com/files/VolumeId.zip)
* [DMI Edit](https://download.schenker-tech.de/package/dmi-edit-efi-ami/)
  * [⬇️ DMI Edit](https://download.schenker-tech.de/package/dmi-edit-efi-ami/?wpdmdl=3997&refresh=6596c76501be81704380261&ind=1647077068432&filename=dmi-edit-win64-ami.zip)
  * [⬇️ DMI EFI Edit](https://download.schenker-tech.de/package/dmi-edit-efi-ami/?wpdmdl=3997&refresh=6596c76501be81704380261&ind=1637063374897&filename=dmi-edit-efi-ami.zip)
* [mutante](https://github.com/SamuelTulach/mutante)
* [hwid](https://github.com/btbd/hwid)
* [rainbow](https://github.com/SamuelTulach/rainbow)
* [Nvidia GPU UUID Randomizer](https://gist.github.com/Xyrem/4b6ea950e26565581ccd851be09ace00)

## UEFI/BIOS Keys by Manufacturer
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

## UEFI/BIOS Key Differences
* If you use UEFI firmware, use GPT for the partitioning scheme.
* If you use BIOS firmware, use MBR for the partitioning scheme.

* UEFI (Unified Extensible Firmware Interface):
  * Modern firmware standard.
  * Supports both MBR and GPT (GUID Partition Table).
  * Operates in 32-bit or 64-bit processor modes.
  * Can have a graphical user interface.
  * Generally faster boot times.
* BIOS (Basic Input/Output System):
  * Legacy technology.
  * Typically uses MBR (Master Boot Record) for booting.
  * Limited to 16-bit processor mode.
  * Has a text-based user interface.
  * Generally slower boot times.

## Guides
* [Evasion Techniques](https://evasions.checkpoint.com/)
* [UC - All methods of retrieving unique identifiers(HWIDs) on your PC](https://www.unknowncheats.me/forum/anti-cheat-bypass/333662-methods-retrieving-unique-identifiers-hwids-pc.html)
* [HWID Ban: Change UUID and Serial of AMI BIOS Motherboard](https://www.se7ensins.com/forums/threads/hwid-ban-change-uuid-and-serial-of-ami-bios-motherboard.1802379/)
## Video Guides
* [hdd serial number bypass (cheat engine)](https://www.youtube.com/watch?v=6BIpRNnUm5w)
  * Make sure to unload `dbk64.sys` driver with `Kernelmoduleunloader.exe` because anti-cheats detect the `dbk64.sys` driver.
```
Windows7
FFFF800000000000
FFFFFF0000000000

Windows8
FFFF800000000000
FFFFFF0000000000

Windows10(Fast Scan)
FFFF800000000000
FFFFA00000000000

Windows10(Slow Scan)
(Fast Scan Not Found Result)
FFFF800000000000
FFFFC00000000000
```
