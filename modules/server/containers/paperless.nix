{pkgs, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "broker" = {
        autoStart = false;
        image = "docker.io/library/redis:7";
        volumes = [
          "redisdata:/data"
        ];
        extraOptions = [
          "--network=paperless"
        ];
      };

      "paperlessdb" = {
        autoStart = false;
        image = "docker.io/library/postgres:15";
        volumes = [
          "pgdata:/var/lib/postgresql/data"
        ];
        environment = {
          POSTGRES_DB = "paperless";
          POSTGRES_USER = "paperless";
          POSTGRES_PASSWORD = "paperless";
        };
        extraOptions = [
          "--network=paperless"
        ];
      };

      "webserver" = {
        autoStart = false;
        image = "ghcr.io/paperless-ngx/paperless-ngx:latest";
        ports = ["8888:8000"];
        volumes = [
          "data:/usr/src/paperless/data"
          "media:/usr/src/paperless/media"
          "/home/serpe/docker/paperless/export:/usr/src/paperless/export"
          "/srv/paperless:/usr/src/paperless/consume"
        ];
        environment = {
          PAPERLESS_REDIS = "redis://broker:6379";
          PAPERLESS_DBHOST = "paperlessdb";
          PAPERLESS_DBPASS = "paperless";
          PAPERLESS_TIKA_ENABLED = "1";
          PAPERLESS_TIKA_GOTENBERG_ENDPOINT = "http://gotenberg:3000";
          PAPERLESS_TIKA_ENDPOINT = "http://tika:9998";
          PAPERLESS_URL = "https://paperless.az";
        };
        extraOptions = [
          "--network=paperless"
        ];
      };

      "gotenberg" = {
        autoStart = false;
        image = "docker.io/gotenberg/gotenberg:7.10";
        cmd = ["gotenberg" "--chromium-disable-javascript=true" "--chromium-allow-list=file:///tmp/.*"];
        extraOptions = [
          "--network=paperless"
        ];
      };

      "tika" = {
        autoStart = false;
        image = "ghcr.io/paperless-ngx/tika:latest";
        extraOptions = [
          "--network=paperless"
        ];
      };
    };
  };

  systemd.services.paperless = {
    description = "Create the network bridge for paperless.";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    before = [
      "docker-broker.service"
      "docker-paperlessdb.service"
      "docker-webserver.service"
      "docker-gotenberg.service"
      "docker-tika.service"
    ];
    serviceConfig.Type = "oneshot";
    script = ''
      check=$(${pkgs.docker}/bin/docker network ls | grep "paperless" || true)
      if [ -z "$check" ];
        then ${pkgs.docker}/bin/docker network create paperless
        else echo "paperless already exists in docker"
      fi
    '';
  };
}
