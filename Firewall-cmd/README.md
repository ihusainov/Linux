# Firewalld

**Install firewalld**
```
yum install firewalld
systemctl enable firewalld
systemctl start firewalld
```

**Get status**
```
firewall-cmd --state
firewall-cmd --reload
firewall-cmd --list-all
firewall-cmd --list-rich-rules
firewall-cmd --complete-reload  # Reread config and clush current connections
```

**Permanent port rules**
```
firewall-cmd --runtime-to-permanent

firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=80/tcp --add-port=443/tcp
firewall-cmd --permanent --add-port=6500-6700/udp

firewall-cmd --permanent --remove-port=80/tcp

firewall-cmd --reload
```

**Permanent services rules**
```
firewall-cmd --get-services
firewall-cmd --info-service=name-service

firewall-cmd --permanent --new-service=name-service
firewall-cmd --permanent --add-service=name-service

firewall-cmd --permanent --add-service=ntp
firewall-cmd --permanent --service=name-service --add-port=2200/tcp
firewall-cmd --permanent --service=name-service --set-short="Service With This Name"
firewall-cmd --permanent --service=name-service --set-description="Long Description For Service With This Name"
firewall-cmd --permanent --add-rich-rule 'rule family="ipv4" source address="192.168.0.0/24" service name="http" accept'

firewall-cmd --reload
```

**Permanent zones rules**
```
firewall-cmd --list-all-zones
firewall-cmd --get-active-zones
firewall-cmd --list-all --zone=public
firewall-cmd --permanent --new-zone=custom_zone

firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --remove-interface=ens34
firewall-cmd --permanent --zone=internal --add-interface=ens34
firewall-cmd --permanent --zone=public --set-target=DROP
firewall-cmd --permanent --zone=external --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="11.22.33.44/32" accept'

firewall-cmd --reload
```

**NAT**
```
firewall-cmd --permanent --zone=dmz --add-masquerade
firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -o ens33 -j MASQUERADE

firewall-cmd --direct --permanent --add-rule ipv4 filter FORWARD 0 -i ens32 -o ens33 -j ACCEPT
firewall-cmd --direct --permanent --add-rule ipv4 filter FORWARD 0 -i ens33 -o ens32 -m state --state RELATED,ESTABLISHED -j ACCEPT

firewall-cmd --reload
```

**Direct rules**
```
firewall-cmd --direct --get-all-rules
firewall-cmd --direct --permanent --add-rule ipv4 filter FORWARD 0 -i ens35 -o ens36 -j DROP
firewall-cmd --direct --permanent --add-rule ipv4 filter FORWARD 0 -i ens35 -o ens36 -j ACCEPT

firewall-cmd --reload
```

**Confluence rule**
```
firewall-cmd --permanent --add-port=8090/tcp --add-port=8091/tcp
firewall-cmd --permanent --remove-rich-rule='rule family="ipv4" source address="11.22.33.44" reject'

firewall-cmd --reload
```
