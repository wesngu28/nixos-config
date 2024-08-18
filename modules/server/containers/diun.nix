{config, ...}: {
  age.secrets.diun.file = ../../../secrets/diun.age;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "diun" = {
        autoStart = true;
        image = "crazymax/diun:latest";
        volumes = [
          "/home/serpe/docker/diun:/data"
          "${config.age.secrets.diun.path}:/diun.yml:ro"
          "/var/run/docker.sock:/var/run/docker.sock"
        ];
      };
    };
  };
}
