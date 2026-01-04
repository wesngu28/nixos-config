{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.agenix.packages."${pkgs.stdenv.hostPlatform.system}".default
    veracrypt
    lazydocker
  ];

  networking.nameservers = ["10.60.80.1"];

  services = {
    syncthing = {
      enable = true;
      user = "serpe";
      guiAddress = "0.0.0.0:8384";
      dataDir = "/home/serpe/syncthing"; # Default folder for new synced folders
      configDir = "/home/serpe/syncthing/.config/syncthing"; # Folder for Syncthing's settings and keys
      settings = {
        devices = {
          "enterprise" = {id = "Y76QR6O-DKWWEZ2-EZ6SRA7-742BY7V-EPCEAII-VJC7BH4-EZS7TS5-IQ32UQZ";};
          "vanguard" = {id = "NGOSQ5C-V2WZO5D-VOTUULM-63NUIWR-NEQTCHZ-EP4BASI-FUW2K5Z-C6EWBQX";};
          "phone" = {id = "QAPBSUG-KLJGCI3-YEH25BA-DVDVDO3-7UT2PZW-AFTROMT-JMYPU6A-VD5ZRAT";};
        };

        folders = {
          "Obsidian" = {
            enable = true;
            id = "stutq-qr54k";
            path = "/home/serpe/Obsidian";
            devices = ["enterprise" "vanguard"];
          };

          "DCIM S23" = {
            enable = true;
            id = "6r1mb-lnzci";
            path = "/home/serpe/Camera Roll";
            devices = ["phone" "vanguard"];
          };

          "Music" = {
            enable = true;
            id = "2zqzg-2cq3z";
            path = "/multimedia/music";
            devices = ["enterprise" "vanguard" "phone"];
          };
        };
      };
    };
  };
}
