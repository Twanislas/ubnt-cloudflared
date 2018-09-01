#!/bin/vbash
set -e

echo "Installing cloudflared"
sudo rm -f /config/scripts/post-config.d/cloudflared-setup.sh
sudo /usr/bin/curl -sf https://raw.githubusercontent.com/Twanislas/ubnt-cloudflared/master/cloudflared-setup.sh --output /config/scripts/post-config.d/cloudflared-setup.sh
sudo /bin/chmod +x /config/scripts/post-config.d/cloudflared-setup.sh
sudo /config/scripts/post-config.d/cloudflared-setup.sh pull
