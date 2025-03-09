# Task 09 : Network diagnostics

> Виконала [@Ir04ka7](https://https:github.com/Ir04ka7) (Iryna Chernobel)

#### Перевірка статусу мережевого інтерфейсу 
```
iryna@ubuntu:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:96:a0:ff brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.177/24 metric 100 brd 192.168.0.255 scope global dynamic enp0s3
       valid_lft 84202sec preferred_lft 84202sec
    inet6 fe80::a00:27ff:fe96:a0ff/64 scope link
       valid_lft forever preferred_lft forever
```  



## 1. Запуск моніторингу процесів
``` 
iryna@ubuntu:~$ sudo apt install atop htop btop -y
iryna@ubuntu:~$ atop
iryna@ubuntu:~$ htop
iryna@ubuntu:~$ btop
``` 
Screanshot: https://drive.google.com/drive/folders/1vLmHnEANKTHi0iXCSsrr-vWlpz44afuX?usp=drive_link


## 2. Виконання `ping` до localhost та зовнішнього сервера і трасування маршруту
``` 
iryna@ubuntu:~$ ping -c 4 google.com
iryna@ubuntu:~$ nslookup google.com
iryna@ubuntu:~$ traceroute google.com
traceroute to google.com (216.58.215.110), 30 hops max, 60 byte packets
 1  _gateway (192.168.0.1)  2.171 ms * *
 2  * * *
 3  * * *
 4  * * *
 5  * * *
 6  * 74.125.245.69 (74.125.245.69)  4984.469 ms 74.125.245.53 (74.125.245.53)  4984.194 ms
 7  74.125.245.86 (74.125.245.86)  4983.880 ms 74.125.245.64 (74.125.245.64)  12.482 ms 74.125.245.86 (74.125.245.86)  12.821 ms
 8  142.251.242.39 (142.251.242.39)  23.627 ms  23.072 ms 142.251.242.41 (142.251.242.41)  22.580 ms
 9  216.239.35.132 (216.239.35.132)  24.026 ms 192.178.99.97 (192.178.99.97)  23.335 ms 216.239.35.132 (216.239.35.132)  25.248 ms
10  108.170.234.247 (108.170.234.247)  24.875 ms 192.178.99.99 (192.178.99.99)  23.008 ms 108.170.234.247 (108.170.234.247)  23.731 ms
11  waw02s17-in-f14.1e100.net (216.58.215.110)  26.899 ms 108.170.234.245 (108.170.234.245)  26.280 ms waw02s17-in-f14.1e100.net (216.58.215.110)  23.482 ms
```
Screanshot: https://drive.google.com/drive/folders/1K00oABo-CXPiUjfGqUuwjP2-sD1Wzn_j?usp=drive_link

## 3. Перевірка конфігурації DNS
``` 
iryna@ubuntu:~$ cat /etc/resolv.conf
iryna@ubuntu:~$ nslookup google.com
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
Name:   google.com
Address: 216.58.215.110
Name:   google.com
Address: 2a00:1450:401b:804::200e
```  

- Інструмент dig підтверджує, що DNS працює належним чином
 
 ``` 
 iryna@ubuntu:~$ dig google.com

; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 2808
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;google.com.                    IN      A

;; ANSWER SECTION:
google.com.             88      IN      A       216.58.215.110

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sun Mar 09 11:21:43 UTC 2025
;; MSG SIZE  rcvd: 55
``` 
Screanshot: https://drive.google.com/drive/folders/18T0OS-6BrxrGheyWskTkgXt4D4G7bwlZ?usp=drive_link

## 4. Перегляд правил брандмауера (iptables або ufw) та відкритих портів
``` 
iryna@ubuntu:~$ sudo ufw status
Status: inactive
iryna@ubuntu:~$ netstat -tuln
iryna@ubuntu:~$ ss -tuln
Netid           State            Recv-Q           Send-Q                             Local Address:Port                       Peer Address:Port           Process
udp             UNCONN           0                0                                     127.0.0.54:53                              0.0.0.0:*
udp             UNCONN           0                0                                  127.0.0.53%lo:53                              0.0.0.0:*
udp             UNCONN           0                0                           192.168.0.177%enp0s3:68                              0.0.0.0:*
tcp             LISTEN           0                80                                     127.0.0.1:3306                            0.0.0.0:*
tcp             LISTEN           0                4096                                  127.0.0.54:53                              0.0.0.0:*
tcp             LISTEN           0                4096                               127.0.0.53%lo:53                              0.0.0.0:*
tcp             LISTEN           0                4096                                           *:22                                    *:*
``` 

Screanshot: https://drive.google.com/drive/folders/1oKxNYzGTYYcVg6YH81nYBXxBPOtmcf3K?usp=drive_link

## 5. Перевірка DHCP (отримання IP-адреси) та зміна IP-адреси через dhclient
``` 
iryna@ubuntu:~$ ip a | grep "inet "
    inet 127.0.0.1/8 scope host lo
    inet 192.168.0.174/24 metric 100 brd 192.168.0.255 scope global dynamic enp0s3
iryna@ubuntu:~$ journalctl -u systemd-networkd | grep DHCP
iryna@ubuntu:~$ sudo apt install isc-dhcp-client -y
Reading package lists... Done
iryna@ubuntu:~$ sudo dhclient -r
iryna@ubuntu:~$ sudo dhclient

iryna@ubuntu:~$ ip a | grep "inet "
inet 127.0.0.1/8 scope host lo
inet 192.168.0.174/24 metric 100 brd 192.168.0.255 scope global dynamic enp0s3
``` 
Screanshot: https://drive.google.com/drive/folders/1uygE0mjiyL8N-JobM34qq259q-G1Fs6G?usp=drive_link

## 6. Перевірка конфігураційних файлів та додавання статичної IP-адреси
``` 
iryna@ubuntu:~$ sudo cat /etc/netplan/*.yaml

# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        enp0s3:
            dhcp4: true
    version: 2

iryna@ubuntu:~$
network:
    ethernets:
        enp0s3:
            dhcp4: no
            addresses:
              - 192.168.0.200/24
            gateway4: 192.168.0.1
            nameservers:
                addresses: [8.8.8.8, 8.8.4.4]
    version: 2

iryna@ubuntu:~$ ip a | grep "inet "
inet 127.0.0.1/8 scope host lo
inet 192.168.0.200/24 brd 192.168.0.255 scope global enp0s3
inet 192.168.0.172/24 metric 100 brd 192.168.0.255 scope global secondary dynamic enp0s3

iryna@ubuntu:~$ ip route
default via 192.168.0.1 dev enp0s3 proto static
default via 192.168.0.1 dev enp0s3 proto dhcp src 192.168.0.172 metric 100
192.168.0.0/24 dev enp0s3 proto kernel scope link src 192.168.0.200
192.168.0.1 dev enp0s3 proto dhcp scope link src 192.168.0.172 metric 100

    iryna@ubuntu:~$ sudo netplan apply
``` 
Screanshot: 