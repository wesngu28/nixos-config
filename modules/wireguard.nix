{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.wireguard;
in
  with lib; {
    options = {
      services.wireguard = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = ''
            Enable wireguard
          '';
        };

        autostart = mkOption {
          default = true;
          type = with types; bool;
          description = ''
            Autostart wireguard
          '';
        };

        fallback = mkOption {
          default = false;
          type = with types; bool;
          description = ''
            Fallback dns
          '';
        };

        dnsFallbackServer = mkOption {
          default = "10.60.80.1";
          type = with types; str;
          description = ''
            The DNS server to use as fallback if the fallback option is enabled.
          '';
        };
      };
    };

    config = mkIf cfg.enable {
      age.secrets.wg.file = ../secrets/${config.networking.hostName}_wg0.age;
      networking.firewall.allowedUDPPorts = [51820];

      networking.wg-quick.interfaces.wg0 = {
        autostart = cfg.autostart;
        configFile = config.age.secrets.wg.path;
      };

      services.resolved = {
        enable = cfg.fallback;
        dnssec = "false";
        fallbackDns = [cfg.dnsFallbackServer];
        dnsovertls = "false";
      };
    };
  }
