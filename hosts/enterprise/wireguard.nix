{
  config,
  lib,
  ...
}: let
in {
  age.secrets.enterprise_wg0.file = ../../secrets/enterprise_wg0.age;
  networking.firewall.allowedUDPPorts = [51820];

  networking.wg-quick.interfaces.wg0 = {
    autostart = false;
    configFile = config.age.secrets.enterprise_wg0.path;
  };

  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = ["~.az"];
    fallbackDns = ["10.60.80.1"];
    dnsovertls = "false";
  };
}
