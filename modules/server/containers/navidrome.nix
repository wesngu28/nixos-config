{config, ...}: {
  age.secrets.navidrome.file = ../../../secrets/navidrome.age;

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "navidrome" = {
        autoStart = true;
        image = "deluan/navidrome:latest";
        ports = ["4533:4533"];
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "America/Los_Angeles";
          ND_CONFIGFILE = "/data/navidrome.toml";
        };
        volumes = [
          "/home/serpe/docker/navidrome:/data"
          "${config.age.secrets.navidrome.path}:/data/navidrome.toml"
          "/multimedia/music:/music"
        ];
      };

      "picard" = {
        autoStart = true;
        image = "mikenye/picard:latest";
        ports = ["5900:5800"];
        volumes = [
          "/home/serpe/docker/picard:/config"
          "/multimedia/music:/storage:rw"
        ];
      };
    };
  };
}
