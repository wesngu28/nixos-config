{config, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
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
    };
  };
}
