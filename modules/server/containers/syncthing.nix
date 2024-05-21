{
  virtualisation.oci-containers = {
    backend = "docker"; # Ensure Docker backend is used
    containers = {
      "syncthing" = {
        autoStart = true;
        image = "lscr.io/linuxserver/syncthing:latest";
        ports = [
          "8384:8384"
          "22000:22000/tcp"
          "22000:20000/udp"
          "21027:21027/udp"
        ];
        volumes = [
          "/home/serpe/docker/syncthing:/config"
          "/home/serpe/multimedia/camera:/cameraroll"
          "/home/serpe/multimedia/music:/music"
          "/home/serpe/multimedia/notes:/obsidian"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Phoenix";
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [22000];
  networking.firewall.allowedUDPPorts = [22000 21027];
}
