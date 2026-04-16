{pkgs, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "jellyfin" = {
        autoStart = true;
        image = "lscr.io/linuxserver/jellyfin:latest";
        ports = [
          "8096:8096"
          "8920:8920"
          "1900:1900"
          "7359:7359"
        ];
        volumes = [
          "/home/serpe/docker/jellyfin:/config"
          "/multimedia/jellyfin/movies:/data/movies"
          "/multimedia/jellyfin/tv:/data/tv"
          "/multimedia/music:/data/music"
          "/media:/data/unsorted"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Los_Angeles";
        };
        extraOptions = [
          "--device=/dev/dri/renderD128:/dev/dri/renderD128"
        ];
      };

      "sabnzbd" = {
        autoStart = true;
        image = "lscr.io/linuxserver/sabnzbd:latest";
        # ports = ["8080:8080"];
        volumes = [
          "/etc/localtime:/etc/localtime:ro"
          "/home/serpe/docker/arr/sabnzbd:/config"
          "/multimedia/jellyfin/usenet:/data/usenet"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Los_Angeles";
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
      };

      # "lidarr" = {
      #   autoStart = true;
      #   image = "youegraillot/lidarr-on-steroids";
      #   ports = ["8686:8686" "6595:6595"];
      #   volumes = [
      #     "/home/serpe/docker/arr/lidarr:/config"
      #     "/home/serpe/docker/arr/lidarr/deemix:/config_deemix"
      #     "/multimedia:/data"
      #   ];
      #   environment = {
      #     PUID = "1000";
      #     PGID = "1000";
      #     TZ = "America/Los_Angeles";
      #     AUTOCONFIG = "true";
      #     FLAC2CUSTOM_ARGS = "true";
      #   };
      #   extraOptions = [
      #     "--network=container:gluetun"
      #   ];
      # };

      "prowlarr" = {
        autoStart = true;
        image = "lscr.io/linuxserver/prowlarr:develop";
        # ports = ["9696:9696"];
        volumes = [
          "/home/serpe/docker/arr/prowlarr:/config"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Los_Angeles";
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
      };

      "radarr" = {
        autoStart = true;
        image = "lscr.io/linuxserver/radarr:latest";
        # ports = ["7878:7878"];
        volumes = [
          "/home/serpe/docker/arr/radarr:/config"
          "/multimedia/jellyfin:/data"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Los_Angeles";
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
      };

      "sonarr" = {
        autoStart = true;
        image = "lscr.io/linuxserver/sonarr:latest";
        # ports = ["8989:8989"];
        volumes = [
          "/home/serpe/docker/arr/sonarr:/config"
          "/multimedia/jellyfin:/data"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Los_Angeles";
        };
        extraOptions = [
          "--network=container:gluetun"
        ];
      };

      # "jellyseerr" = {
      #   autoStart = true;
      #   image = "fallenbagel/jellyseerr:latest";
      #   ports = ["5055:5055"];
      #   volumes = [
      #     "/home/serpe/docker/arr/jellyseer:/app/config"
      #   ];
      #   environment = {
      #     TZ = "America/Los_Angeles";
      #   };
      #   extraOptions = [
      #     "--network=container:gluetun"
      #   ];
      # };
    };
  };
}
