# Task 08: TCP/IP Addressing

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)  

## Task

1. Use the scheme from the previous task.  
2. Add 6 more computers  
3. Divide the network into workgroups using subnets.  
4. Take the class C or B IP address (at least 3 subnets in the diagram). Attention: Do not use masks /24 and /16.  
5. In the diagram, indicate the assigned addresses and masks for each PC.  
6. Take screenshots of the scheme and the results of network testing with the ping command. Upload link to results.  

---

## Solution

### Preparations 1

1. Open project for *task 7* in **Cisco Packet Tracer**.  
2. Add 6 more PCs from *End Devices* -> *End Devices* -> *PC*.  
3. Connect each new PC to a *switch*, using *Copper Straight-Through* cables from *Connections*.  

### Preparation 2

#### Commands

Create a new *vlan 4* for these six new PCs, by entering the CLI on the switch and using the following commands:  

| Command | Usage |
| --- | --- |
| `enable` | enter a privileged mode |
| `configure terminal` | enable configuration in the terminal |
| `vlan 4` | create a new vlan or configure existing |
| `exit` | exit configuration mode |

Assign ports to *vlan 4*:  

| Command | Usage |
| --- | --- |
| `interface range Fa0/5 -  Fa0/10` | define interfaces to work with |
| `switchport mode access` | enable **access** mode on it |
| `switchport access vlan 4` | provide access to *vlan 4* |

#### Output

To verify changes: `show vlan brief`  

```bash
VLAN Name                             Status    Ports
---- -------------------------------- --------- -------------------------------
1    default                          active    Fa0/11, Fa0/12, Fa0/13, Fa0/14
                                                Fa0/15, Fa0/16, Fa0/17, Fa0/18
                                                Fa0/19, Fa0/20, Fa0/21, Fa0/22
                                                Fa0/23, Fa0/24, Gig0/1, Gig0/2
2    vlan_first                       active    Fa0/1, Fa0/2
3    vlan_second                      active    Fa0/3, Fa0/4
4    vlan_third                       active    Fa0/5, Fa0/6, Fa0/7, Fa0/8
                                                Fa0/9, Fa0/10
1002 fddi-default                     active 
1003 token-ring-default               active 
1004 fddinet-default                  active 
1005 trnet-default                    active 

```

---

### Dividing the network into workgroups

#### Previous VLANs

The task forbid to use masks /24 and /16, so change previous subnet masks of `kravchuk_<number>`'s PC to the following (*Desktop* -> *IP Configuration*):  

| PC | IP | New subnet mask |
| --- | --- | --- |
| kravchuk_1 | `192.168.0.1` | `255.255.255.128` |
| kravchuk_2 | `192.168.0.2` | `255.255.255.128` |
| kravchuk_3 | `192.168.1.1` | `255.255.255.240` |
| kravchuk_4 | `192.168.1.2` | `255.255.255.240` |

#### Notes

The subnet mask `255.255.255.128` corresponds to `/25` prefix notation, which meant one bit from the host part of the IP is now used for subnetting. As a result, we get **2 ^ 1 = 2** subnets, each with **2 ^ 7 - 2 = 126** usable host addresses.  
For the IP `192.168.0.1`, the valid host address range is from `192.168.0.1` to `192.168.0.126` (inclusive).  
Similarly, the subnet mask `255.255.255.240` corresponds to `/28` prefix, which provides **2 ^ 4 = 16** subnets, with **2 ^ 4 - 2 = 14** usable host addresses in each subnet. For the IP `192.168.1.1`, the  valid host address range is from `192.168.1.1` to `192.168.1.14` (inclusive).  

---

### IP assignments

To create subnets, assign the following IPs to the newly created *vlan 4* PCs, using the subnet mask `255.255.255.252` (`/30`). This subnet mask allows only two devices to communicate with each other, as it provides exactly two usable host addresses per subnet.  

| PC | IP |
| --- | --- |
| PC0 | `192.168.2.1` |
| PC1 | `192.168.2.2` |
| PC2 | `192.168.2.5` |
| PC3 | `192.168.2.6` |
| PC4 | `192.168.2.9` |
| PC5 | `192.168.2.10` |

#### Note

By using the `/30` mask (which allocates 6 bits for the network part), we are able to fully utillize the address space, creating up to **2 ^ 6 = 64** subnets (inclusive), each with **2 ^ 2 - 2 = 2** usable host addresses (the **- 2** accounts for network and broadcast addresses).  

> The `/30` mask is commonly used for point-to-point links rather than general PC assignments, as it provides just two usable host addresses per subnet.

---

### Diagram's indications

To clarify IPs and masks used in the task, add notes using the *Place Note* icon in the logical view.  
  
Here is what information I added to my diagram:  

#### VLAN_FIRST  

```cmd
Netmask: 255.255.255.128 = 25
Subnets for /25: 2
Hosts: 126
---------
First subnet:

Network: 192.168.0.0/25
Broadcast: 192.168.0.127
HostMin: 192.168.0.1
HostMax: 192.168.0.126
```

| PC | Info |
| --- | --- |
| kravchuk_1 | `IP: 192.168.0.1` |
| | `Mask: 255.255.255.128` |
| | `Prefix: /25` |
| kravchuk_2 | `IP: 192.168.0.2` |
| | `Mask: 255.255.255.128` |
| | `Prefix: /25` |

#### VLAN_SECOND

```cmd
Netmask: 255.255.255.240 = 28
Subnets for /28: 16
Hosts: 14
---------
First subnet:

Network: 192.168.1.0/28
Broadcast: 192.168.1.15
HostMin: 192.168.1.1
HostMax: 192.168.1.14
```

| PC | Info |
| --- | --- |
| kravchuk_3 | `IP: 192.168.1.1` |
| | `Mask: 255.255.255.240` |
| | `Prefix: /28` |
| kravchuk_4 | `IP: 192.168.1.2` |
| | `Mask: 255.255.255.240` |
| | `Prefix: /28` |

#### VLAN_THIRD  

```cmd
Netmask: 255.255.255.252 = 30
Subnets for /30: 64
Hosts: 2
---------
First subnet:

Network: 192.168.2.0/30
Broadcast: 192.168.2.3
HostMin: 192.168.2.1
HostMax: 192.168.2.2
---------
Second subnet:

Network: 192.168.2.4/30
Broadcast: 192.168.2.7
HostMin: 192.168.2.5
HostMax: 192.168.2.6
---------
Third subnet:

Network: 192.168.2.8/30
Broadcast: 192.168.2.11
HostMin: 192.168.2.9
HostMax: 192.168.2.10
```

| PC | Info |
| --- | --- |
| PC0 | `IP: 192.168.2.1` |
| | `Mask: 255.255.255.252` |
| | `Prefix: /30` |
| PC1 | `IP: 192.168.2.2` |
| | `Mask: 255.255.255.252` |
| | `Prefix: /30` |
| PC2 | `IP: 192.168.2.5` |
| | `Mask: 255.255.255.252` |
| | `Prefix: /30` |
| PC3 | `IP: 192.168.2.6` |
| | `Mask: 255.255.255.252` |
| | `Prefix: /30` |
| PC4 | `IP: 192.168.2.9` |
| | `Mask: 255.255.255.252` |
| | `Prefix: /30` |
| PC5 | `IP: 192.168.2.10` |
| | `Mask: 255.255.255.252` |
| | `Prefix: /30` |

---

### Network testing

Test network using the `ping` command (from *Desktop* -> *Command Prompt*).  
Communication between different VLANs and subnets should fail because a Layer 2 switch doesn't perform routing.  

#### 1. Between VLANs

Detailed testing of *vlan_first* and *vlan_second* were provided in the [corresponding part](https://github.com/nromanen/devops_2025/blob/main/kateryna_kravchuk/task_07/task_07.md#check-the-vlans-functioning) of previous task.  
  
#### 2. From/To *vlan_third*

1. From **PC0** (*vlan_third*, first subnet) to **kravchuk_1** (*vlan_first*):  `ping 192.168.0.1`  

###### Output 

```bash
Pinging 192.168.0.1 with 32 bytes of data:

Request timed out.
Request timed out.
Request timed out.
Request timed out.

Ping statistics for 192.168.0.1:
    Packets: Sent = 4, Received = 0, Lost = 4 (100% loss),

```

[Screenshot](https://drive.google.com/file/d/15pxN2Xe5ztSFJHWWZ35tBsCBZZeGCxz5/view?usp=drive_link)

2. From **kravchuk_4** (*vlan_second*) to **PC5** (*vlan_third*, third subnet): `ping 192.168.2.10`  
  
###### Output 

```bash
Pinging 192.168.2.10 with 32 bytes of data:

Request timed out.
Request timed out.
Request timed out.
Request timed out.

Ping statistics for 192.168.2.10:
    Packets: Sent = 4, Received = 0, Lost = 4 (100% loss),

```

[Screenshot](https://drive.google.com/file/d/1MA1C7anz9D0oY8sbzvsbpWH8Jwcdkk9D/view?usp=drive_link)

#### 3. Within *vlan_third*

##### 3.1 Within the same subnet

1. From **PC2** to **PC3**: `ping 192.168.2.6`  
  
###### Output

```bash
Pinging 192.168.2.6 with 32 bytes of data:

Reply from 192.168.2.6: bytes=32 time<1ms TTL=128
Reply from 192.168.2.6: bytes=32 time<1ms TTL=128
Reply from 192.168.2.6: bytes=32 time<1ms TTL=128
Reply from 192.168.2.6: bytes=32 time<1ms TTL=128

Ping statistics for 192.168.2.6:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 0ms, Average = 0ms

```

[Screenshot](https://drive.google.com/file/d/1C1VybeXhm7ExOxVj5Tfnnpd1N1UV7-0V/view?usp=drive_link)

2. From **PC5** to **PC4**: `ping 192.168.2.9`  
  
###### Output

```bash
Pinging 192.168.2.9 with 32 bytes of data:

Reply from 192.168.2.9: bytes=32 time<1ms TTL=128
Reply from 192.168.2.9: bytes=32 time=12ms TTL=128
Reply from 192.168.2.9: bytes=32 time<1ms TTL=128
Reply from 192.168.2.9: bytes=32 time<1ms TTL=128

Ping statistics for 192.168.2.9:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 12ms, Average = 3ms

```

[Screenshot](https://drive.google.com/file/d/1oR8JvX7-f4URyRfiwHoPl84TTDtQigJs/view?usp=drive_link)

##### 3.2 Between subnets

1. From **PC1** to **PC4**: `ping 192.168.2.9`  
  
###### Output 

```bash
Pinging 192.168.2.9 with 32 bytes of data:

Request timed out.
Request timed out.
Request timed out.
Request timed out.

Ping statistics for 192.168.2.9:
    Packets: Sent = 4, Received = 0, Lost = 4 (100% loss),

```

[Screenshot](https://drive.google.com/file/d/1dpveWFezi53XuLmnc1ddKAmqGi2OXLXQ/view?usp=drive_link)

2. From **PC2** to **PC0**: `ping 192.168.2.1`  
  
###### Output

```bash
Pinging 192.168.2.1 with 32 bytes of data:

Request timed out.
Request timed out.
Request timed out.
Request timed out.

Ping statistics for 192.168.2.1:
    Packets: Sent = 4, Received = 0, Lost = 4 (100% loss),

```

[Screenshot](https://drive.google.com/file/d/1zamE2oOf1Pn8fGgyJ6zTjrni-0ZETfJk/view?usp=drive_link)

---

### Screenshots

[Diagram](https://drive.google.com/file/d/1v502vxxOgs2B87u3oIAaQzMAsV5q8Kn2/view?usp=drive_link) as a result of a work.  

### Resources

1. Detailed [explanation](https://www.cisco.com/c/en/us/support/docs/ip/routing-information-protocol-rip/13788-3.html) of subnetting and IP configuration.  
2. IP [calculator](https://jodies.de/ipcalc).  

---

## Summary

1. VLANs segment networks at *Layer 2* of the OSI model (Data Link), while subnetting operates at *Layer 3* (Network).  

2. Subnetting benefits:  
    - efficient use of IP addresses;  
    - network segmentation for better traffic management;  
    - reduction of broadcast domains to prevent congestion.  

3. Communication between different subnets, as well as between different VLANs, requires a router or a Layer 3 switch to perform inter-VLAN routing.  
