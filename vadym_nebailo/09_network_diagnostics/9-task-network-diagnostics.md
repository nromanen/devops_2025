###### 1. Check the status of the network interface
Use **atop**, **htop**, and **btop** utilities to display running processes on your OS

[//]: screenshot
**atop** - https://drive.google.com/file/d/1HAfaC9HmfnL5P1q2aOZ-CKNiAHE7b37e/view?usp=sharing
**htop** - https://drive.google.com/file/d/1qhtaHuvrPiVls_mOiin2E_3J77TazkSB/view?usp=sharing
**btop** - https://drive.google.com/file/d/1XZG3fZL7dTYjpUTBplUq_JICWB5Evoto/view?usp=sharing
###### 2. Ping the localhost
set of 10 packets, each with a size of 1500 bytes

```bash
osboxes@osboxes:~$ ping -c 10 -s 1500 127.0.0.1
PING 127.0.0.1 (127.0.0.1) 1500(1528) bytes of data.
1508 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.134 ms
1508 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.060 ms
1508 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.106 ms
1508 bytes from 127.0.0.1: icmp_seq=4 ttl=64 time=0.071 ms
1508 bytes from 127.0.0.1: icmp_seq=5 ttl=64 time=0.070 ms
1508 bytes from 127.0.0.1: icmp_seq=6 ttl=64 time=0.076 ms
1508 bytes from 127.0.0.1: icmp_seq=7 ttl=64 time=0.029 ms
1508 bytes from 127.0.0.1: icmp_seq=8 ttl=64 time=0.117 ms
1508 bytes from 127.0.0.1: icmp_seq=9 ttl=64 time=0.028 ms
1508 bytes from 127.0.0.1: icmp_seq=10 ttl=64 time=0.069 ms

--- 127.0.0.1 ping statistics ---
10 packets transmitted, 10 received, 0% packet loss, time 9213ms
rtt min/avg/max/mdev = 0.028/0.076/0.134/0.032 ms
osboxes@osboxes:~$ 
```
###### 3. Ping an external host
by its name and obtain its IP address. Trace the route to the external host

```bash
osboxes@osboxes:~$ ping softserve.academy
PING softserve.academy (45.60.65.61) 56(84) bytes of data.
64 bytes from 45.60.65.61: icmp_seq=1 ttl=255 time=23.9 ms
64 bytes from 45.60.65.61: icmp_seq=2 ttl=255 time=87.0 ms
64 bytes from 45.60.65.61: icmp_seq=3 ttl=255 time=42.8 ms
64 bytes from 45.60.65.61: icmp_seq=4 ttl=255 time=25.7 ms
64 bytes from 45.60.65.61: icmp_seq=5 ttl=255 time=25.4 ms
64 bytes from 45.60.65.61: icmp_seq=6 ttl=255 time=27.2 ms
64 bytes from 45.60.65.61: icmp_seq=7 ttl=255 time=23.4 ms
64 bytes from 45.60.65.61: icmp_seq=8 ttl=255 time=23.3 ms
64 bytes from 45.60.65.61: icmp_seq=9 ttl=255 time=21.6 ms
64 bytes from 45.60.65.61: icmp_seq=10 ttl=255 time=23.3 ms
64 bytes from 45.60.65.61: icmp_seq=11 ttl=255 time=20.3 ms
64 bytes from 45.60.65.61: icmp_seq=12 ttl=255 time=28.1 ms
64 bytes from 45.60.65.61: icmp_seq=13 ttl=255 time=37.6 ms
64 bytes from 45.60.65.61: icmp_seq=14 ttl=255 time=36.2 ms
64 bytes from 45.60.65.61: icmp_seq=15 ttl=255 time=23.9 ms
64 bytes from 45.60.65.61: icmp_seq=16 ttl=255 time=22.3 ms
64 bytes from 45.60.65.61: icmp_seq=17 ttl=255 time=27.0 ms
64 bytes from 45.60.65.61: icmp_seq=18 ttl=255 time=36.1 ms
64 bytes from 45.60.65.61: icmp_seq=19 ttl=255 time=24.4 ms
64 bytes from 45.60.65.61: icmp_seq=20 ttl=255 time=23.1 ms
64 bytes from 45.60.65.61: icmp_seq=21 ttl=255 time=20.4 ms
64 bytes from 45.60.65.61: icmp_seq=22 ttl=255 time=21.8 ms
64 bytes from 45.60.65.61: icmp_seq=23 ttl=255 time=32.6 ms
^C
--- softserve.academy ping statistics ---
23 packets transmitted, 23 received, 0% packet loss, time 22152ms
rtt min/avg/max/mdev = 20.317/29.444/86.998/13.637 ms
osboxes@osboxes:~$ 
```

```bash
osboxes@osboxes:~$ traceroute softserve.academy
traceroute to softserve.academy (45.60.72.61), 30 hops max, 60 byte packets
 1  _gateway (10.0.2.2)  0.619 ms  0.498 ms  0.410 ms
 2  fritz.box (192.168.178.1)  2.559 ms  4.166 ms  4.093 ms
 3  * * *
 4  * * *
 5  de-bfe18a-rt01-lag-1.aorta.net (84.116.190.34)  31.662 ms  29.402 ms  31.283 ms
 6  ae32-100-pcr1.fnt.cw.net (195.2.18.217)  28.952 ms  23.773 ms ae8-100-tcr1.fnt.cw.net (195.2.26.93)  25.159 ms
 7  ae34-pcr1.fnt.cw.net (195.2.31.38)  25.088 ms  37.993 ms  37.058 ms
 8  ffm-bb2-link.ip.twelve99.net (62.115.124.118)  38.597 ms telia-gw.fnt.cw.net (195.2.22.238)  38.491 ms  37.566 ms
 9  ffm-bb2-link.ip.twelve99.net (62.115.124.118)  38.294 ms  38.198 ms ffm-b14-link.ip.twelve99.net (62.115.132.211)  29.040 ms
10  ffm-b14-link.ip.twelve99.net (62.115.132.209)  29.458 ms imperva-ic-377658.ip.twelve99-cust.net (213.248.92.147)  36.844 ms  21.122 ms
11  imperva-ic-377658.ip.twelve99-cust.net (213.248.92.147)  24.370 ms  27.472 ms *
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * * *
24  * * *
25  * * *
26  * * *
27  * * *
28  * * *
29  * * *
30  * * *
osboxes@osboxes:~$ 
```

###### 4. Check your DNS configuration
```bash
osboxes@osboxes:~$ cat /etc/resolv.conf
# This is /run/systemd/resolve/stub-resolv.conf managed by man:systemd-resolved(8).
# Do not edit.
#
# This file might be symlinked as /etc/resolv.conf. If you're looking at
# /etc/resolv.conf and seeing this text, you have followed the symlink.
#
# This is a dynamic resolv.conf file for connecting local clients to the
# internal DNS stub resolver of systemd-resolved. This file lists all
# configured search domains.
#
# Run "resolvectl status" to see details about the uplink DNS servers
# currently in use.
#
# Third party programs should typically not access this file directly, but only
# through the symlink at /etc/resolv.conf. To manage man:resolv.conf(5) in a
# different way, replace this symlink by a static file or a different symlink.
#
# See man:systemd-resolved.service(8) for details about the supported modes of
# operation for /etc/resolv.conf.

nameserver 127.0.0.53
options edns0 trust-ad
search .
osboxes@osboxes:~$ 
```

```bash
osboxes@osboxes:~$ nslookup softserve.academy
Server:		127.0.0.53
Address:	127.0.0.53#53

Non-authoritative answer:
Name:	softserve.academy
Address: 45.60.72.61
Name:	softserve.academy
Address: 45.60.65.61
```

###### 5. Review the firewall rules 
List the open ports on your system using `netstat` and `ss`.

```bash
osboxes@osboxes:~$ sudo iptables -L -v -n
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination  
```

```bash
osboxes@osboxes:~$ sudo netstat -tuln
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.54:53           0.0.0.0:*               LISTEN     
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN     
tcp6       0      0 :::22                   :::*                    LISTEN     
udp        0      0 127.0.0.54:53           0.0.0.0:*                          
udp        0      0 127.0.0.53:53           0.0.0.0:*                          
udp        0      0 10.0.2.15:68            0.0.0.0:*                          
osboxes@osboxes:~$ 
```

```bash
osboxes@osboxes:~$ sudo ss -tuln
Netid        State          Recv-Q           Send-Q                 Local Address:Port               Peer Address:Port                      
udp          UNCONN         0                0                      127.0.0.54:53                    0.0.0.0:*                         
udp          UNCONN         0                0                      127.0.0.53%lo:53                 0.0.0.0:*                         
udp          UNCONN         0                0                      10.0.2.15%enp0s3:68              0.0.0.0:*                         
tcp          LISTEN         0                4096                   0.0.0.0:22                       0.0.0.0:*                         
tcp          LISTEN         0                4096                   127.0.0.54:53                    0.0.0.0:*                         
tcp          LISTEN         0                4096                   127.0.0.53%lo:53                 0.0.0.0:*                         
tcp          LISTEN         0                4096                   [::]:22                          [::]:*                         
osboxes@osboxes:~$ 

```

###### 6. - If you are using DHCP, **verify that your system is obtaining an IP address correctly.** Change the IP address using the `dhclient` command. Show the results.

```bash
osboxes@osboxes:~$ ip -c a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:ee:e7:a3 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 metric 100 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 76805sec preferred_lft 76805sec
    inet6 fd00::a00:27ff:feee:e7a3/64 scope global dynamic mngtmpaddr noprefixroute 
       valid_lft 86177sec preferred_lft 14177sec
    inet6 fe80::a00:27ff:feee:e7a3/64 scope link proto kernel_ll 
       valid_lft forever preferred_lft forever
```

```bash
osboxes@osboxes:~$ sudo dhclient -v
Internet Systems Consortium DHCP Client 4.4.3-P1
Copyright 2004-2022 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/enp0s3/08:00:27:ee:e7:a3
Sending on   LPF/enp0s3/08:00:27:ee:e7:a3
Sending on   Socket/fallback
xid: warning: no netdev with useable HWADDR found for seed's uniqueness enforcement
xid: rand init seed (0x67af40dc) built using gethostid
DHCPDISCOVER on enp0s3 to 255.255.255.255 port 67 interval 3 (xid=0x553d126b)
DHCPOFFER of 10.0.2.15 from 10.0.2.2
DHCPREQUEST for 10.0.2.15 on enp0s3 to 255.255.255.255 port 67 (xid=0x6b123d55)
DHCPACK of 10.0.2.15 from 10.0.2.2 (xid=0x553d126b)
Error: ipv4: Address already assigned.
Setting LLMNR support level "yes" for "2", but the global support level is "no".
bound to 10.0.2.15 -- renewal in 32527 seconds.

```

```bash
osboxes@osboxes:~$ sudo dhclient enp0s3
[sudo] password for osboxes: 
Error: ipv4: Address already assigned.

```

###### 7. Check the network configuration files.
Add a static IP address to an existing interface. Apply the changes and verify correct operation.

```bash
osboxes@osboxes:~$ sudo cat /etc/netplan/*.yaml  
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: true
```

```bash
	sudo nano /etc/netplan/50-cloud-init.yaml 

// Changed to 50-cloud-init.yaml file to:
network: 
  version: 2 
  renderer: networkd 
  ethernets: 
    enp0s3: 
      dhcp4: true 
      addresses: 
        - 10.0.2.100/24 
//---------------------------------------------------
```

###### 8. Restart network services
apply any changes made during troubleshooting. Check the firewall status on your system.
```bash
osboxes@osboxes:~$ sudo netplan try
osboxes@osboxes:~$ sudo netplan apply
```

**Network settings after changes:**
```bash
osboxes@osboxes:~$ ip -c a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:f4:98:58 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 metric 100 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 86151sec preferred_lft 86151sec
    inet6 fd00::a00:27ff:fef4:9858/64 scope global dynamic mngtmpaddr noprefixroute 
       valid_lft 86154sec preferred_lft 14154sec
    inet6 fe80::a00:27ff:fef4:9858/64 scope link proto kernel_ll 
       valid_lft forever preferred_lft forever

osboxes@osboxes:~$ ip -c r
default via 10.0.2.2 dev enp0s3 proto dhcp src 10.0.2.15 metric 100 
10.0.2.0/24 dev enp0s3 proto kernel scope link src 10.0.2.100 
10.0.2.2 dev enp0s3 proto dhcp scope link src 10.0.2.15 metric 100 
10.0.2.3 dev enp0s3 proto dhcp scope link src 10.0.2.15 metric 100 
```

###### 9. Use the `tcpdump` utility
display traffic through the Ethernet port, including IP addresses and port numbers.
```bash
osboxes@osboxes:~$ sudo tcpdump -i enp0s3 -nn
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on enp0s3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
15:24:22.062635 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 3529745482:3529745590, ack 24986840, win 62780, length 108
15:24:22.062980 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 108, win 65535, length 0
15:24:22.063008 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 108:144, ack 1, win 62780, length 36
15:24:22.063384 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 144, win 65535, length 0
15:24:22.063467 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 144:204, ack 1, win 62780, length 60
15:24:22.063738 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 204, win 65535, length 0
15:24:22.063812 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 204:304, ack 1, win 62780, length 100
15:24:22.064054 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 304, win 65535, length 0
15:24:22.070440 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [P.], seq 1:37, ack 304, win 65535, length 36
15:24:22.070803 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 304:340, ack 37, win 62780, length 36
15:24:22.073377 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 340, win 65535, length 0
15:24:22.092073 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [P.], seq 37:73, ack 340, win 65535, length 36
15:24:22.092224 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 340:376, ack 73, win 62780, length 36
15:24:22.094750 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 376, win 65535, length 0
15:24:22.112538 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [P.], seq 73:109, ack 376, win 65535, length 36
15:24:22.112668 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 376:412, ack 109, win 62780, length 36
15:24:22.115169 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 412, win 65535, length 0
15:24:22.133133 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [P.], seq 109:145, ack 412, win 65535, length 36
15:24:22.133268 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 412:448, ack 145, win 62780, length 36
15:24:22.135894 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 448, win 65535, length 0
15:24:22.154788 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [P.], seq 145:181, ack 448, win 65535, length 36
15:24:22.155114 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 448:484, ack 181, win 62780, length 36
15:24:22.157967 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 484, win 65535, length 0
15:24:22.159869 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 484:648, ack 181, win 62780, length 164
15:24:22.160607 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 648, win 65535, length 0
15:24:22.161572 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 648:972, ack 181, win 62780, length 324
15:24:22.162131 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 972, win 65535, length 0
15:24:22.162950 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 972:1800, ack 181, win 62780, length 828
15:24:22.163507 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 1800, win 65535, length 0
15:24:22.164825 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 1800:2636, ack 181, win 62780, length 836
15:24:22.165560 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 2636, win 65535, length 0
15:24:22.166019 IP 10.0.2.15.22 > 10.0.2.2.57940: Flags [P.], seq 2636:2976, ack 181, win 62780, length 340
15:24:22.166539 IP 10.0.2.2.57940 > 10.0.2.15.22: Flags [.], ack 2976, win 65535, length 0

```

###### 10. Check system logs for network-related errors
common logs include `syslog`, `messages`, `access`, and `network.log`

```bash
osboxes@osboxes:~$ sudo cat /var/log/syslog | grep -i "network"
2024-10-27T03:57:41.505222+00:00 osboxes systemd[1]: Starting systemd-resolved.service - Network Name Resolution...
2024-10-27T03:57:41.505224+00:00 osboxes systemd[1]: Starting systemd-timesyncd.service - Network Time Synchronization...
2024-10-27T03:57:41.505236+00:00 osboxes systemd[1]: Started systemd-timesyncd.service - Network Time Synchronization.
2024-10-27T03:57:41.505250+00:00 osboxes systemd[1]: Started systemd-resolved.service - Network Name Resolution.
2024-10-27T03:57:41.505251+00:00 osboxes systemd[1]: Reached target nss-lookup.target - Host and Network Name Lookups.
2024-10-27T03:57:41.505270+00:00 osboxes systemd[1]: Starting cloud-init-local.service - Cloud-init: Local Stage (pre-network)...
2024-10-27T03:57:41.505300+00:00 osboxes systemd[1]: Configuration file /run/systemd/system/systemd-networkd-wait-online.service.d/10-netplan.conf is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
2024-10-27T03:57:41.505311+00:00 osboxes systemd[1]: Finished cloud-init-local.service - Cloud-init: Local Stage (pre-network).
2024-10-27T03:57:41.505313+00:00 osboxes systemd[1]: Reached target network-pre.target - Preparation for Network.
2024-10-27T03:57:41.505315+00:00 osboxes systemd[1]: Starting systemd-networkd.service - Network Configuration...
2024-10-27T03:57:41.505318+00:00 osboxes systemd-networkd[754]: lo: Link UP
2024-10-27T03:57:41.505321+00:00 osboxes systemd-networkd[754]: lo: Gained carrier
2024-10-27T03:57:41.505322+00:00 osboxes systemd-networkd[754]: Enumeration completed
2024-10-27T03:57:41.505324+00:00 osboxes systemd[1]: Started systemd-networkd.service - Network Configuration.
2024-10-27T03:57:41.505326+00:00 osboxes systemd[1]: Reached target network.target - Network.
2024-10-27T03:57:41.505328+00:00 osboxes systemd[1]: Starting systemd-networkd-persistent-storage.service - Enable Persistent Storage in systemd-networkd...
2024-10-27T03:57:41.505335+00:00 osboxes systemd[1]: Starting systemd-networkd-wait-online.service - Wait for Network to be Configured...
```

```bash
osboxes@osboxes:~$ sudo cat /var/log/messages | grep -i "network"
cat: /var/log/messages: No such file or directory
```

```bash
osboxes@osboxes:~$ sudo dmesg | grep -i "eth\|network"
[    1.006016] drop_monitor: Initializing network drop monitor service
[    1.867829] e1000: Intel(R) PRO/1000 Network Driver
[    2.587295] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 08:00:27:f4:98:58
[    2.588075] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    2.596775] e1000 0000:00:03.0 enp0s3: renamed from eth0
[    5.487097] systemd[1]: Configuration file /run/systemd/system/systemd-networkd-wait-online.service.d/10-netplan.conf is marked world-inaccessible. This has no effect as configuration data is accessible via APIs without restrictions. Proceeding anyway.
[    5.912767] systemd[1]: Listening on systemd-networkd.socket - Network Service Netlink Socket.
osboxes@osboxes:~$ 
```

```bash
osboxes@osboxes:~$ sudo cat /var/log/network.log
cat: /var/log/network.log: No such file or directory
```