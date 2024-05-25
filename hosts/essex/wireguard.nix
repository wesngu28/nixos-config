{
  config,
  lib,
  ...
}: let
in {
  age.secrets.essex_wg0.file = ../../secrets/essex_wg0.age;
  networking.firewall.allowedUDPPorts = [51820];

  # networking.wireguard.enable = true;
  networking.wg-quick.interfaces.wg0 = {
    autostart = true;
    configFile = config.age.secrets.essex_wg0.path;
  };
}
