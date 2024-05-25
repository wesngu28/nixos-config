let
  serpe = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGnjKj4EyU0zid0YX/Ggj+UiqQYYeVB5pKSsP/rtY1tU serpe";

  enterprise = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINP6MuSG9PyahzRDLQl9PsnYGTh7eG7rFFSwxvElt6hh enterprise";
  essex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICndZpZLTgVmzQ99t7Gh4R1qeDcY15EivdPsyEYtt/La essex";

  enterprise_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAYyHNZ9+1Rm3WfqfHszDPZ2UHNCw6BduNGoKkES9OFK root@serpe";
  server_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4PclanQT+dFpvM9xFbJSNxJpIHZzZHkXbxgIMvX6YX root@nixos";

  users = [serpe enterprise];
  systems = [enterprise server_host];
in {
  "enterprise_wg0.age".publicKeys = [enterprise enterprise_host];
  "essex_wg0.age".publicKeys = [essex server_host];

  "feedcord.age".publicKeys = [serpe server_host];

  "navidrome.age".publicKeys = [serpe server_host];
}
