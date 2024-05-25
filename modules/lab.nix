{pkgs, ...}: {
  imports = [
    ./server/docker.nix
    ./server/containers/containers.nix
    ./server/containers/media.nix
    ./server/containers/rss.nix
    ./server/containers/paperless.nix
    ./server/samba.nix
  ];
  environment.systemPackages = with pkgs; [
    veracrypt
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
          "enterprise" = {id = "AWUD5GO-JGYJC7N-CQ7PMXK-V4CMBH3-HYYI6JY-257LJTX-4FJ6FBJ-D7ZTUQA";};
          "vanguard" = {id = "NGOSQ5C-V2WZO5D-VOTUULM-63NUIWR-NEQTCHZ-EP4BASI-FUW2K5Z-C6EWBQX";};
          "phone" = {id = "QAPBSUG-KLJGCI3-YEH25BA-DVDVDO3-7UT2PZW-AFTROMT-JMYPU6A-VD5ZRAT";};
        };

        folders = {
          "Obsidian" = {
            enable = true;
            id = "stutq-qr54k";
            path = "/home/serpe/Obsidian";
            devices = ["enterprise" "vanguard"] ;
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
            devices = ["vanguard"];
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [8384 22000];
  networking.firewall.allowedUDPPorts = [22000 21027];
}
