#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

# Stop cloudflared and remove files
sudo /etc/init.d/cloudflared stop
sudo /usr/local/bin/cloudflared service uninstall
sudo rm -rf /etc/cloudflared /usr/local/bin/cloudflared /config/scripts/post-config.d/cloudflared-setup.sh /var/log/cloudflared*

# Reset default DNS config
configure
delete service dns forwarding options
commit
save
exit
