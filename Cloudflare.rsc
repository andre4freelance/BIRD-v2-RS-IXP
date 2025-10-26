# 2025-10-12 13:56:30 by RouterOS 7.14.3
# software id = TWIQ-YM3K
#
/interface ethernet
set [ find default-name=ether1 ] comment=SW-CORE-1/1/5 disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
/routing bgp template
add address-families=ip as=13335 disabled=no multihop=no name=IXP-A \
    router-id=10.0.0.111 routing-table=main
/ip address
add address=1.1.1.1 interface=lo network=1.1.1.1
add address=10.0.0.111/24 interface=ether1 network=10.0.0.0
/ip firewall address-list
add address=1.1.1.1 list=ADV
/routing bgp connection
add address-families=ip as=13335 connect=yes disabled=no listen=yes \
    local.address=10.0.0.111 .role=ebgp multihop=no name=RS-IXP-A \
    output.keep-sent-attributes=no .network=ADV .remove-private-as=no \
    remote.address=10.0.0.100/32 .allowed-as="" .as=64520 router-id=\
    10.0.0.111 routing-table=main templates=IXP-A
/system identity
set name=Cloudflare