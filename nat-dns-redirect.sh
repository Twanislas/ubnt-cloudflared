#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

# Redirect outgoing DNS packets and log them
configure

delete service nat rule 1000
delete service nat rule 1001
delete service nat rule 1002

set service nat rule 1000 description 'Redirect DNS request from MGMT to gateway'
set service nat rule 1000 type destination
set service nat rule 1000 protocol tcp_udp
set service nat rule 1000 destination port 53
set service nat rule 1000 destination address !10.0.255.254
set service nat rule 1000 inbound-interface eth1
set service nat rule 1000 inside-address address 10.0.255.254
set service nat rule 1000 log enable

set service nat rule 1001 description 'Redirect DNS request from LAN to gateway'
set service nat rule 1001 type destination
set service nat rule 1001 protocol tcp_udp
set service nat rule 1001 destination port 53
set service nat rule 1001 destination address !172.16.255.254
set service nat rule 1001 inbound-interface eth1.2
set service nat rule 1001 inside-address address 172.16.255.254
set service nat rule 1001 log enable

set service nat rule 1002 description 'Redirect DNS request from GUESTS to gateway'
set service nat rule 1002 type destination
set service nat rule 1002 protocol tcp_udp
set service nat rule 1002 destination port 53
set service nat rule 1002 destination address !192.168.0.254
set service nat rule 1002 inbound-interface eth1.3
set service nat rule 1002 inside-address address 192.168.0.254
set service nat rule 1002 log enable

commit
save
exit
