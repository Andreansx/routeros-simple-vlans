# routeros-simple-vlans
RouterOS scenario including a switch, a router, masquerading and vlans
```rsc
/interface vlan
add name=vlan10-mgmt interface=br-lan vlan-id=10
add name=vlan20-servers interface=br-lan vlan-id=20
add name=vlan30-users interface=br-lan vlan-id=30
```
