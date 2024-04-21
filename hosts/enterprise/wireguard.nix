{
  networking.firewall.allowedUDPPorts = [51820];

  networking.wireguard.enable = true;

  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["{}/24"];
      listenPort = 51820;

      privateKeyFile = "/home/serpe/wireguard-keys/private";

      peers = [
        {
          publicKey = "{}";

          allowedIPs = ["{}" "{}"];

          endpoint = "{}:51820";

          persistentKeepalive = 25;
        }
      ];
    };
  };
}
