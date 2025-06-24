<div align="center">
  
<h2>RouterOS scenario including a switch, a router, masquerading and vlans</h2>
<img alt="Static Badge" src="https://img.shields.io/badge/routeros-gray?style=for-the-badge&logo=mikrotik&logoColor=white&logoSize=auto">
</div>

### Project Goals & Architecture

This project implements a simple, secure, scalable, and segmented network topology using MikroTik RouterOS.  

- **VLAN-based Network Segmentation:** The network is logically divided into three distinct broadcast domains to enhance security and manage traffic effectively:
  - `VLAN 10`: **Management** (`10.10.10.0/24`) - For secure access to network infrastructure.
  - `VLAN 20`: **Servers** (`10.10.20.0/24`) - An isolated zone for virtual machines, containers, and other services.
  - `VLAN 30`: **Users** (`10.10.30.0/24`) - A general-purpose network for client devices.

- **Router-on-a-Stick Topology:** All inter-VLAN routing is handled centrally by the CCR2004 router. A single tagged trunk link connects the router to the CRS326 switch, ensuring an efficient and scalable design.

- **Granular Firewall Policies:** A stateful firewall is configured on the CCR to enforce a strict security posture:
  - **Input Chain Hardening:** The router itself is protected from unauthorized access from the WAN.
  - **Forward Chain Control:** Specific rules govern the traffic flow between VLANs (e.g., allowing 'Users' to access 'Servers' but blocking the reverse).
  - **Secure Egress:** All internal networks are granted internet access via a single NAT (Masquerade) rule on the WAN egress interface.

- **Dedicated Physical Management Access:** The router's `ether1` copper port is configured as a dedicated untagged 'access port'. It is bridged with the Management VLAN (`VLAN 10`), providing a reliable physical point of administration.

- **Automated IP Management:** Each VLAN is served by its own DHCP server instance running on the CCR, providing clients with appropriate IP configuration (address, gateway, DNS).


### Final structure

- Management laptop is connected to ether1 on the CCR.
- CCR is connected via sfpplus11 to sfpplus1 on CRS ( trunk ports )
- WAN is on CCRs sfpplus12

### Future VLAN assignment to ports on CRS
All commands below should be run on the CRS326  

1. **Assigning a `pvid` ( Port VLAN ID ) to physical interfaces.**
  For example if we wanted to add sfpplus5 to vlan 20, then we would run:

```rsc
/interface bridge port
set [find interface=sfp-sfpplus5] pvid=20
```
2. **Updating VLAN table**  
Now the table looks something like this:
```rsc
set [find vlan-ids=20] untagged=sfp-sfpplus3
```
Updating is done by inputting a whole new list:
```rsc
/interface bridge vlan
set [find vlan-ids=20] untagged=sfp-sfpplus3,sfp-sfpplus5
```
This will keep the sfp-sfpplus3 physical interface in the **virtual interface - Servers** and also add the sfp-sfpplus5 interface to it.
