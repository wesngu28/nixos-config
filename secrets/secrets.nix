let
  serpe = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGnjKj4EyU0zid0YX/Ggj+UiqQYYeVB5pKSsP/rtY1tU serpe";

  server_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4PclanQT+dFpvM9xFbJSNxJpIHZzZHkXbxgIMvX6YX root@nixos";
  users = [ serpe ];
in {
  "enterprise_wg0.age".publicKeys = [ serpe ];

  "feedcord.age".publicKeys = [ serpe server_host];

  "navidrome.age".publicKeys = [ serpe server_host];
}
