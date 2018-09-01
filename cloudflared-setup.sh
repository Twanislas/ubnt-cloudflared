#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

# Pull files
mkdir -p /etc/cloudflared
if [ ! -f /etc/cloudflared/config.yml ] || [ "$1" = "pull" ]; then /usr/bin/curl -sf https://raw.githubusercontent.com/Twanislas/ubnt-cloudflared/master/config.yml --output /etc/cloudflared/config.yml; fi
if [ ! -f /usr/local/bin/cloudflared ] || [ "$1" = "pull" ]; then /usr/bin/curl -sf https://raw.githubusercontent.com/Twanislas/ubnt-cloudflared/master/cloudflared-$(uname -m) --output /usr/local/bin/cloudflared; fi
/bin/chmod +x /usr/local/bin/cloudflared
/usr/local/bin/cloudflared service install
/etc/init.d/cloudflared start

# Configure the system to use local DNS proxy
configure
delete service dns forwarding options
set service dns forwarding options "no-resolv"
set service dns forwarding options "server=127.0.0.1#5053"
commit
save
exit