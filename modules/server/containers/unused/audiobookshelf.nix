{
  config,
  pkgs,
  ...
}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "audiobookshelf" = {
        autoStart = true;
        image = "lscr.io/linuxserver/freshrss:latest";
        ports = ["7755:80"];
        volumes = [
          "/home/serpe/docker/freshrss:/config"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Phoenix";
        };
        extraOptions = [
          "--network=immich"
        ];
      };
    };
  };
}
