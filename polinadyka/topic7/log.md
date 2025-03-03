# VLAN Configuration in Cisco Packet Tracer

## 1. Task Overview
This document describes the process of creating a network with two VLANs in Cisco Packet Tracer, verifying connectivity between PCs, and summarizing the final results.

## 2. Network Topology
### **Devices Used**:
- **1 Switch**: Cisco **2960-24TT**
- **4 PCs**: **Dyka0, Dyka1, Dyka2, Dyka3**

### **VLAN Configuration**
- **VLAN 10**: `Dyka0 (192.168.1.10)`, `Dyka1 (192.168.1.11)`
- **VLAN 20**: `Dyka2 (192.168.2.10)`, `Dyka3 (192.168.2.11)`

## 3. Switch Configuration
Two VLANs were created on the switch, and ports were assigned accordingly:

```bash
enable
configure terminal

vlan 10
name VLAN_10
exit

vlan 20
name VLAN_20
exit

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

write memory
```

## 4. Connectivity Verification (`ping`)
### **Testing Results**
- ✅ `Dyka0 → Dyka1` (Successful `ping`, both in VLAN 10)
- ✅ `Dyka2 → Dyka3` (Successful `ping`, both in VLAN 20)
- ❌ `Dyka0 → Dyka2` (Unsuccessful `ping`, different VLANs)

## 5. Evidence of Work
📌 **Google Drive Folder with Screenshots and Packet Tracer File**:  
[Project Files](https://drive.google.com/drive/folders/17b-vIbYMJ3FjF9hIEnpOQf0VF9F_TwRQ?usp=sharing)
Here:
- Network topology screenshot
- Checking the ping between Dyka0 and Dyka1 screenshot
- Check ping between Dyka2 and Dyka3 screenshot
- Verifying IP addresses of Dyka0 screenshot