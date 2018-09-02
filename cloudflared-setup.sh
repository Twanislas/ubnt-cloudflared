#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

# Pull files
mkdir -p /etc/cloudflared
if [ ! -f /etc/cloudflared/config.yml ] || [ "$1" = "pull" ]; then
	rm -f /etc/cloudflared/config.yml
	/usr/bin/curl -sf https://raw.githubusercontent.com/Twanislas/ubnt-cloudflared/master/config.yml --output /etc/cloudflared/config.yml
fi
if [ ! -f /usr/local/bin/cloudflared ] || [ "$1" = "pull" ]; then
	rm -f /usr/local/bin/cloudflared
	sudo /usr/bin/curl -sf https://raw.githubusercontent.com/Twanislas/ubnt-cloudflared/master/cloudflared --output /usr/local/bin/cloudflared
fi
/bin/chmod +x /usr/local/bin/cloudflared
/usr/local/bin/cloudflared service install
/etc/init.d/cloudflared restart

# System config 
configure

# Use local DNS proxy
delete service dns forwarding options
set service dns forwarding options "no-resolv"
set service dns forwarding options "server=127.0.0.1#5053"
delete system name-server
set system name-server 127.0.0.1
set interfaces ethernet eth0 dhcpv6-pd no-dns

# Block outgoing DNS packets and log them
delete firewall name WAN_OUT rule 1000
delete firewall ipv6-name WANv6_OUT rule 1000

set firewall name WAN_OUT rule 1000 action drop
set firewall name WAN_OUT rule 1000 description "Block all outgoing DNS requests on WAN_OUT"
set firewall name WAN_OUT rule 1000 protocol tcp_udp
set firewall name WAN_OUT rule 1000 destination port 53
set firewall name WAN_OUT rule 1000 log enable

set firewall ipv6-name WANv6_OUT rule 1000 action drop
set firewall ipv6-name WANv6_OUT rule 1000 description "Block all outgoing DNS requests on WANv6_OUT"
set firewall ipv6-name WANv6_OUT rule 1000 protocol tcp_udp
set firewall ipv6-name WANv6_OUT rule 1000 destination port 53
set firewall ipv6-name WANv6_OUT rule 1000 log enable

commit
save
exit
