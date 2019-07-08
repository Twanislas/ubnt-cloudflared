#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

# Stop cloudflared and remove files
sudo /etc/init.d/cloudflared stop
sudo /opt/cloudflared/cloudflared service uninstall
sudo rm -rf /etc/cloudflared /opt/cloudflared /config/scripts/post-config.d/cloudflared-setup.sh /var/log/cloudflared*

# Reset default DNS config
configure
delete service dns forwarding options
delete system name-server
set system name-server 1.1.1.1
set system name-server 1.0.0.1
delete firewall name WAN_OUT rule 1000
commit
save
exit

echo "Do not forget to remove any custom NAT DNS redirections you made !"
