{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      # "audiobookshelf" = {
      #   autoStart = true;
      #   image = "lscr.io/linuxserver/freshrss:latest";
      #   ports = ["7755:80"];
      #   volumes = [
      #     "/home/serpe/docker/freshrss:/config"
      #   ];
      #   environment = {
      #     PUID = "1000";
      #     PGID = "1000";
      #     TZ = "America/Phoenix";
      #   };
      #   extraOptions = [
      #     "--network=immich"
      #   ];
      # };

      # "calibre" = {
      #   autoStart = true;
      #   image = "lscr.io/linuxserver/freshrss:latest";
      #   ports = ["7755:80"];
      #   volumes = [
      #     "/home/serpe/docker/freshrss:/config"
      #   ];
      #   environment = {
      #     PUID = "1000";
      #     PGID = "1000";
      #     TZ = "America/Phoenix";
      #   };
      #   extraOptions = [
      #     "--network=immich"
      #   ];
      # };

      "diun" = {
        autoStart = true;
        image = "crazymax/diun:latest";
        volumes = [
          "/media/downloads:/output:rw"
          "/home/serpe/docker/diun:/data"
          "/home/serpe/docker/diun/diun.yml:/diun.yml:ro
        ];
      };

      "jdownloader2" = {
        autoStart = true;
        image = "jlesage/jdownloader-2";
        ports = ["5800:5800"];
        volumes = [
          "/media/downloads:/output:rw"
          "/home/serpe/docker/jdownloader:/config:rw"
        ];
      };

      "glances" = {
        autoStart = true;
        image = "nicolargo/glances:latest-full";
        ports = ["61208:61208"];
        volumes = [
          "/:/rootfs:ro"
          "/var/run/docker.sock:/var/run/docker.sock"
        ];
        environment = {
          GLANCES_OPT = "-w";
        };
      };

      # "kuma" = {
      #   autoStart = true;
      #   image = "lscr.io/linuxserver/freshrss:latest";
      #   ports = ["7755:80"];
      #   volumes = [
      #     "/home/serpe/docker/freshrss:/config"
      #   ];
      #   environment = {
      #     PUID = "1000";
      #     PGID = "1000";
      #     TZ = "America/Phoenix";
      #   };
      #   extraOptions = [
      #     "--network=immich"
      #   ];
      # };

      # eventually, but already in other server
      # "overleaf" = {
      #   autoStart = true;
      #   image = "lscr.io/linuxserver/freshrss:latest";
      #   ports = ["7755:80"];
      #   volumes = [
      #     "/home/serpe/docker/freshrss:/config"
      #   ];
      #   environment = {
      #     PUID = "1000";
      #     PGID = "1000";
      #     TZ = "America/Phoenix";
      #   };
      #   extraOptions = [
      #     "--network=immich"
      #   ];
      # };

      "navidrome" = {
        autoStart = true;
        image = "deluan/navidrome:latest";
        ports = ["4533:4533"];
        volumes = [
          "/home/serpe/docker/navidrome:/config"
          "/multimedia/music:/music"
        ];
      };

      "picard" = {
        autoStart = true;
        image = "mikenye/picard:latest";
        ports = ["5800:5800"];
        volumes = [
          "/home/serpe/docker/picard:/config"
          "/multimedia/music:/storage:rw"
        ];
      };

      "wallos" = {
        autoStart = true;
        image = "bellamy/wallos:latest";
        ports = ["8282:80"];
        volumes = [
          "/home/serpe/docker/wallos/db:/var/www/html/db"
          "/home/serpe/docker/wallos/logos:/var/www/html/images/uploads/logos"
        ];
      };
    };
  };
}
