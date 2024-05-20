{
  config,
  lib,
  ...
}: let
in {
  age.secrets.enterprise_wg0.file = ../../secrets/enterprise_wg0.age;
  networking.firewall.allowedUDPPorts = [51820];

  # networking.wireguard.enable = true;
  networking.wg-quick.interfaces.wg0 = {
    configFile = config.age.secrets.enterprise_wg0.path;
  };
}
