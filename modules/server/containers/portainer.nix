{
  config,
  pkgs,
  ...
}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      portainer = {
        image = "portainer/portainer-ce:latest";
        autoStart = true;
        ports = ["9000:9000"];
        volumes = [
          "/home/serpe/docker/portainer:/data"
          "/var/run/docker.sock:/var/run/docker.sock"
        ];
      };
    };
  };
}
