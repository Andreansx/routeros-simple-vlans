# jun/23/2025 22:53:21 by RouterOS 6.49.18
# software id = 91XQ-9UAD
#
# model = CCR2004-1G-12S+2XS
# serial number = ---
/interface bridge
add name=br-lan
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=lan-pool ranges=10.10.0.2-10.10.0.254
/ip dhcp-server
add address-pool=lan-pool disabled=no interface=br-lan name=lan-dhcp
/interface bridge port
add bridge=br-lan comment=br-lan-ether1 interface=ether1
/ip address
add address=10.0.0.150/24 comment=WAN interface=sfp-sfpplus12 network=\
    10.0.0.0
add address=10.10.0.1/24 comment=LAN-br interface=br-lan network=10.10.0.0
/ip dhcp-server network
add address=10.10.0.0/24 dns-server=1.1.1.1,8.8.8.8 gateway=10.10.0.1
/ip dns
set servers=1.1.1.1,8.8.8.8
/ip firewall filter
add action=drop chain=input in-interface=sfp-sfpplus12 port=22 protocol=\
    tcp
add action=accept chain=input connection-state=established,related
add action=accept chain=input src-address=10.10.0.0/24
add action=accept chain=input protocol=icmp
add action=drop chain=input in-interface=sfp-sfpplus12
/ip firewall nat
add action=masquerade chain=srcnat out-interface=sfp-sfpplus12
/ip route
add distance=1 gateway=10.0.0.1
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh address=10.10.0.0/24
set api disabled=yes
set winbox address=10.10.0.0/24
/system clock
set time-zone-name=Europe/Warsaw
/system identity
set name=ccr
