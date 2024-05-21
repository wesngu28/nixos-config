{
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      liveRestore = true;
      daemon.settings = {
        default-address-pools = [
          {
            base = "172.17.0.0/12";
            size = 20;
          }
        ];
        ip = "127.0.0.1";
      };
    };
  };

  users.users.serpe.extraGroups = ["docker"];
}
