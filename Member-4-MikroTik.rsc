# 2025-10-12 13:57:10 by RouterOS 7.14.3
# software id = TWIQ-YM3K
#
/interface ethernet
set [ find default-name=ether1 ] comment=SW-CORE-1/1/4 disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
set [ find default-name=ether5 ] disable-running-check=no
/routing bgp template
add address-families=ip as=64524 disabled=no multihop=no name=IXP-A \
    router-id=10.0.0.4 routing-table=main
/ip address
add address=10.0.0.4/24 interface=ether1 network=10.0.0.0
add address=10.40.40.40 interface=lo network=10.40.40.40
/ip firewall address-list
add address=10.40.40.40 list=ADV
/routing bgp connection
add address-families=ip as=64524 connect=yes disabled=no listen=yes \
    local.address=10.0.0.4 .role=ebgp multihop=no name=RS-IXP-A \
    output.filter-select="" .keep-sent-attributes=no .network=ADV \
    .redistribute="" .remove-private-as=no remote.address=10.0.0.100/32 \
    .allowed-as="" .as=64520 router-id=10.0.0.4 routing-table=main templates=\
    IXP-A
/system identity
set name=Member-4-MikroTik