{config, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "jdownloader2" = {
        autoStart = true;
        image = "jlesage/jdownloader-2";
        ports = ["5800:5800"];
        volumes = [
          "/media/downloads:/output:rw"
          "/home/serpe/docker/jdownloader:/config:rw"
        ];
      };
    };
  };
}
