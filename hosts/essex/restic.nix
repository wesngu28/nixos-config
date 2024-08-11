{ config, pkgs, ...}: {
  age.secrets.restic.file = ../../secrets/restic.age;

  environment.systemPackages = with pkgs; [
    restic
  ];

  services.restic.backups = {
    lan = {
      initialize = true;
      passwordFile = config.age.secrets.restic.path;
      repository = "sftp:serpe@:/mnt/d/music-backup";

      paths = [" /multimedia/music/Geller "];

      timerConfig = {
        onCalendar = "saturday 23:00";
      };

      pruneOpts = [
        "--keep-last 3"
      ];
    };
  };
}
