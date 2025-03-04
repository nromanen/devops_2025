# Task 07: Assignment Network Basic

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

## Preparation

1. Install Cisco Packet Tracer from [official source](https://www.netacad.com/cisco-packet-tracer).  
2. Explore basic features of the program (I used [this course](https://www.netacad.com/courses/getting-started-cisco-packet-tracer?courseLang=en-US) for it).  

---

## Task 1

### 1. Create a network that is shown on the [diagram](https://drive.google.com/file/d/1ioroSL9uOO1GR78wGtHd0doFFPOMhhSb/view?usp=sharing)

1. Switch to the *Logical mode* (if not already enabled).  
2. Drag-and-drop **4** PCs from *End devices* -> *End devices* -> *PC*.  
3. Drag-and-drop **1** switch from *Network devices* -> *Switches* -> *2960*.  
4. Use cables from *Connections* -> *Copper Straight-through* to connect each PC's **fastEthernet** port to the corresponding port on a switch:  

    | PC | Switch port |
    | --- | --- |
    | PC1 | FastEthernet0/1 |
    | PC2 | FastEthernet0/2 |
    | PC3 | FastEthernet0/3 |
    | PC4 | FastEthernet0/4 |

### 2. Assign PC names

1. Click on a PC to open its menu, then navigate to *Config* tab.  
2. In the *Display Name* field, enter the desired name:  
    `kravchuk_<PC_number>`  
Changes will be applied immediately.  

### 3. Configure IP addresses

1. Click on a PC, navigate to the *Desktop* -> *IP Configuration*.  
2. Assign the following IPs:  

    | PC | IP |
    | --- | --- |
    | 1 | `192.168.0.1` |
    | 2 | `192.168.0.2` |
    | 3 | `192.168.1.1` |
    | 4 | `192.168.1.2` |

3. Assign the *subnet mask*: `255.255.255.0`  
4. Leave the *Default Gateway* and *DNS Server* fields empty.  

#### Notes

##### Choosing IPs

Each assigned IP belongs to *Class C* private address space (`192.168.x.x/24`), which is commonly used in small networks.  
Subnet mask `255.255.255.0` corresponds to `/24`, meaning each subnet contains 256 addresses (0-255), with usable host addresses from `.1` to `.254`.  

---

## Task 2

### Create VLANs

#### Commands

1. Enter *privileged* mode: `enable` (notice how the separator at the end changed from `>` to `#`).  
2. Enter configuration mode: `configure terminal`.  
3. Create VLAN: `vlan <number>` (in our case `vlan 2`).  
4. Assign a human-readable name: `name <name>` (`name vlan_first`)  
5. Close the configuration of VLAN: `exit`.  
6. Make another VLAN (`vlan 3`) - repeat stages *3 - 5*.  

> `vlan 1` is default network of switch itself, so it's not a good practice to assign it for another usage except the maintenance and configuration of a switch.  

#### Output

```bash
Switch>enable
Switch#configure terminal
Enter configuration commands, one per line. End with CNTL/Z.
Switch(config)#vlan 2
Switch(config-vlan)#name vlan_first
Switch(config-vlan)#exit
Switch(config)#vlan 3
Switch(config-vlan)#name vlan_second
Switch(config-vlan)#exit
```  

### Add your PC into `vlan`

#### Commands

1. Switch to desired port's interface - `interface <port> <number>`:  
(`interface fastEthernet 0/1`).  
2. Enable access mode on it: `switchport mode access`.  
3. Assign it to the desired VLAN (`FastEthernet0/1` and `FastEthernet0/2` to VLAN 2, `FastEthernet0/3` and `FastEthernet0/4` to VLAN 3) - `switchport access vlan <number>`:  
(`switchport access vlan 2`).  
4. To move out of *interface mode*: `exit`.  
5. Set up another interface - repeat stages *1 - 4*.  

#### Output

```bash
Switch(config)#interface fastEthernet 0/1
Switch(config-if)#switchport mode access
Switch(config-if)#switchport access vlan 2
Switch(config-if)#exit
Switch(config)#interface fastEthernet 0/2
Switch(config-if)#switchport mode access
Switch(config-if)#switchport access vlan 2
Switch(config-if)#exit
Switch(config)#interface fastEthernet 0/3
Switch(config-if)#switchport mode access
Switch(config-if)#switchport access vlan 3
Switch(config-if)#exit
Switch(config)#interface fastEthernet 0/4
Switch(config-if)#switchport mode access
Switch(config-if)#switchport access vlan 3
Switch(config-if)#exit
```

---

### Check the VLANs' configuration

#### Command

Run `show vlan brief`.  

#### Output

```bash
VLAN Name                             Status    Ports
---- -------------------------------- --------- -------------------------------
1    default                          active    Fa0/5, Fa0/6, Fa0/7, Fa0/8
                                                Fa0/9, Fa0/10, Fa0/11, Fa0/12
                                                Fa0/13, Fa0/14, Fa0/15, Fa0/16
                                                Fa0/17, Fa0/18, Fa0/19, Fa0/20
                                                Fa0/21, Fa0/22, Fa0/23, Fa0/24
                                                Gig0/1, Gig0/2
2    vlan_first                       active    Fa0/1, Fa0/2
3    vlan_second                      active    Fa0/3, Fa0/4
1002 fddi-default                     active 
1003 token-ring-default               active 
1004 fddinet-default                  active 
1005 trnet-default                    active 

```

### Check the VLANs' functioning

A VLAN logically segments the network at **Layer 2 (Data Link Layer)**, so by default:  
    - devices in the same VLAN can communicate because they share *the same* broadcast domain;  
    - devices in different VLANs cannot communicate because VLANs create *isolated* broadcast domains.  
To check this out in action, use `ping` command.  

#### Output for PC1

```sh
C:\>ping 192.168.0.2

Pinging 192.168.0.2 with 32 bytes of data:

Reply from 192.168.0.2: bytes=32 time<1ms TTL=120
Reply from 192.168.0.2: bytes=32 time<1ms TTL=120
Reply from 192.168.0.2: bytes=32 time<1ms TTL=120
Reply from 192.168.0.2: bytes=32 time<1ms TTL=120

Ping statistics for 192.168.0.2:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 0 ms, Average = 0 ms

C:\>ping 192.168.1.1

Pinging 192.168.1.1 with 32 bytes of data:

Request timed out.
Request timed out.
Request timed out.
Request timed out.

Ping statistics for 192.168.1.1:
    Packets: Sent = 4, Received = 4, Lost = 4 (100% loss),

```

#### Output for PC2

```sh
C:\>ping 192.168.0.1

Pinging 192.168.0.1 with 32 bytes of data:

Reply from 192.168.0.1: bytes=32 time<1ms TTL=120
Reply from 192.168.0.1: bytes=32 time<1ms TTL=120
Reply from 192.168.0.1: bytes=32 time<1ms TTL=120
Reply from 192.168.0.1: bytes=32 time<1ms TTL=120

Ping statistics for 192.168.0.1:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 0 ms, Average = 0 ms

```

#### Output for PC3

```sh
C:\>ping 192.168.1.2

Pinging 192.168.1.2 with 32 bytes of data:

Reply from 192.168.1.2: bytes=32 time<1ms TTL=120
Reply from 192.168.1.2: bytes=32 time<1ms TTL=120
Reply from 192.168.1.2: bytes=32 time<1ms TTL=120
Reply from 192.168.1.2: bytes=32 time=5ms TTL=120

Ping statistics for 192.168.1.2:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 5 ms, Average = 1 ms

C:\>ping 192.168.0.2

Pinging 192.168.0.2 with 32 bytes of data:

Request timed out.
Request timed out.
Request timed out.
Request timed out.

Ping statistics for 192.168.0.2:
    Packets: Sent = 4, Received = 4, Lost = 4 (100% loss),

```

#### Output for PC4

```sh
C:\>ping 192.168.1.1

Pinging 192.168.1.1 with 32 bytes of data:

Reply from 192.168.1.1: bytes=32 time<1ms TTL=120
Reply from 192.168.1.1: bytes=32 time<1ms TTL=120
Reply from 192.168.1.1: bytes=32 time=5ms TTL=120
Reply from 192.168.1.1: bytes=32 time<1ms TTL=120

Ping statistics for 192.168.1.1:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 5 ms, Average = 1 ms

C:\>ping 192.168.0.1

Pinging 192.168.0.1 with 32 bytes of data:

Request timed out.
Request timed out.
Request timed out.
Request timed out.

Ping statistics for 192.168.0.1:
    Packets: Sent = 4, Received = 4, Lost = 4 (100% loss),

```

#### Interpretation

So, we observe that PCs within the same VLAN successfully communicate (`ping` replies received), while attempts to communicate across VLANs fail (`Request timed out`).  
This confirms that VLAN segmentation is correctly enforced, preventing inter-VLAN traffic.  

---

## Screenshots

[Photo](https://drive.google.com/file/d/1A4-GD0bi7H-8fQfxi3vupScSggFoJjBD/view?usp=drive_link) of the network topology  
Configuring IP on PCs: [PC1](https://drive.google.com/file/d/1aw4IVpVWrTpOp0QCVTXv19c-Ckxyz8zF/view?usp=drive_link), [PC2](https://drive.google.com/file/d/1NbhosdRsSIwXxmlR6nzKnWLjrreArkCX/view?usp=drive_link), [PC3](https://drive.google.com/file/d/1CKpDPKjiUyUNJ1kL23wCk1gH5_bc5ztZ/view?usp=drive_link), [PC4](https://drive.google.com/file/d/1TsH2W7d-aT4hu0a4_RGZTuaShFiprN7s/view?usp=drive_link)  

### VLAN

Creating [VLANs](https://drive.google.com/file/d/1evV0JsAvYrshBH6RbMAdqZgCTtxaMHsd/view?usp=drive_link)  
Configuring [ports](https://drive.google.com/file/d/1mHCsui1fNA6taPIhxcLhdoL_GZFQ8zhu/view?usp=drive_link) and checking VLANs' configuration  

---

## Summary

1. VLAN benefits:  

    - help segment the network logically;  
    - improve security by isolating devices;  
    - reduce unnecessary traffic (prevent broadcast storms).  

2. Inter-VLAN communication requires a router or Layer 3 switch.  
