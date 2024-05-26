{
  imports = [
    ./containers/containers.nix
    ./containers/media.nix
    ./containers/rss.nix
    ./containers/paperless.nix
    ./containers/photos.nix
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
