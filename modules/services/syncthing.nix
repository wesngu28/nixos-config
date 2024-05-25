{
  services.syncthing = {
    enable = true;
    user = "serpe";
    dataDir = "/home/serpe";
    configDir = "/home/serpe/.config/syncthing";

    settings = {
      devices = {
        "essex" = {id = "UQZ5FX5-Y5BYQJU-PVSUYFI-V3F2JK3-RHPYDIN-26TILM5-L4FMTOB-ATEHPQ7";};
        "vanguard" = {id = "NGOSQ5C-V2WZO5D-VOTUULM-63NUIWR-NEQTCHZ-EP4BASI-FUW2K5Z-C6EWBQX";};
      };

      folders = {
        "Obsidian" = {
          enable = true;
          id = "stutq-qr54k";
          path = "/home/serpe/Obsidian";
          devices = ["essex" "vanguard"];
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [22000];
  networking.firewall.allowedUDPPorts = [22000 21027];
}
