umask 077
mkdir ~/wireguard-keys
wg genkey > ~/wireguard-keys/private
wg pubkey < ~/wireguard-keys/private > ~/wireguard-keys/public
# xclip -sel clip < ~/wireguard-keys/public
sudo chown root:root /home/serpe/wireguard-keys/private
sudo chmod 600 /home/serpe/wireguard-keys/private