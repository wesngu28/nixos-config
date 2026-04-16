{config, ...}: {
  age.secrets.gluetun.file = ../../../secrets/gluetun.age;

  virtualisation.oci-containers.containers."gluetun" = {
    image = "docker.io/qmcgaw/gluetun:latest";
    autoStart = true;
    ports = [
      "5555:5555"
      "5556:8081"
      "8080:8080"
      "9696:9696"
      "7878:7878"
      "8989:8989"
      "5800:5800"
    ];
    extraOptions = ["--cap-add=NET_ADMIN" "--device=/dev/net/tun:/dev/net/tun"];
    environmentFiles = [config.age.secrets.gluetun.path];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"
    ];
    # environment = {
    #  VPN_SERVICE_PROVIDER = "protonvpn";
    #  VPN_TYPE = "openvpn";
    #  SERVER_COUNTRIES = "Netherlands";
    #  OPENVPN_USER = "";
    #  OPENVPN_PASSWORD = "";
    #  VPN_PORT_FORWARDING = "on";
    # };
  };

  virtualisation.oci-containers.containers."qbittorrent" = {
    image = "docker.io/linuxserver/qbittorrent:latest";
    autoStart = true;
    dependsOn = ["gluetun"];
    extraOptions = [
      "--network=container:gluetun"
    ];
    environment = {
      PUID = "1000";
      PGID = "1000";
      WEBUI_PORT = "5555";
      TORRENTING_PORT = "6881";
    };
    volumes = [
      "./qbittorrent:/config"
      "/multimedia/torrents/downloads:/downloads"
      "/etc/localtime:/etc/localtime:ro"
    ];
  };
}
