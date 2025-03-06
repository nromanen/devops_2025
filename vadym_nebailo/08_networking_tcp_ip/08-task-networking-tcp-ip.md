#### Subnets

| **Subnet** | **IP diapason**               | **Mask**              |
| ---------- | ----------------------------- | --------------------- |
| VLAN 1     | 192.168.1.0 - 192.168.1.127   | 255.255.255.128 (/25) |
| VLAN 2     | 192.168.1.128 - 192.168.1.191 | 255.255.255.192 (/26) |
| VLAN 3     | 192.168.1.192 - 192.168.1.255 | 255.255.255.192 (/26) |
#### PC configuration

###### VLAN 1
Nedbailo-PC1: IP - 192.168.1.1, mask: 255.255.255.128
Nedbailo-PC2: IP - 192.168.1.2, mask: 255.255.255.128

###### VLAN 2
Nedbailo-PC3: IP - 192.168.1.130, mask: 255.255.255.192
Nedbailo-PC4: IP - 192.168.1.131, mask: 255.255.255.192

###### VLAN 3
Nedbailo-PC5: IP - 192.168.1.195, mask: 255.255.255.192
Nedbailo-PC6: IP - 192.168.1.196, mask: 255.255.255.192
Nedbailo-PC7: IP - 192.168.1.197, mask: 255.255.255.192
Nedbailo-PC8: IP - 192.168.1.198, mask: 255.255.255.192
Nedbailo-PC9: IP - 192.168.1.199, mask: 255.255.255.192
Nedbailo-PC10: IP - 192.168.1.200, mask: 255.255.255.192


#### Adding VLAN30 settings to the Switch
```bash
Switch>enable

Switch#configure terminal

Enter configuration commands, one per line. End with CNTL/Z.

Switch(config)#vlan 30

Switch(config-vlan)#name VLAN_3

Switch(config-vlan)#interface FastEthernet0/5
Switch(config-if)#switchport mode access
Switch(config-if)#switchport access vlan 30
Switch(config-if)#exit
Switch(config)#interface FastEthernet0/6
Switch(config-if)#switchport mode access
Switch(config-if)#switchport access vlan 30
Switch(config-if)#exit
Switch(config)#interface FastEthernet0/7
Switch(config-if)#switchport mode access
Switch(config-if)#switchport access vlan 30
Switch(config-if)#exit
Switch(config)#interface FastEthernet0/8
Switch(config-if)#switchport mode access
Switch(config-if)#switchport access vlan 30
Switch(config-if)#exit
Switch(config)#interface FastEthernet0/9
Switch(config-if)#switchport mode access
Switch(config-if)#switchport access vlan 30
Switch(config-if)#exit
Switch(config)#interface FastEthernet0/10
Switch(config-if)#switchport mode access
Switch(config-if)#switchport access vlan 30
Switch(config-if)#exit

Switch(config)#end

Switch#

%SYS-5-CONFIG_I: Configured from console by console

Switch#show vlan brief

  

VLAN Name Status Ports

---- -------------------------------- --------- -------------------------------

1 default active Fa0/11, Fa0/12, Fa0/13, Fa0/14

Fa0/15, Fa0/16, Fa0/17, Fa0/18

Fa0/19, Fa0/20, Fa0/21, Fa0/22

Fa0/23, Fa0/24, Gig0/1, Gig0/2

10 VLAN_1 active Fa0/1, Fa0/2

20 VLAN_2 active Fa0/3, Fa0/4

30 VLAN_3 active Fa0/5, Fa0/6, Fa0/7, Fa0/8

Fa0/9, Fa0/10

1002 fddi-default active

1003 token-ring-default active

1004 fddinet-default active

1005 trnet-default active

Switch#


```

#### Ping log from Nedbailo-PC5 to PC in same subnet and ping to PCs in other subnets
```bash
Cisco Packet Tracer PC Command Line 1.0

C:\>ping 192.168.1.200

  

Pinging 192.168.1.200 with 32 bytes of data:

  

Reply from 192.168.1.200: bytes=32 time<1ms TTL=128

Reply from 192.168.1.200: bytes=32 time=13ms TTL=128

Reply from 192.168.1.200: bytes=32 time<1ms TTL=128

Reply from 192.168.1.200: bytes=32 time<1ms TTL=128

  

Ping statistics for 192.168.1.200:

Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),

Approximate round trip times in milli-seconds:

Minimum = 0ms, Maximum = 13ms, Average = 3ms

  

C:\>ping 192.168.1.130

  

Pinging 192.168.1.130 with 32 bytes of data:

  

Request timed out.

Request timed out.

  

Ping statistics for 192.168.1.130:

Packets: Sent = 3, Received = 0, Lost = 3 (100% loss),

  

Control-C

^C

C:\>ping 192.168.1.1

  

Pinging 192.168.1.1 with 32 bytes of data:

  

Request timed out.

Request timed out.

  

Ping statistics for 192.168.1.1:

Packets: Sent = 3, Received = 0, Lost = 3 (100% loss),

  

Control-C

^C

C:\>
```

[//]: screenshot
https://drive.google.com/file/d/1xmydNhYddvTPpRrBNeM72Ibjmt4kViyR/view?usp=sharing