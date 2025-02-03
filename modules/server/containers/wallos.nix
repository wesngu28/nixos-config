{config, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "wallos" = {
        autoStart = true;
        image = "bellamy/wallos:latest";
        ports = ["8282:80"];
        volumes = [
          "/home/serpe/docker/wallos/db:/var/www/html/db"
          "/home/serpe/docker/wallos/logos:/var/www/html/images/uploads/logos"
        ];
      };
    };
  };
}
