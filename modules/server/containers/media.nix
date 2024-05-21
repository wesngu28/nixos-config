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
          "/home/multimedia/movies:/data/movies"
          "/home/multimedia/tv:/data/tv"
          "/home/multimedia/music:/data/music"
          "/home/media:/data/unsorted"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Phoenix";
        };
        extraOptions = [
          "--network=arr"
        ];
      };

      "sabnzbd" = {
        autoStart = true;
        image = "lscr.io/linuxserver/sabnzbd:latest";
        ports = ["8080:8080"];
        volumes = [
          "/etc/localtime:/etc/localtime:ro"
          "/home/serpe/docker/arr/sabnzbd:/config"
          "/home/multimedia/usenet:/data/usenet"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Phoenix";
        };
        extraOptions = [
          "--network=arr"
        ];
      };

      "lidarr" = {
        autoStart = true;
        image = "youegraillot/lidarr-on-steroids";
        ports = ["8686:8686" "6595:6595"];
        volumes = [
          "/home/serpe/docker/arr/lidarr:/config"
          "/home/serpe/docker/arr/lidarr/deemix:/config_deemix"
          "/home/serpe/multimedia:/data"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Phoenix";
          AUTOCONFIG = "true";
          FLAC2CUSTOM_ARGS = "true";
        };
        extraOptions = [
          "--network=arr"
        ];
      };

      "prowlarr" = {
        autoStart = true;
        image = "lscr.io/linuxserver/prowlarr:develop";
        ports = ["9696:9696"];
        volumes = [
          "/home/serpe/docker/arr/prowlarr:/config"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Phoenix";
        };
        extraOptions = [
          "--network=arr"
        ];
      };

      "radarr" = {
        autoStart = true;
        image = "lscr.io/linuxserver/radarr:latest";
        ports = ["7878:7878"];
        volumes = [
          "/home/serpe/docker/arr/radarr:/config"
          "/home/serpe/multimedia:/data"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Phoenix";
        };
        extraOptions = [
          "--network=arr"
        ];
      };

      "sonarr" = {
        autoStart = true;
        image = "lscr.io/linuxserver/sonarr:latest";
        ports = ["8989:8989"];
        volumes = [
          "/home/serpe/docker/arr/sonarr:/config"
          "/home/serpe/multimedia:/data"
        ];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Phoenix";
        };
        extraOptions = [
          "--network=arr"
        ];
      };

      "jellyseerr" = {
        autoStart = true;
        image = "fallenbagel/jellyseerr:latest";
        ports = ["5055:5055"];
        volumes = [
          "/home/serpe/docker/arr/jellyseer:/app/config"
        ];
        environment = {
          TZ = "America/Phoenix";
        };
        extraOptions = [
          "--network=arr"
        ];
      };
    };
  };

  systemd.services.arr = {
    description = "Create the network bridge for arr.";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    before = [
      "docker-jellyfin.service"
      "docker-sabnzbd.service"
      "docker-lidarr.service"
      "docker-prowlarr.service"
      "docker-radarr.service"
      "docker-sonarr.service"
      "docker-jellyseerr.service"
    ];
    serviceConfig.Type = "oneshot";
    script = ''
      check=$(${pkgs.docker}/bin/docker network ls | grep "arr" || true)
      if [ -z "$check" ];
        then ${pkgs.docker}/bin/docker network create arr
        else echo "arr already exists in docker"
      fi
    '';
  };
}
