let
  serpe = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGnjKj4EyU0zid0YX/Ggj+UiqQYYeVB5pKSsP/rtY1tU serpe";

  enterprise = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAQNYNQpaAAOLK6L1wtANcg6x/z4WkAJV+G7WOYg/Ey7 enterprise";
  essex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBq2aQcXDlZzkvebF7ZVo9fI5ThLGT+nSr0r8R3hHH4Z essex";
  yorktown = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUrcKutTY2ppfO3ANwtvDr4VjO5i5Sf2UNKgxtWyRhh yorktown";

  enterprise_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII09Ia0WfDuMZt81y1VVeKtBz6WDQlGNas8B7+s1KXUp root@enterprise";
  server_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4PclanQT+dFpvM9xFbJSNxJpIHZzZHkXbxgIMvX6YX root@nixos";
  laptop_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ8LGjtbEm/aRGwiGkoVvIqTtgMGCsv9muWlRxnyjNZ+";

  users = [serpe enterprise];
  systems = [enterprise server_host];
in {
  "enterprise_wg0.age".publicKeys = [enterprise enterprise_host];

  "essex_wg0.age".publicKeys = [essex server_host];

  "yorktown_wg0.age".publicKeys = [yorktown laptop_host];

  "feedcord.age".publicKeys = [serpe server_host];

  "navidrome.age".publicKeys = [serpe server_host];

  "photoview.age".publicKeys = [serpe server_host];

  "diun.age".publicKeys = [serpe server_host];

  "restic.age".publicKeys = [serpe server_host];
}
