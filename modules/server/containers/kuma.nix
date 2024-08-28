{config, ...}: {
  virtualisation.oci-containers = {
    containers = {
      "kuma" = {
        autoStart = true;
        image = "louislam/uptime-kuma:1";
        ports = ["3001:3001"];
        volumes = [
          "/home/serpe/docker/kuma:/app/data"
        ];
      };
    };
  };
}
