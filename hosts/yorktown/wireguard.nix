{
  config,
  lib,
  ...
}: let
in {
  age.secrets.yorktown_wg0.file = ../../secrets/yorktown_wg0.age;
  networking.firewall.allowedUDPPorts = [51820];

  networking.wg-quick.interfaces.wg0 = {
    autostart = true;
    configFile = config.age.secrets.yorktown_wg0.path;
  };
}
