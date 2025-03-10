# Task 09: Network diagnostics

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

## Preparation

I will use the previously created virtual machine with Ubuntu Linux Server:  
    1. Start the virtual machine in VirtualBox.
    2. Log in to the server.
    3. Enable SSH:
        3.1 Run `sudo systemctl status ssh` to check if SSH is already enabled.
        3.2 If it is not enabled, run `sudo systemctl enable --now ssh`.
    4. Connect using **PuTTY**:
        4.1 Run `ip a` to find the server's IP address.
        4.2 Enter the IP address and port (22) in the PuTTY application.
        4.3 Log in again through the PuTTY terminal.

---

## Tasks and solutions

### 1. Status of the network

Check the status of the network interface. Use `atop`, `htop`, and `btop` utilities to display running processes on your OS.  

#### `atop`

Install it: `sudo apt install atop`.  
  
[Output](https://drive.google.com/file/d/1fJY487IZ2tkwp5D0F40Qu56n4HEo_a5l/view?usp=drive_link) for `atop`.  
This utility dynamically updates running process information and provides detailed metrics, including process IDs (PIDs) and CPU usage.  
  
To quit utility, press `q`.  

#### `htop`

`sudo apt install htop`  
`htop`  
  
This [utility](https://drive.google.com/file/d/1EsnGVFxEABK3HUiND3m0DZk-pdrtlqVz/view?usp=drive_link) has two interfaces: *Main* and *I/O*  providing similar information to `atop` with an interactive display.  

#### `btop`

`sudo apt install btop`  
`btop`  

[This](https://drive.google.com/file/d/1EOl-cdMcQX_9_z47cNQhKN8jTkXttREe/view?usp=drive_link) one provides a rich and visually detailed interface with multiple options for monitoring system resources.  

---

### 2. Ping

1. Ping the localhost with a set of 10 packets, each with a size of 1500 bytes.
2. Ping an external host by its name and obtain its IP address.
3. Trace the route to the external host (e.g., softerveinc.com).

#### `ping`

1. `ping -c 10 -s 1500 127.0.0.1`

```bash
PING 127.0.0.1 (127.0.0.1) 1500(1528) bytes of data.
1508 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.027 ms
1508 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.043 ms
1508 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.041 ms
1508 bytes from 127.0.0.1: icmp_seq=4 ttl=64 time=0.041 ms
1508 bytes from 127.0.0.1: icmp_seq=5 ttl=64 time=0.042 ms
1508 bytes from 127.0.0.1: icmp_seq=6 ttl=64 time=0.038 ms
1508 bytes from 127.0.0.1: icmp_seq=7 ttl=64 time=0.042 ms
1508 bytes from 127.0.0.1: icmp_seq=8 ttl=64 time=0.042 ms
1508 bytes from 127.0.0.1: icmp_seq=9 ttl=64 time=0.042 ms
1508 bytes from 127.0.0.1: icmp_seq=10 ttl=64 time=0.040 ms

--- 127.0.0.1 ping statistics ---
10 packets transmitted, 10 received, 0% packet loss, time 9195ms
rtt min/avg/max/mdev = 0.027/0.039/0.043/0.004 ms
```

2. `ping -c 4 www.google.com`

```bash
PING www.google.com (216.58.215.100) 56(84) bytes of data.
64 bytes from waw02s17-in-f4.1e100.net (216.58.215.100): icmp_seq=1 ttl=118 time=113 ms
64 bytes from waw02s17-in-f4.1e100.net (216.58.215.100): icmp_seq=2 ttl=118 time=136 ms
64 bytes from waw02s17-in-f4.1e100.net (216.58.215.100): icmp_seq=3 ttl=118 time=56.4 ms
64 bytes from waw02s17-in-f4.1e100.net (216.58.215.100): icmp_seq=4 ttl=118 time=79.6 ms

--- www.google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3003ms
rtt min/avg/max/mdev = 56.351/96.153/136.013/30.489 ms
```

The IP address of *[www.google.com](www.google.com)* is displayed in the first line of the output: `216.58.215.100`.  

#### `traceroute`

To install command: `sudo apt install inetutils-traceroute`.  
`traceroute -I softerveinc.com`  

```bash
traceroute to softserveinc.com (45.60.69.61), 64 hops max
  1   192.168.1.1  7.994ms  0.005ms  2.508ms
  2   192.168.0.1  1.910ms  2.084ms  2.412ms
  3   109.87.212.254  3.292ms  3.160ms  3.174ms
  4   78.154.162.37  6.312ms  6.981ms  5.679ms
  5   80.93.127.226  11.354ms  14.002ms  13.325ms
  6   62.115.42.110  57.124ms  100.858ms  100.693ms
  7   62.115.117.224  99.771ms  103.167ms  98.312ms
  8   62.115.123.13  102.146ms  101.098ms  74.834ms
  9   62.115.140.105  230.813ms  202.781ms  204.013ms
 10   62.115.123.123  206.055ms  204.765ms  201.523ms
 11   62.115.55.139  205.187ms  203.089ms  204.219ms
 12   45.60.69.61  201.316ms  202.016ms  203.012ms
```

The `-I` option forces to use *ICMP* Echo Requests instead of the default *UDP* packets. This can be beneficial because some firewalls block UDP-based traceroute packets while allowing ICMP traffic.  

### 3. DNS

Check your DNS configuration.

#### To check the configured DNS servers: `cat /etc/resolv.conf`

```bash
nameserver 127.0.0.53
options edns0 trust-ad
search .
```

This output indicates server is using `systemd-resolved` for DNS resolution.  
`systemd-resolved` typically listens on `127.0.0.53` (*localhost*) and forwards DNS queries to the external DNS servers.  

#### To manually test DNS resolution: `dig google.com`

```bash
; <<>> DiG 9.18.30-0ubuntu0.24.04.2-Ubuntu <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49301
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;google.com.                    IN      A

;; ANSWER SECTION:
google.com.             130     IN      A       142.250.186.206

;; Query time: 11 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Mon Mar 10 08:45:45 UTC 2025
;; MSG SIZE  rcvd: 55

```

The `dig` (domain information groper) is a flexible tool for querying DNS name servers. It performs DNS lookups and displays the answers that are returned from the queried name server(s).  
In the **output**:  
    1. The ANSWER SECTION shows the resolved IP address (`142.250.186.206`) for *google.com*.
    2. The SERVER field confirms that the query was processed by `127.0.0.53`, meaning `systemd-resolved` is working correctly.
    3. The *UDP* protocol was used for the query.
This confirms that the DNS server is functioning properly.  

---

### 4. Firewall

Review the firewall rules (iptables or ufw). List the open ports on your system using netstat and ss.

> Install packages: ... .  

#### `sudo iptables -L -v -n`

```bash
[sudo] password for lians:
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination

```

This **output** indicates no active firewall rules at the moment.  

##### Options for `iptables`

`-L` lists all rules.  
`-v` gives verbose output, including packet counts.  
`-n` displays numeric IP addresses and port numbers (avoids DNS resolution delays).  

#### `sudo ufw status verbose`

> `ufw` stands for *Uncomplicated Firewall*  

```bash
Status: inactive
```

This output indicates *ufw* is currently disabled.  

---

#### Listening ports by `sudo netstat -tuln`

```bash
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 127.0.0.54:53           0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp6       0      0 :::22                   :::*                    LISTEN
udp        0      0 127.0.0.54:53           0.0.0.0:*
udp        0      0 127.0.0.53:53           0.0.0.0:*
udp        0      0 192.168.1.110:68        0.0.0.0:*
```

##### Options for `netstat`

`-t` shows TCP connections.  
`-u` shows UDP connections.  
`-l` shows only listening ports.  
`-n` shows numerical addresses and ports (instead of resolving them).  

#### Listening ports by `sudo ss -tuln`

```bash
Netid          State           Recv-Q           Send-Q                 Local Address:Port          Peer Address:Port          Process
udp            UNCONN          0                0                         127.0.0.54:53                 0.0.0.0:*
udp            UNCONN          0                0                      127.0.0.53%lo:53                 0.0.0.0:*
udp            UNCONN          0                0               192.168.1.110%enp0s3:68                 0.0.0.0:*
tcp            LISTEN          0                4096                      127.0.0.54:53                 0.0.0.0:*
tcp            LISTEN          0                4096                   127.0.0.53%lo:53                 0.0.0.0:*
tcp            LISTEN          0                128                          0.0.0.0:22                 0.0.0.0:*
tcp            LISTEN          0                128                             [::]:22                    [::]:*

```

>Options are the same as for `netstat`.  

##### Analysis of listening ports

From the above **outputs**, we can see:  
    1. Port **53** (DNS) is being used by `systemd-resolved` (`127.0.0.53` and `127.0.0.54`).
    2. Port **22** (SSH) is open on both *IPv4* (`0.0.0.0:22`) and *IPv6* (`:::22`).
    3. Port **68** (UDP) is used for *DHCP* client communication (`192.168.1.110:68`).  
  
This means the machine accepts SSH connections, but no additional services are exposed externally.  

---

### 5. DHCP

If you are using DHCP,  
    1. verify that your system is obtaining an IP address correctly.  
    2. Change the IP address using the dhclient command.  
    3. Show the results.  

#### 5.1 Check current configuration

##### `ip a`  

```bash
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:1d:14:8e brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.110/24 metric 100 brd 192.168.1.255 scope global dynamic enp0s3
       valid_lft 83733sec preferred_lft 83733sec
    inet6 fe80::a00:27ff:fe1d:148e/64 scope link
       valid_lft forever preferred_lft forever
```

##### `ifconfig`

```bash
enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.110  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::a00:27ff:fe1d:148e  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:1d:14:8e  txqueuelen 1000  (Ethernet)
        RX packets 6324  bytes 2269337 (2.2 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 7294  bytes 7809550 (7.8 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 166  bytes 42192 (42.1 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 166  bytes 42192 (42.1 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

These outputs shows that server is obtaining an IP addresses **via DHCP**, as indicated by the line following *valid_lft*:  
`valid_lft 83733sec preferred_lft 83733sec`

##### `ps aux | grep dhclient`

> To install *dhclient*: `sudo apt install isc-dhcp-client`  

```bash
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
lians       1663  0.0  0.1   6544  2304 pts/0    S+   09:09   0:00 grep --color=auto dhclient
```

The **output** implies the DHCP client is not actively requesting an IP address at the moment.

#### 5.2 `dhcpclient`

1. `sudo dhclient -r` to release IP address.  
2. `sudo dhclient enp0s3` to obtain a new one.  

```bash
Setting LLMNR support level "yes" for "2", but the global support level is "no".
Failed to set DNS configuration: Invalid DNS server address
```

##### Checking the network configuration file

The previous **output** suggests there may be an issue with DNS configuration during the DHCP process. To investigate further, check the network configuration file: `sudo cat /etc/netplan/*.yaml`  

```yaml
network:
    ethernets:
        enp0s3:
            dhcp4: true
    version: 2
```

##### Troubleshooting

Since `dhcp4: true` is configured properly, but DNS issues persist, restart `systemd-networkd`, which is the default network renderer for *netplan*:. This will shutdown the PuTTY connection ("Network error: Software caused connection abort"), so reconnect and check the IP address by running `ip a` again.  

```bash
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:1d:14:8e brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.111/24 metric 100 brd 192.168.1.255 scope global dynamic enp0s3
       valid_lft 86337sec preferred_lft 86337sec
    inet6 fe80::a00:27ff:fe1d:148e/64 scope link
       valid_lft forever preferred_lft forever
```

The IP address ***has successfully changed*** to `192.168.1.111/24`!  
Reconnect to the server via PuTTY (with this new IP) to confirm and continue testing.  

##### `ifconfig` check

```bash

enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.111  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::a00:27ff:fe1d:148e  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:1d:14:8e  txqueuelen 1000  (Ethernet)
        RX packets 775  bytes 76980 (76.9 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 406  bytes 57644 (57.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 120  bytes 9016 (9.0 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 120  bytes 9016 (9.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

These **results** confirm that the IP address was successfully changed by releasing the current IP with *dhclient*, obtaining a new one, and verifying the changes by restarting `systemd-networkd`.  

##### Notes on `dhclient`

If we run `ip a` after `sudo dhclient -r` **without** obtaining a new IP, the output will look like this:  

```bash
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:1d:14:8e brd ff:ff:ff:ff:ff:ff
    inet6 fe80::a00:27ff:fe1d:148e/64 scope link
       valid_lft forever preferred_lft forever
```

>Notice that there is no line indicating an IPv4 address assigned to the *enp0s3* interface.  

##### 5.3 Results

**Output** after running `sudo dhclient enp0s3` were provided before.  

---

### 6. Network

#### 6.1 Check the network configuration files

I was doing this **previously** (when trying to understand the strange output by *dhclient*).  

#### 6.2 Add a static IP address to an existing interface  

To do this, first open the file by `sudo nano /etc/netplan/*.yaml`, then disable *DHCP* and add lines to assign a static IP address to match the following:  

```yaml
network:
    ethernets:
        enp0s3:
            dhcp4: false
            addresses:
              - 192.168.1.110/24
            routes:
              - to: default
                via: 192.168.1.1
    version: 2
```

> `Ctrl + O` to save, *enter* to confirm and `ctrl + X` to exit.  

#### 6.3 Apply the changes and verify correct operation

1. `sudo netplan generate` to check for errors, and then `sudo netplan apply`.  
Since the PuTTY connection will be terminated, run `ip a` directly on the server to verify the changes:  

```bash
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:1d:14:8e brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.110/24 brd 192.168.1.255 scope global enp0s3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe1d:148e/64 scope link
       valid_lft forever preferred_lft forever
```

The **output** confirmed that the static IP address (`192.168.1.110/24`) was successfully assigned to the *enp0s3* interface.  

2. Verify the routing table: `ip route show`  

```bash
default via 192.168.1.1 dev enp0s3 proto static
192.168.1.0/24 dev enp0s3 proto kernel scope link src 192.168.1.110
```

The **routing table** confirmed the default route was correctly set to `192.168.1.1` via *enp0s3*, and the local network (`192.168.1.0/24`) was properly configured.  

---

### 7. Restart & verifying

#### 7.1 Restart network services to apply any changes made during troubleshooting

Again: `sudo systemctl restart systemd-networkd`.  
This step doesn't change anything as the network service was already restarted earlier.  

#### 7.2 Check the firewall status on your system

##### `ufw`

Check the status of the firewall: `sudo ufw status`.

```bash
Status: inactive
```

To allow HTTP (port 80) traffic: `sudo ufw allow 80/tcp`.  

```bash
Rules updated
Rules updated (v6)
```

##### `iptables`

Verify the current `iptables` rules: `sudo iptables -L`. The output shows no rules.  
To add an HTTP rule, use the following: `sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT`.  
To confirm the new rule has been added, check the iptables again: `sudo iptables -L`.  

```bash
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:http

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
```

---

### 8. Traffic

Use the tcpdump utility to display traffic through the Ethernet port, including IP addresses and port numbers.  

> Use `sudo apt install tcpdump -y` to install the utility.  
>Here will be just a small pieces of a huge outputs.  

#### To display available interfaces for capturing traffic: `tcpdump -D`

```bash
1.enp0s3 [Up, Running, Connected]
2.any (Pseudo-device that captures on all interfaces) [Up, Running]
3.lo [Up, Running, Loopback]
4.bluetooth-monitor (Bluetooth Linux Monitor) [Wireless]
5.nflog (Linux netfilter log (NFLOG) interface) [none]
6.nfqueue (Linux netfilter queue (NFQUEUE) interface) [none]
7.dbus-system (D-Bus system bus) [none]
8.dbus-session (D-Bus session bus) [none]
```

This **output** lists various interfaces, including *enp0s3* (Ethernet) and *lo* (Loopback).  

#### To capture traffic on the *enp0s3*: `sudo tcpdump -i enp0s3`

```bash
listening on enp0s3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
12:41:47.434414 IP userver.ssh > 192.168.1.104.51851: Flags [P.], seq 3926721183:3926721311, ack 18546707, win 519, length 128
12:41:47.436371 IP userver.ssh > 192.168.1.104.51851: Flags [P.], seq 128:272, ack 1, win 519, length 144
12:41:47.437199 IP 192.168.1.104.51851 > userver.ssh: Flags [.], ack 272, win 254, length 0
12:41:47.528363 IP userver.ssh > 192.168.1.104.51851: Flags [P.], seq 272:656, ack 1, win 519, length 384
12:41:47.568816 IP 192.168.1.104.51851 > userver.ssh: Flags [.], ack 656, win 252, length 0
12:41:47.629609 IP userver.ssh > 192.168.1.104.51851: Flags [P.], seq 656:912, ack 1, win 519, length 256
12:41:47.671646 IP 192.168.1.104.51851 > userver.ssh: Flags [.], ack 912, win 250, length 0
12:41:47.733505 IP userver.ssh > 192.168.1.104.51851: Flags [P.], seq 912:1168, ack 1, win 519, length 256
12:41:47.775640 IP 192.168.1.104.51851 > userver.ssh: Flags [.], ack 1168, win 250, length 0
12:41:47.837539 IP userver.ssh > 192.168.1.104.51851: Flags [P.], seq 1168:1424, ack 1, win 519, length 256
12:41:47.878927 IP 192.168.1.104.51851 > userver.ssh: Flags [.], ack 1424, win 255, length 0
^Ctcpdump: Unable to write output: Interrupted system call
```

This captures packets exchanged between the *userver.ssh* and `192.168.1.104.51851`.  
The flags indicate different packet statuses such as **P.** (push), **.** (acknowledgment), and **seq**uence numbers.  

#### To capture with more details: `sudo tcpdump -i enp0s3 -n -v`

```bash
tcpdump: listening on enp0s3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
12:50:40.302662 IP (tos 0x10, ttl 64, id 22925, offset 0, flags [DF], proto TCP (6), length 104)
    192.168.1.110.22 > 192.168.1.104.51851: Flags [P.], cksum 0x8481 (incorrect -> 0x6ee7), seq 3926742895:3926742959, ack 18548131, win 519, length 64
12:50:40.303779 IP (tos 0x10, ttl 64, id 22926, offset 0, flags [DF], proto TCP (6), length 184)
    192.168.1.110.22 > 192.168.1.104.51851: Flags [P.], cksum 0x84d1 (incorrect -> 0xef8f), seq 64:208, ack 1, win 519, length 144
12:50:40.304678 IP (tos 0x0, ttl 128, id 49522, offset 0, flags [DF], proto TCP (6), length 40)
    192.168.1.104.51851 > 192.168.1.110.22: Flags [.], cksum 0x1703 (correct), ack 208, win 254, length 0
12:50:40.408781 IP (tos 0x10, ttl 64, id 22927, offset 0, flags [DF], proto TCP (6), length 776)
    192.168.1.110.22 > 192.168.1.104.51851: Flags [P.], cksum 0x8721 (incorrect -> 0xd8a6), seq 208:944, ack 1, win 519, length 736
12:50:40.450951 IP (tos 0x0, ttl 128, id 49523, offset 0, flags [DF], proto TCP (6), length 40)
    192.168.1.104.51851 > 192.168.1.110.22: Flags [.], cksum 0x1425 (correct), ack 944, win 252, length 0
12:50:40.509668 IP (tos 0x10, ttl 64, id 22928, offset 0, flags [DF], proto TCP (6), length 328)
    192.168.1.110.22 > 192.168.1.104.51851: Flags [P.], cksum 0x8561 (incorrect -> 0xed58), seq 944:1232, ack 1, win 519, length 288
12:50:40.511138 IP (tos 0x10, ttl 64, id 22929, offset 0, flags [DF], proto TCP (6), length 296)
^C
36 packets captured
39 packets received by filter
0 packets dropped by kernel
```

This **output** provides additional details such as:  
    1. *TTL* (Time to Live) and *ID* for each packet.
    2. Checksum validation status for the packets.
    3. **Seq**uence and **ack**nowledgment numbers that help in tracking the flow of the communication.

---

### 9. Logs

Check system logs for network-related errors. Common logs include syslog, messages, access, and network.log.

#### Logs from `/var/log/syslog`

`sudo grep -i 'network' /var/log/syslog | tail -n 15`

>The `cat /var/syslog` produses a much larger output.  

```bash
2025-03-10T12:28:16.598460+00:00 userver systemd-networkd[3471]: lo: Gained carrier
2025-03-10T12:28:16.599389+00:00 userver systemd-networkd[3471]: enp0s3: Link UP
2025-03-10T12:28:16.599625+00:00 userver systemd-networkd[3471]: enp0s3: Gained carrier
2025-03-10T12:28:16.608343+00:00 userver systemd-networkd[3471]: enp0s3: Gained IPv6LL
2025-03-10T12:28:16.609403+00:00 userver systemd-timesyncd[558]: Network configuration changed, trying to establish connection.
2025-03-10T12:28:16.618741+00:00 userver systemd-networkd[3471]: Enumeration completed
2025-03-10T12:28:16.618833+00:00 userver systemd[1]: Started systemd-networkd.service - Network Configuration.
2025-03-10T12:28:16.633412+00:00 userver systemd[1]: Starting systemd-networkd-wait-online.service - Wait for Network to be Configured...
2025-03-10T12:28:16.646086+00:00 userver systemd-timesyncd[558]: Network configuration changed, trying to establish connection.
2025-03-10T12:28:16.677212+00:00 userver systemd-networkd[3471]: enp0s3: Configuring with /run/systemd/network/10-netplan-enp0s3.network.
2025-03-10T12:28:16.745180+00:00 userver systemd-timesyncd[558]: Network configuration changed, trying to establish connection.
2025-03-10T12:28:16.757164+00:00 userver systemd-timesyncd[558]: Network configuration changed, trying to establish connection.
2025-03-10T12:28:16.805359+00:00 userver systemd[1]: Finished systemd-networkd-wait-online.service - Wait for Network to be Configured.
2025-03-10T13:12:29.036977+00:00 userver snapd[3673]: autorefresh.go:625: Cannot prepare auto-refresh change due to a permanent network error: persistent network error: Post "https://api.snapcraft.io/v2/snaps/refresh": dial tcp: lookup api.snapcraft.io: Temporary failure in name resolution
2025-03-10T13:12:29.088493+00:00 userver snapd[3673]: stateengine.go:161: state ensure error: persistent network error: Post "https://api.snapcraft.io/v2/snaps/refresh": dial tcp: lookup api.snapcraft.io: Temporary failure in name resolution
```

##### Output notes 1

1. The `systemd-networkd` logs show the network interfaces (`lo` and `enp0s3`) gaining carriers and successfully linking up. This indicates that the network interfaces are being properly initialized.
2. `systemd-timesyncd` reports multiple attempts to re-establish a connection after network configuration changes. This might be a result of network service restarts or modifications.
3. The *snapd* service logs indicate a failure when attempting to perform a network operation, specifically related to DNS resolution (Temporary failure in name resolution). This is a common issue when the network or DNS services are misconfigured.

#### Logs from `/var/log/cloud-init.log`

`sudo grep -i 'network' /var/log/cloud-init.log | tail -n 15`

```bash
2025-02-04 21:43:49,002 - handlers.py[DEBUG]: start: init-network/config-resizefs: running config-resizefs with frequency always
2025-02-04 21:43:49,002 - handlers.py[DEBUG]: finish: init-network/config-resizefs: SUCCESS: config-resizefs ran successfully
2025-02-04 21:43:49,002 - handlers.py[DEBUG]: start: init-network/config-mounts: running config-mounts with frequency once-per-instance
2025-02-04 21:43:49,006 - handlers.py[DEBUG]: finish: init-network/config-mounts: SUCCESS: config-mounts ran successfully
2025-02-04 21:43:49,006 - handlers.py[DEBUG]: start: init-network/config-set_hostname: running config-set_hostname with frequency once-per-instance
2025-02-04 21:43:49,007 - handlers.py[DEBUG]: finish: init-network/config-set_hostname: SUCCESS: config-set_hostname ran successfully
2025-02-04 21:43:49,007 - handlers.py[DEBUG]: start: init-network/config-update_hostname: running config-update_hostname with frequency always
2025-02-04 21:43:49,007 - handlers.py[DEBUG]: finish: init-network/config-update_hostname: SUCCESS: config-update_hostname ran successfully
2025-02-04 21:43:49,007 - handlers.py[DEBUG]: start: init-network/config-users_groups: running config-users_groups with frequency once-per-instance
2025-02-04 21:43:49,196 - handlers.py[DEBUG]: finish: init-network/config-users_groups: SUCCESS: config-users_groups ran successfully
2025-02-04 21:43:49,196 - handlers.py[DEBUG]: start: init-network/config-ssh: running config-ssh with frequency once-per-instance
2025-02-04 21:43:51,657 - handlers.py[DEBUG]: finish: init-network/config-ssh: SUCCESS: config-ssh ran successfully
2025-02-04 21:43:51,660 - handlers.py[DEBUG]: finish: init-network: SUCCESS: searching for network datasources
2025-02-04 21:44:05,050 - stages.py[DEBUG]: Allowed events: {<EventScope.NETWORK: 'network'>: {<EventType.BOOT_NEW_INSTANCE: 'boot-new-instance'>}}
2025-02-04 21:44:05,050 - stages.py[DEBUG]: Event Denied: scopes=['network'] EventType=hotplug
```

##### Output notes 2

1. Cloud-init network configuration: this shows successful completion of several cloud-init tasks, including resizing filesystems, configuring mounts, and setting hostnames. The log entries indicate that network configurations (such as `config-set_hostname`, `config-update_hostname`, and `config-ssh`) ran successfully.
2. The log entry `Event Denied: scopes=['network'] EventType=hotplug` suggests that cloud-init was configured to reject certain dynamic network events (hotplug events) during the instance setup.

#### Summary for *logs*

The *syslog* entries confirm network interfaces are being initialized correctly, but the *snapd* errors related to DNS indicate that network resolution might still be problematic (e.g., DNS issues or misconfiguration).  
The *cloud-init* log shows that network configuration tasks were executed correctly during instance setup, and dynamic network events (such as *hotplug*) were denied for some reason, which could be related to network interface configuration timing.  

---

### Screenshots

Some screenshots are included in the solution descriptions, but most can be found [here](https://drive.google.com/drive/folders/1WKTmHcWIRDsP66Ncj7xzo_ApWDT23IKC?usp=drive_link). The remaining ones are provided as text output within this file.  
