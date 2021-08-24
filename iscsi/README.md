```
lsblk
pvcreate /dev/sdb
vgcreate tecmint_iscsi /dev/sdb
vgs
lvcreate -l 100%FREE -n tecmint_lun1 tecmint_iscsi
lvs
nano /etc/tgt/conf.d/TecMint_iscsi.conf
```
Add disk
```
<target iqn.2020-04.tecmint.com:lun1>
     # Provided device as an iSCSI target
     backing-store /dev/mapper/tecmint_iscsi-tecmint_lun1
     backing-store /dev/mapper/tecmint_iscsi_2-tecmint_lun2
     backing-store /dev/mapper/tecmint_iscsi_3-tecmint_lun3
#     initiator-address 192.168.171.129
#     incominguser tecmint-iscsi-user password
#     outgoinguser debian-iscsi-target secretpass
```
```
systemctl restart tgt
tgtadm --mode target --op show
```
```
apt-get install -y bind9 bind9utils bind9-doc dnsutils
cp /etc/bind/named.conf /etc/bind/named.conf-orig
vi /etc/bind/named.conf
/etc/bind/named.conf.local
vi /etc/bind/named.conf.local
cd /etc/bind
cat named.conf.local
cp db.local forward.ng.local.db
vi forward.ng.local.db
named-checkzone ng.local forward.ng.local.db
systemctl restart bind9
nslookup
nano /etc/resolv.conf
named-checkzone ng.local forward.ng.local.db
systemctl restart bind9
```
