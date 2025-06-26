# 2025-06-26 17:26:06 by RouterOS 7.16.2
# software id = N85J-2N9M
#
# model = CRS326-24S+2Q+
# serial number = HGB09MRF1PQ
/interface bridge
add admin-mac=D4:01:C3:75:18:94 auto-mac=no comment=defconf name=bridgeLocal vlan-filtering=yes
/interface ethernet
set [ find default-name=sfp-sfpplus1 ] auto-negotiation=no
set [ find default-name=sfp-sfpplus4 ] auto-negotiation=no
/interface vlan
add interface=bridgeLocal name=vlan10-mgmt vlan-id=10
/interface bonding
add mode=802.3ad name=bond-trunk slaves=sfp-sfpplus1,sfp-sfpplus2 transmit-hash-policy=layer-2-and-3
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/port
set 0 name=serial0
/interface bridge port
add bridge=bridgeLocal comment=defconf interface=ether1 pvid=10
add bridge=bridgeLocal comment=defconf interface=qsfpplus1-1
add bridge=bridgeLocal comment=defconf interface=qsfpplus1-2
add bridge=bridgeLocal comment=defconf interface=qsfpplus1-3
add bridge=bridgeLocal comment=defconf interface=qsfpplus1-4
add bridge=bridgeLocal comment=defconf interface=qsfpplus2-1
add bridge=bridgeLocal comment=defconf interface=qsfpplus2-2
add bridge=bridgeLocal comment=defconf interface=qsfpplus2-3
add bridge=bridgeLocal comment=defconf interface=qsfpplus2-4
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus3 pvid=30
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus5
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus6
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus7
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus8
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus9
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus10
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus11
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus12
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus13
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus14
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus15
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus16
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus17
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus18
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus19
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus20
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus21
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus22
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus23
add bridge=bridgeLocal comment=defconf interface=sfp-sfpplus24 pvid=10
add bridge=bridgeLocal comment="trunk LACP to CCR" interface=bond-trunk
add bridge=bridgeLocal interface=sfp-sfpplus4
/interface bridge vlan
add bridge=bridgeLocal tagged=bond-trunk untagged=sfp-sfpplus4 vlan-ids=20
add bridge=bridgeLocal tagged=bridgeLocal,bond-trunk untagged=sfp-sfpplus24,ether1 vlan-ids=10
add bridge=bridgeLocal tagged=bond-trunk untagged=sfp-sfpplus3 vlan-ids=30
/ip address
add address=10.10.10.2/24 interface=vlan10-mgmt network=10.10.10.0
/ip dns
set servers=1.1.1.1,8.8.8.8
/ip route
add gateway=10.10.10.1
/system clock
set time-zone-name=Europe/Warsaw
/system note
set show-at-login=no
/system routerboard settings
set enter-setup-on=delete-key
/system swos
set address-acquisition-mode=static identity=SW_CORE_02 static-ip-address=10.10.20.13
