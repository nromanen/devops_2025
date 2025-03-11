# Network Diagnostics and Static IP Configuration

1. **Checking Network Interface Status**

```bash
polina@ubuntu:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enp0s1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 12:a2:c5:a3:d4:1c brd ff:ff:ff:ff:ff:ff
    inet 192.168.64.5/24 metric 100 brd 192.168.64.255 scope global dynamic enp0s1
       valid_lft 86351sec preferred_lft 86351sec
    inet6 fd70:dcc5:ac52:ee46:10a2:c5ff:fea3:d41c/64 scope global dynamic mngtmpaddr noprefixroute 
       valid_lft 2591954sec preferred_lft 604754sec
    inet6 fe80::10a2:c5ff:fea3:d41c/64 scope link 
       valid_lft forever preferred_lft forever
```

**Checking Running Processes**

```bash
polina@ubuntu:~$ atop
polina@ubuntu:~$ htop
polina@ubuntu:~$ btop
```

Result: System monitoring tools successfully launched.
Screenshots: https://drive.google.com/drive/folders/1q5n6m_-kQZlwRf1-MPxeIRXy1IMna0F1?usp=sharing

---
2. **Pinging the localhost**

```bash
polina@ubuntu:~$ ping -c 10 -s 1500 127.0.0.1
PING 127.0.0.1 (127.0.0.1) 1500(1528) bytes of data.
1508 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.054 ms
1508 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.075 ms
1508 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.108 ms
1508 bytes from 127.0.0.1: icmp_seq=4 ttl=64 time=0.118 ms
1508 bytes from 127.0.0.1: icmp_seq=5 ttl=64 time=0.143 ms
1508 bytes from 127.0.0.1: icmp_seq=6 ttl=64 time=0.125 ms
1508 bytes from 127.0.0.1: icmp_seq=7 ttl=64 time=0.110 ms
1508 bytes from 127.0.0.1: icmp_seq=8 ttl=64 time=0.137 ms
1508 bytes from 127.0.0.1: icmp_seq=9 ttl=64 time=0.131 ms
1508 bytes from 127.0.0.1: icmp_seq=10 ttl=64 time=0.132 ms

--- 127.0.0.1 ping statistics ---
10 packets transmitted, 10 received, 0% packet loss, time 9211ms
rtt min/avg/max/mdev = 0.054/0.113/0.143/0.027 ms
```

Result: **0% packet loss**, confirming that the loopback interface is functioning correctly.

---
3. **Pinging the external host**


```bash
polina@ubuntu:~$ ping -c 4 softserveinc.com
PING softserveinc.com (45.60.69.61) 56(84) bytes of data.
64 bytes from 45.60.69.61: icmp_seq=1 ttl=55 time=104 ms
64 bytes from 45.60.69.61: icmp_seq=2 ttl=55 time=104 ms
64 bytes from 45.60.69.61: icmp_seq=3 ttl=55 time=106 ms
64 bytes from 45.60.69.61: icmp_seq=4 ttl=55 time=105 ms

--- softserveinc.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3010ms
rtt min/avg/max/mdev = 104.049/104.804/105.903/0.696 ms
```

Result:
- **External IP:** `45.60.69.61`
- **Latency:** ~104ms (average)
- **0% packet loss**

---

**Tracing Route to External Host**

```bash
polina@ubuntu:~$ traceroute softserveinc.com
traceroute to softserveinc.com (45.60.63.61), 64 hops max
  1   192.168.64.1  0.401ms  0.329ms  0.519ms 
  2   10.10.17.1  4.749ms  2.823ms  2.252ms 
  3   10.250.0.1  3.605ms  2.913ms  2.902ms 
  4   194.44.212.174  22.963ms  4.348ms  3.716ms 
  5   *  184.104.231.97  13.042ms  * 
  6   184.104.188.54  69.781ms  34.746ms  46.701ms 
  7   184.104.188.100  99.277ms  *  106.735ms 
  8   *  *  * 
  9   131.125.129.79  104.697ms  103.316ms  102.963ms 
 10   *  *  * 
 11   *  *  * 
 12   *  *  * 
 13   * ^C
polina@ubuntu:~$ sudo traceroute -I softserveinc.com
traceroute to softserveinc.com (45.60.69.61), 64 hops max
  1   192.168.64.1  0.819ms  0.525ms  0.419ms 
  2   10.10.17.1  2.930ms  2.558ms  2.582ms 
  3   10.250.0.1  3.691ms  4.117ms  5.393ms 
  4   194.44.212.174  5.815ms  3.958ms  3.685ms 
  5   *  *  * 
  6   *  184.104.188.54  37.902ms  * 
  7   72.52.92.166  104.421ms  *  * 
  8   184.105.222.190  111.358ms  *  * 
  9   206.126.237.203  106.245ms  108.631ms  118.051ms 
 10   45.60.69.61  105.395ms  104.179ms  104.060ms 
```

Result: 

---

4.  **Checking DNS Configuration**

```bash
polina@ubuntu:~$ cat /etc/resolv.conf
```

Result:
- **DNS Server:** `127.0.0.53` (systemd-resolved stub resolver)

---
5. **Reviewing Firewall Rules**
```bash
polina@ubuntu:~$ sudo iptables -L -v -n
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
polina@ubuntu:~$ sudo ufw status verbose
Status: inactive
```

Result:
- **iptables:** No active firewall rules (default ACCEPT policy).
- **UFW Status:** Inactive.

---

**Listing Open Ports**

```bash
polina@ubuntu:~$ netstat -tulnp
ss -tulnp
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 127.0.0.54:53           0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      -                   
tcp6       0      0 :::22                   :::*                    LISTEN      -                   
udp        0      0 127.0.0.54:53           0.0.0.0:*                           -                   
udp        0      0 127.0.0.53:53           0.0.0.0:*                           -                   
Netid            State             Recv-Q            Send-Q                       Local Address:Port                       Peer Address:Port            Process            
udp              UNCONN            0                 0                               127.0.0.54:53                              0.0.0.0:*                                  
udp              UNCONN            0                 0                            127.0.0.53%lo:53                              0.0.0.0:*                                  
tcp              LISTEN            0                 4096                            127.0.0.54:53                              0.0.0.0:*                                  
tcp              LISTEN            0                 4096                         127.0.0.53%lo:53                              0.0.0.0:*                                  
tcp              LISTEN            0                 4096                                     *:22                                    *:*                                  
polina@ubuntu:~$ 
```

Result:
- **Active services:** DNS resolver on port `53`, SSH on port `22`.

---

6. **Checking DHCP and Changing IP Address**

```bash
polina@ubuntu:~$ sudo dhclient -v -r enp0s1
sudo dhclient -v enp0s1
Killed old client process
Internet Systems Consortium DHCP Client 4.4.3-P1
Copyright 2004-2022 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/enp0s1/12:a2:c5:a3:d4:1c
Sending on   LPF/enp0s1/12:a2:c5:a3:d4:1c
Sending on   Socket/fallback
xid: warning: no netdev with useable HWADDR found for seed's uniqueness enforcement
xid: rand init seed (0x67b2777f) built using gethostid
DHCPRELEASE of 192.168.64.5 on enp0s1 to 192.168.64.1 port 67 (xid=0x27721cac)
Internet Systems Consortium DHCP Client 4.4.3-P1
Copyright 2004-2022 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/enp0s1/12:a2:c5:a3:d4:1c
Sending on   LPF/enp0s1/12:a2:c5:a3:d4:1c
Sending on   Socket/fallback
xid: warning: no netdev with useable HWADDR found for seed's uniqueness enforcement
xid: rand init seed (0x67b2777f) built using gethostid
DHCPDISCOVER on enp0s1 to 255.255.255.255 port 67 interval 3 (xid=0xac1c7227)
DHCPOFFER of 192.168.64.5 from 192.168.64.1
DHCPREQUEST for 192.168.64.5 on enp0s1 to 255.255.255.255 port 67 (xid=0x27721cac)
DHCPACK of 192.168.64.5 from 192.168.64.1 (xid=0xac1c7227)
Setting LLMNR support level "yes" for "2", but the global support level is "no".
bound to 192.168.64.5 -- renewal in 36164 seconds.

```

Result:
- Successfully released and reacquired IP (`192.168.64.5`).
- **DHCP server:** `192.168.64.1`


---

7. **Modifying Network Configuration for a Static IP**

```bash
polina@ubuntu:~$ sudo nano /etc/netplan/50-cloud-init.yaml
polina@ubuntu:~$ sudo netplan apply

** (generate:25855): WARNING **: 11:14:38.539: Permissions for /etc/netplan/00-default-nm-renderer.yaml are too open. Netplan configuration should NOT be accessible by others.

** (generate:25855): WARNING **: 11:14:38.539: `gateway4` has been deprecated, use default routes instead.
See the 'Default routes' section of the documentation for more details.
client_loop: send disconnect: Broken pipe
```

**Original Configuration in `50-cloud-init.yaml`**
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s1:
      dhcp4: true
```

**Updated Configuration in 50-cloud-init.yaml:**
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s1:
      addresses:
        - 192.168.64.100/24
      gateway4: 192.168.64.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
```

After reconnecting via SSH:

```bash
polina@MacBook-Air-Polina devops_2025 % ssh polina@192.168.64.100

The authenticity of host '192.168.64.100 (192.168.64.100)' can't be established.
ED25519 key fingerprint is SHA256:lNfvCV+dHJjR5emQMP02SMVU5CbX5dUBc0LdK62K4Uk.
This host key is known by the following other names/addresses:
    ~/.ssh/known_hosts:4: 192.168.64.5
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.64.100' (ED25519) to the list of known hosts.
polina@192.168.64.100's password: 
Welcome to Ubuntu 24.04.2 LTS (GNU/Linux 6.8.0-52-generic aarch64)
```

Fixing file permissions and reapplying netplan:

```bash
polina@ubuntu:~$ sudo chmod 600 /etc/netplan/00-default-nm-renderer.yaml
polina@ubuntu:~$ ls -l /etc/netplan/
total 8
-rw------- 1 root root  36 Mar  9 10:49 00-default-nm-renderer.yaml
-rw------- 1 root root 533 Mar  9 11:14 50-cloud-init.yaml
polina@ubuntu:~$ sudo nano /etc/netplan/50-cloud-init.yaml
polina@ubuntu:~$ sudo netplan apply
```

Updated Configuration in 00-default-nm-renderer.yaml:

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s1:
      addresses:
        - 192.168.64.100/24
      routes:
        - to: default
          via: 192.168.64.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4

```
8. **Restarting Network Services**
```bash
polina@ubuntu:~$ sudo netplan apply
``` 
Verifying the changes:

```bash
polina@ubuntu:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: enp0s1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 12:a2:c5:a3:d4:1c brd ff:ff:ff:ff:ff:ff
    inet 192.168.64.100/24 brd 192.168.64.255 scope global enp0s1
       valid_lft forever preferred_lft forever
```

Verifying network configuration:

```bash
polina@ubuntu:~$ ip route
default via 192.168.64.1 dev enp0s1 proto static 
192.168.64.0/24 dev enp0s1 proto kernel scope link src 192.168.64.100 
```

## **9. Capturing Network Traffic with tcpdump**

To analyze network traffic, using the `tcpdump` utility to capture packets passing through the Ethernet interface:

And saving captured packets for later analysis:

```bash
polina@ubuntu:~$ sudo tcpdump -i enp0s1 -nn -w network_traffic.pcap
```

---

## **10. Checking System Logs for Network-Related Errors**

Checking system logs for potential network issues, using the following commands:

```bash
polina@ubuntu:~$ sudo journalctl -u networking --no-pager
polina@ubuntu:~$ sudo dmesg | grep -i network
polina@ubuntu:~$ sudo cat /var/log/syslog | grep -i network
```

