{config, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "filebrowser" = {
        autoStart = true;
        image = "filebrowser/filebrowser";
        ports = ["8081:80"];
        volumes = [
          "/media:/srv/media"
          "/multimedia:/srv/multimedia"
          "/home/serpe/Obsidian:/srv/obsidian"
          # for quickly sharing files on computers I don't trust or have permissions
          "/home/serpe/localsend:/srv/quickshare"
          "/home/serpe/docker/filebrowser/filebrowser.db:/database.db"
        ];
      };
    };
  };
}
