{config, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "linkding" = {
        autoStart = true;
        image = "sissbruecker/linkding:latest";
        ports = ["9090:9090"];
        volumes = [
          "/home/serpe/docker/linkding:/etc/linkding/data"
        ];
      };
    };
  };
}
