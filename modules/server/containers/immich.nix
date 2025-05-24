{
  config,
  pkgs,
  ...
}: let
  immichVersion = "release";
  UPLOAD_LOCATION = "./library";
  DB_DATA_LOCATION = "./postgres";
  library = "/home/serpe/Camera Roll";
in {
  age.secrets.immich.file =
    ../../../secrets/immich.age;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "immich_server" = {
        autoStart = true;
        image = "ghcr.io/immich-app/immich-server:${immichVersion}";
        volumes = [
          "${UPLOAD_LOCATION}:/usr/src/app/upload"
          "/home/serpe/Camera Roll:/mnt/media/camera:ro"
          "/etc/localtime:/etc/localtime:ro"
        ];
        ports = ["2283:2283"];
        dependsOn = [
          "immich_redis"
          "immich_postgres"
        ];
        environmentFiles = [config.age.secrets.immich.path];
        extraOptions = [
          "--network=immich"
        ];
      };

      immich_redis = {
        image = "docker.io/valkey/valkey:8-bookworm@sha256:ff21bc0f8194dc9c105b769aeabf9585fea6a8ed649c0781caeac5cb3c247884";
        extraOptions = [
          "--network=immich"
        ];
      };

      immich_postgres = {
        image = "ghcr.io/immich-app/postgres:14-vectorchord0.3.0-pgvectors0.2.0";
        environment = {
          POSTGRES_INITDB_ARGS = "--data-checksums";
        };
        environmentFiles = [config.age.secrets.immich.path];
        volumes = ["immichdata:/var/lib/postgresql/data"];
        extraOptions = [
          "--network=immich"
        ];
      };
    };
  };

  systemd.services.immich = {
    description = "Create the network bridge for immich.";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    before = [
      "docker-immich_server.service"
      "docker-immich_redis.service"
      "docker-immich_postgres.service"
    ];
    serviceConfig.Type = "oneshot";
    script = ''
      check=$(${pkgs.docker}/bin/docker network ls | grep "immich" || true)
      if [ -z "$check" ];
        then ${pkgs.docker}/bin/docker network create immich
        else echo "immich already exists in docker"
      fi
    '';
  };
}
