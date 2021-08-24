


Steps to expand a LUKS encrypted volume

**crypt-volume to open the encrypted volume**
```bash
cryptsetup luksOpen /dev/sda2
```
**To extend the partition resizepart NUMBER END**
```bash
parted /dev/sda
```
**Stop using the VG so you can do the next step**
```bash
vgchange -a n fedora_chocbar
```
**Close the encrypted volume for the next steps**
```bash
cryptsetup luksClose crypt-volume
```
**Open it again**
```bash
cryptsetup luksOpen /dev/sda2 crypt-volume
```
**Will automatically resize the LUKS volume to the available space**
```bash
cryptsetup resize crypt-volume
```
**Activate the VG**
```bash
vgchange -a y fedora_chocbar
```
**Resize the PV**
```bash
pvresize /dev/mapper/crypt-volume
```
**Resize the LV for /home to 100% of the free space**
```bash
lvresize -l+100%FREE /dev/fedora_chocbar/home
```
**Throw some fsck magic at the resized fs**
```bash
e2fsck -f /dev/mapper/fedora_chocbar-home
```
**Resize the filesystem in /home automatically uses 100% free space**
```bash
resize2fs /dev/mapper/fedora_chocbar-home
```
