{pkgs, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "photoviewdb" = {
        autoStart = true;
        image = "mariadb:10.5";
        volumes = [
          "/home/serpe/docker/photoview/db:/var/lib/mysql"
        ];
        environment = {
          MYSQL_DATABASE = "photoview";
          MYSQL_USER = "photoview";
          MYSQL_PASSWORD = "photosecret";
          MYSQL_RANDOM_ROOT_PASSWORD = "1";
        };
        extraOptions = [
          "--network=photoview"
        ];
      };

      "photoview" = {
        autoStart = true;
        image = "viktorstrate/photoview:2";
        ports = ["1941:80"];
        volumes = [
          "/home/wesley/cameraroll:/photos:ro"
        ];
        environment = {
          PHOTOVIEW_DATABASE_DRIVER = "mysql";
          PHOTOVIEW_MYSQL_URL = "photoview:photosecret@tcp(db)/photoview";
          PHOTOVIEW_LISTEN_IP = "photoview";
          PHOTOVIEW_LISTEN_PORT = "80";
          PHOTOVIEW_MEDIA_CACHE = "/app/cache";
        };
        extraOptions = [
          "--network=photoview"
        ];
      };
    };
  };

  systemd.services.photoview = {
    description = "Create the network bridge for photoview.";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    before = [
      "docker-photoviewdb.service"
      "docker-photoview.service"
    ];
    serviceConfig.Type = "oneshot";
    script = ''
      check=$(${pkgs.docker}/bin/docker network ls | grep "photoview" || true)
      if [ -z "$check" ];
        then ${pkgs.docker}/bin/docker network create photoview
        else echo "photoview already exists in docker"
      fi
    '';
  };
}
