{
  networking.firewall.allowedUDPPorts = [51820];

  # networking.wireguard.enable = true;

  networking.wg-quick.interfaces.wg0 = {
    address = [""];
    autostart = false;
    dns = [""];
    privateKeyFile = "/home/serpe/wireguard-keys/private";

    peers = [
      {
        publicKey = "";

        allowedIPs = [""];

        endpoint = ":51820";

        persistentKeepalive = 25;
      }
    ];
  };
}
