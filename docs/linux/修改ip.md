```bash
vi /etc/sysconfig/network-scripts/ifcfg-ens33
```

```tex
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=static
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
NAME=ens33
NAME=ens33
UUID=12037371-f4f9-42fc-8fce-90e429330d0c
DEVICE=ens33
ONBOOT=yes
IPADDR=192.168.48.12
NETMASK=255.255.255.0
GATEWAY=192.168.48.2
DNS1=114.114.114.114
DNS2=8.8.8.8

```

重启网络服务

```bash
systemctl restart network
```

