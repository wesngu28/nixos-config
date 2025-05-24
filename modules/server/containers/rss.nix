{
  config,
  pkgs,
  ...
}: {
  age.secrets.feedcord.file = ../../../secrets/feedcord.age;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "freshrss" = {
        autoStart = true;
        image = "lscr.io/linuxserver/freshrss:latest";
        ports = ["7755:80"];
        volumes = [
          "/home/serpe/docker/freshrss/data:/config"
          "/home/serpe/docker/freshrss/extensions:/config/www/freshrss/extensions"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Phoenix";
        };
      };

      # "fullfeedrss" = {
      #   autoStart = true;
      #   image = "heussd/fivefilters-full-text-rss:latest";
      #   volumes = [
      #     "rss-cache:/var/www/html/cache"
      #   ];
      #   ports = ["7756:80"];
      #   environment = {
      #     FTR_ADMIN_PASSWORD = "s";
      #   };
      #   extraOptions = [
      #     "--network=rss"
      #   ];
      # };

      "feedcord" = {
        autoStart = true;
        image = "qolors/feedcord:latest";
        volumes = [
          "${config.age.secrets.feedcord.path}:/app/config/appsettings.json"
        ];
        environment = {
          FTR_ADMIN_PASSWORD = "s";
        };
      };
    };
  };

  # systemd.services.rss = {
  #   description = "Create the network bridge for rss.";
  #   after = ["network.target"];
  #   wantedBy = ["multi-user.target"];
  #   before = [
  #     "docker-freshrss.service"
  #     "docker-fullfeedrss.service"
  #   ];
  #   serviceConfig.Type = "oneshot";
  #   script = ''
  #     check=$(${pkgs.docker}/bin/docker network ls | grep "rss" || true)
  #     if [ -z "$check" ];
  #       then ${pkgs.docker}/bin/docker network create rss
  #       else echo "rss already exists in docker"
  #     fi
  #   '';
  # };
}
