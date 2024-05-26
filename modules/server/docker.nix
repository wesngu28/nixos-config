{
  imports = [
    ./server/containers/containers.nix
    ./server/containers/media.nix
    ./server/containers/rss.nix
    ./server/containers/paperless.nix
    ./server/containers/photos.nix
  ];

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      liveRestore = true;
    };
  };

  users.users.serpe.extraGroups = ["docker"];
}
