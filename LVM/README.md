- dmsetup - низкоуровневая работа с драйвером device-mapper
- lvm - инструмент для настройки LVM
- lvmdiskscan - сканирует доступные диски, показывает их размер и принадлежность к PV LVM

Physical Volume

- pvcreate - инициализация устройства как PV
- pvchange - изменение атрибутов PV
- pvremove - удаление неиспользуемого PV
- pvmove - перемещение PV между различными устройствами
- pvresize - изменение размера PV занятой VG
- pvscan - сканирование дисков на предмет PV
- pvs - вывод информации о PV
- pvdisplay - вывод атрибутов PV

Volume Group

- vgcfgbackup - резервное копирование области описания VG в файл
- vgcfgrestore - восстановление области описания VG из файла
- vgconvert - конвертация метаданных из LVM1 в LVM2
- vgcreate - создание VG
- vgremove - удаление VG
- vgchange - изменение параметров VG
- vgrename - переименовывание VG
- vgmerge - склеивание двух VG
- vgsplit - разделение одной VG на две
- vgscan - сканирование дисков на наличие VG
- vgdisplay - вывод атрибутов VG
- vgs - вывод информации о VG
- vgexport - отключение VG
- vgimport - подключение VG
- vgextend - добавление PV в VG
- vgreduce - удаление неиспользуемых PV из VG
- vgck - проверка целостности метаданных VG.
- vgmknodes - пересоздание файлов для VG в каталоге /dev

Logical Volume

- lvcreate - создание LV
- lvremove - удаление LV
- lvrename - переименовывание LV
- lvchange - изменение параметров LV
- lvresize - изменение размера LV
- lvextend - увеличение размера LV
- lvreduce - уменьшение размера LV
- lvscan - поиск LV в VG
- lvdisplay - вывод атрибутов LV
- lvs - вывод информации о LV
