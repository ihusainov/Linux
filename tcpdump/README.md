
# tcpdump

sudo tcpdump -ttt -vv -i ens192 dst 192.168.0.10 and dst port 5432  --dont-verify-checksums | awk '{print $19<360 && $19>=240}'

sudo tcpdump -ttt -vvvv -i ens192 dst 192.168.0.10 and dst port 5432  --dont-verify-checksums | awk '$19 > 240 && $19 < 360 {print $0}'
