# ubnt-cloudflared
Install Cloudflare's DNS proxy on UniFi® gateways. This setup will survive reboots and re-provisions.

Only working for IPv4 at the moment.

Increase privacy on your network and prevent your ISP to eavesdrop your DNS requests to build your internet browsing history !

## Hardware
### Tested
* UniFi Security Gateway 3P

### Should work on (but not tested)
* All EdgeRouter models
* All UniFi Security Gateway models

## Guide
### Installing
In a ssh session run the following command :
```sh
bash <(curl -s https://raw.githubusercontent.com/Twanislas/ubnt-cloudflared/master/install.sh)
```

### Updating
Just run the install script again ;)

### Uninstall
In a ssh session run the following command :
```sh
bash <(curl -s https://raw.githubusercontent.com/Twanislas/ubnt-cloudflared/master/uninstall.sh)
```

### Redirecting NAT DNS requests
See the example in `nat-dns-redirect.sh`. You will have to adapt to your configuration and networks and place this script in `/config/scripts/post-config.d/` on the gateway so it will be run on every provision.

## Contributing
* Please fork and submit PR's if you have any improvements.
	* Implementing IPv6 features would help greatly
* Feel free to submit issues !
* Testing this on hardware I did not test yet would be wonderful !

## Credits
* https://bendews.com/posts/implement-dns-over-https/
* https://developers.cloudflare.com/1.1.1.1/dns-over-https/cloudflared-proxy/
* https://github.com/yon2004/ubnt_cloudflared
* https://community.ubnt.com/t5/UniFi-Routing-Switching/Scripts-on-USG/td-p/1402210
* https://community.ubnt.com/t5/UniFi-Routing-Switching/Deploying-USG-scripts-through-controller/td-p/2140097
