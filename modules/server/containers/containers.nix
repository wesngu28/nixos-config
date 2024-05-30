{config, ...}: {
  age.secrets.navidrome.file = ../../../secrets/navidrome.age;
  age.secrets.diun.file = ../../../secrets/diun.age;

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
          "/home/serpe/docker/diun:/data"
          "${config.age.secrets.diun.path}:/diun.yml:ro"
          "/var/run/docker.sock:/var/run/docker.sock"
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

      "navidrome" = {
        autoStart = true;
        image = "deluan/navidrome:latest";
        ports = ["4533:4533"];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Phoenix";
          ND_CONFIGFILE = "/data/navidrome.toml";
        };
        volumes = [
          "/home/serpe/docker/navidrome:/data"
          "${config.age.secrets.navidrome.path}:/data/navidrome.toml"
          "/multimedia/music:/music"
        ];
      };

      # portainer = {
      #   image = "portainer/portainer-ce:latest";
      #   autoStart = true;
      #   ports = ["9443:9443"];
      #   volumes = [
      #     "/home/serpe/docker/portainer:/data"
      #     "/var/run/docker.sock:/var/run/docker.sock"
      #   ];
      # };

      "picard" = {
        autoStart = true;
        image = "mikenye/picard:latest";
        ports = ["5900:5800"];
        volumes = [
          "/home/serpe/docker/picard:/config"
          "/multimedia/music:/storage:rw"
        ];
      };
    };
  };
}
