


Steps to expand a LUKS encrypted volume

**crypt-volume to open the encrypted volume**
cryptsetup luksOpen /dev/sda2

**to extend the partition. resizepart NUMBER END.**
parted /dev/sda

**Stop using the VG so you can do the next step**
vgchange -a n fedora_chocbar

**Close the encrypted volume for the next steps**
cryptsetup luksClose crypt-volume

**Open it again**
cryptsetup luksOpen /dev/sda2 crypt-volume

**Will automatically resize the LUKS volume to the available space**
cryptsetup resize crypt-volume

**Activate the VG**
vgchange -a y fedora_chocbar

**Resize the PV**
pvresize /dev/mapper/crypt-volume

**Resize the LV for /home to 100% of the free space**
lvresize -l+100%FREE /dev/fedora_chocbar/home

**Throw some fsck magic at the resized fs**
e2fsck -f /dev/mapper/fedora_chocbar-home

**Resize the filesystem in /home automatically uses 100% free space**
resize2fs /dev/mapper/fedora_chocbar-home
