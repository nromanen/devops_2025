#### Create 2 vlan and  add your PC into vlan.

###### PC configuration

Nedbailo-PC1: IP - 192.168.1.1, mask: 255.255.255.0
Nedbailo-PC2: IP - 192.168.1.2, mask: 255.255.255.0
Nedbailo-PC3: IP - 192.168.1.3, mask: 255.255.255.0
Nedbailo-PC4: IP - 192.168.1.4, mask: 255.255.255.0

###### Switch configuration

```bash
Switch>enable 
Switch#configure terminal 
Enter configuration commands, one per line. End with CNTL/Z.

Switch(config)#vlan 10 S

witch(config-vlan)#name VLAN_1

Switch(config-vlan)#vlan 20

Switch(config-vlan)#name VLAN_2 

Switch(config-vlan)#interface FastEthernet0/1 
Switch(config-if)#switchport mode access 
Switch(config-if)#switchport access vlan 10 

Switch(config-if)#interface FastEthernet0/2 
Switch(config-if)#switchport mode access 
Switch(config-if)#switchport access vlan 10 

Switch(config-if)#interface FastEthernet0/3 
Switch(config-if)#switchport mode access 
Switch(config-if)#switchport access vlan 20

Switch(config-if)#interface FastEthernet0/4 
Switch(config-if)#switchport mode access 
Switch(config-if)#switchport access vlan 20 

Switch(config-if)#end

Switch#

%SYS-5-CONFIG_I: Configured from console by console

  

Switch#show vlan brief

VLAN Name Status Ports

---- -------------------------------- --------- -------------------------------

1 default active Fa0/5, Fa0/6, Fa0/7, Fa0/8

Fa0/9, Fa0/10, Fa0/11, Fa0/12

Fa0/13, Fa0/14, Fa0/15, Fa0/16

Fa0/17, Fa0/18, Fa0/19, Fa0/20

Fa0/21, Fa0/22, Fa0/23, Fa0/24

Gig0/1, Gig0/2

10 VLAN_Sales active Fa0/1, Fa0/2

20 VLAN_IT active Fa0/3, Fa0/4

1002 fddi-default active

1003 token-ring-default active

1004 fddinet-default active

1005 trnet-default active

Switch#

  
Switch con0 is now available
```


###### Ping log from Nedbailo-PC1 to Nedbailo-PC2
```bash
Cisco Packet Tracer PC Command Line 1.0

C:\>ping 192.168.1.2

  Pinging 192.168.1.2 with 32 bytes of data:
 

Reply from 192.168.1.2: bytes=32 time<1ms TTL=128

Reply from 192.168.1.2: bytes=32 time<1ms TTL=128

Reply from 192.168.1.2: bytes=32 time<1ms TTL=128

  

Ping statistics for 192.168.1.2:

Packets: Sent = 3, Received = 3, Lost = 0 (0% loss),

Approximate round trip times in milli-seconds:

Minimum = 0ms, Maximum = 0ms, Average = 0ms

  

Control-C
```

###### Ping log from Nedbailo-PC1 to Nedbailo-PC3
```bash
C:\>ping 192.168.1.3

  Pinging 192.168.1.3 with 32 bytes of data:

  
Request timed out.

Request timed out.
  

Ping statistics for 192.168.1.3:

Packets: Sent = 3, Received = 0, Lost = 3 (100% loss),
  

Control-C

^C

C:\>
```

[//]: screenshot
https://drive.google.com/file/d/1Awm9dSQUiJNZWxNeon0DGAWr9wWmEf1R/view?usp=sharing