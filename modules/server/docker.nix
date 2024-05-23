{
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      liveRestore = true;
    };
  };

  users.users.serpe.extraGroups = ["docker"];
}
