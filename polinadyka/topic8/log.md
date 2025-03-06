# VLAN Configuration in Cisco Packet Tracer

## 1. Task Overview
This document describes the process of configuring a network with three VLANs, verifying connectivity between PCs.

## 2. Network Topology
### **VLAN Assignment**
| VLAN | Name        | Status | Ports                                     |
|------|-------------|--------|-------------------------------------------|
| 10   | Workgroup_A | active | Fa0/1, Fa0/2                              |
| 20   | Workgroup_B | active | Fa0/3, Fa0/4                              |
| 30   | Workgroup_C | active | Fa0/5, Fa0/6, Fa0/7, Fa0/8, Fa0/9, Fa0/10 |

### **PC and Port Assignments**
| **PC Name** | **IP Address**  | **Subnet Mask**     | **VLAN**       | **Switch Port** |
|-------------|-----------------|---------------------|----------------|-----------------|
| **Dyka0**   | 192.168.1.10    | 255.255.255.128  | Workgroup_A       | Fa0/1           |
| **Dyka1**   | 192.168.1.20    | 255.255.255.128  | Workgroup_A       | Fa0/2           |
| **Dyka2**   | 192.168.1.30    | 255.255.255.128  | Workgroup_B       | Fa0/3           |
| **Dyka3**   | 192.168.1.40    | 255.255.255.128  | Workgroup_B       | Fa0/4           |
| **Dyka4**   | 192.168.1.50    | 255.255.255.128  | Workgroup_C       | Fa0/5           |
| **Dyka5**   | 192.168.1.60    | 255.255.255.128  | Workgroup_C       | Fa0/6           |
| **Dyka6**   | 192.168.1.130   | 255.255.255.192  | Workgroup_C       | Fa0/7           |
| **Dyka7**   | 192.168.1.140   | 255.255.255.192  | Workgroup_C       | Fa0/8           |
| **Dyka8**   | 192.168.1.150   | 255.255.255.192  | Workgroup_C       | Fa0/9           |
| **Dyka9**   | 192.168.1.160   | 255.255.255.192  | Workgroup_C       | Fa0/10          |

---

## 3. VLAN Configuration on the Switch

### **Renaming VLANs**
```bash
enable
configure terminal

vlan 10
name Workgroup_A
exit

vlan 20
name Workgroup_B
exit
```

### Creating VLAN 30
```bash
vlan 30
name Workgroup_C
exit
```

### **Assigning Ports to VLANs**
```bash
interface FastEthernet0/1
switchport mode access
switchport access vlan 10
exit

interface FastEthernet0/2
switchport mode access
switchport access vlan 10
exit

interface FastEthernet0/3
switchport mode access
switchport access vlan 20
exit

interface FastEthernet0/4
switchport mode access
switchport access vlan 20
exit

interface FastEthernet0/5
switchport mode access
switchport access vlan 30
exit

interface FastEthernet0/6
switchport mode access
switchport access vlan 30
exit

interface FastEthernet0/7
switchport mode access
switchport access vlan 30
exit

interface FastEthernet0/8
switchport mode access
switchport access vlan 30
exit

interface FastEthernet0/9
switchport mode access
switchport access vlan 30
exit

interface FastEthernet0/10
switchport mode access
switchport access vlan 30
exit

write memory
```

## 4. Connectivity Verification (ping)
### ** Results**
Ping  work within the same VLAN:

```bash
ping 192.168.1.20  # Dyka0 → Dyka1 (Workgroup_A)
ping 192.168.1.140 # Dyka6 → Dyka7 (Workgroup_B)
ping 192.168.1.160 # Dyka8 → Dyka9 (Workgroup_C)
```

Ping does NOT work between different VLANs:

```bash
ping 192.168.1.130  # Dyka0 (Workgroup_A) → Dyka6 (Workgroup_B)
ping 192.168.1.150  # Dyka1 (Workgroup_A) → Dyka8 (Workgroup_C)
```

## 5. Screenshots
Google Drive Folder with Screenshots: https://drive.google.com/drive/folders/1d-MJOuEzQoQOa5rxBHao49h7vGXt0Qtj?usp=sharing
Description of Screenshots:
- Network Topology Diagram
- VLAN Configuration (`show vlan brief`)
- Successful Ping Tests Within the Same VLAN
- Failed Ping Tests Between Different VLANs