# BIRD 2.14 Route Server Internet Exchange Point
This documentation explains how an Linux Debian with BIRD 2.14 acting as a Route Server (RS) can simplify peering at an Internet Exchange Point (IXP).

---

## Topology

![Project topology](images/Topology.png)

---

## BIRD Configuration
There is step to configure Linux Debian with BIRD 2.14 as a Route Server

---

### 1. Configure interface IP address
Location: /etc/network/interfaces

```ini
auto eth0
iface eth0 inet static
    address 10.0.0.100
    netmask 255.255.255.0
```

Apply the change by bringing the interface down and up or restarting networking:

```bash
sudo ifdown eth0 && sudo ifup eth0
# or
sudo systemctl restart networking
```

---

### 2. Configure BIRD (BGP)
Location: /etc/bird/bird.conf

Edit the file with your preferred editor (nano, vi, etc.). After saving, check and apply the configuration:

```bash
# check syntax
sudo birdc configure check

# restart the BIRD service
sudo systemctl restart bird

# check service status
sudo systemctl status bird -l
```

Example expected output for a successful configuration check:

```
BIRD 2.14 ready.
Reading configuration from /etc/bird/bird.conf
Configuration OK
```

Verify BGP and routing state with:

```bash
sudo birdc show protocols
sudo birdc show route
sudo birdc show route all
sudo birdc show status
```

Ensure the configuration check reports "Configuration OK" and that `systemctl status bird` shows the service as active (running). If errors appear, re-open /etc/bird/bird.conf, fix them, then re-run the check and restart the service.

## BGP status
Include BGP status and routing tables from the RS and members.

![Project topology](images/BGP-Statuses.png)

---

## Member-4-MikroTik Test
![Project topology](images/Member-4-BGP-Status.png)

---

## Devices

- **RS**: FRR version 8.2.2 Debian Linux debian 6.5.0-5-cloud-amd64
- **Member-1-vMX**: vMX version 14.1R1.10
- **Member-2-NE40E**: NE40E version V800R011C00SPC607B607
- **Member-3-cisco**: Cisco IOS 3725 version 12.4
- **Member-4-MikroTik**: MikroTik RouterOS 7.14.3
- **Cloudflare**: MikroTik RouterOS 7.14.3

---

## Links

Origin : 
<https://github.com/andre4freelance/FRR-RS-IXP>

Linkedin post : 
<https://www.linkedin.com/posts/link-andre-bastian_frr-bgp-internetexchange-activity-7383177212331667456-tyBL?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD73JlUBty-p-mBfMEW0-O4j0sv-e_PRQvc>

Reference : 
<https://www.peeringtoolbox.net/ixp-route-server?utm_source=chatgpt.com>
<https://docs.soodar.ir/rel/21.11/user/routeserver.html>




