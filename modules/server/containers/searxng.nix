{pkgs, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      searxng = {
        image = "docker.io/searxng/searxng:latest";
        volumes = [
          "/home/serpe/docker/searxng:/etc/searxng:rw"
        ];
        environment = {
          INSTANCE_NAME = "Search";
          SEARXNG_BASE_URL = "https://search.az/";
        };
        ports = [
          "8090:8080"
        ];
      };
    };
  };
}
