# routeros-simple-vlans
RouterOS scenario including a switch, a router, masquerading and vlans
```rsc
/interface vlan
add name=vlan10-mgmt interface=br-lan vlan-id=10
add name=vlan20-servers interface=br-lan vlan-id=20
add name=vlan30-users interface=br-lan vlan-id=30

/ip address> add address=10.10.10.1/24 interface=vlan10-mgmt comment="gateway for mgmt"
[admin@ccr] /ip address> add address=10.10.20.1/24 interface=vlan20-servers comment="gateway for servers"
[admin@ccr] /ip address> add address=10.10.30.1/24 interface=vlan30-users comment="gateway for users"
[admin@ccr] /ip address> ..
[admin@ccr] /ip> pool
[admin@ccr] /ip pool> add name=mgmt-pool ranges=10.10.10.100-10.10.10.200
[admin@ccr] /ip pool> add name=servers-pool 
comment  copy-from  next-pool  ranges
[admin@ccr] /ip pool> add name=servers-pool ranges=10.10.20.100-10.10.20.200
[admin@ccr] /ip pool> add name=users-pool ranges=10.10.30.100-10.10.30.200

/ip dhcp-server> add name=dhcp-mgmt interface=vlan10-mgmt address-pool=mgmt-pool disabled=no
[admin@ccr] /ip dhcp-server> add name=dhcp-servers interface=vlan20-servers address-pool=servers-pool disabled=no
[admin@ccr] /ip dhcp-server> add name=dhcp-users interface=vlan30-users address-pool=users-pool disabled=no
[admin@ccr] /ip dhcp-server> network 
[admin@ccr] /ip dhcp-server network> add address=10.10.10.0/24 gateway=10.10.10.1 dns-server=1.1.1.1,8.8.8.8
[admin@ccr] /ip dhcp-server network> add address=10.10.20.0/24 gateway=10.10.20.1 dns-server=1.1.1.1,8.8.8.8
[admin@ccr] /ip dhcp-server network> add address=10.10.30.0/24 gateway=10.10.30.1 dns-server=1.1.1.1,8.8.8.8
```
