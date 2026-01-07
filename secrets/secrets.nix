let
  serpe = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGnjKj4EyU0zid0YX/Ggj+UiqQYYeVB5pKSsP/rtY1tU serpe";

  enterprise = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIJ40/0hurk9f6fxZ6fRF5gDT06s0OrwlxkDi+TMuw2c enterprise";
  essex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBq2aQcXDlZzkvebF7ZVo9fI5ThLGT+nSr0r8R3hHH4Z essex";
  yorktown = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILUrcKutTY2ppfO3ANwtvDr4VjO5i5Sf2UNKgxtWyRhh yorktown";
  saratoga = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEfIDxG/lop63+yMhzHhsJoxfcnI/6IUx25UoZx6waiP saratoga";

  enterprise_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMJtkxE3oCuWGDFu4hyjjQnbG8tEZ2hXR/PCLnrT7lpe root@enterprise";
  server_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4PclanQT+dFpvM9xFbJSNxJpIHZzZHkXbxgIMvX6YX root@nixos";
  laptop_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ8LGjtbEm/aRGwiGkoVvIqTtgMGCsv9muWlRxnyjNZ+";
  saratoga_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2Dy9ObGsR4rlotrAUY4hyyB4Pfz0IE1W4OSYrcdRHK";

  users = [serpe enterprise];
  systems = [enterprise server_host];
in {
  "enterprise_wg0.age".publicKeys = [enterprise enterprise_host];

  "essex_wg0.age".publicKeys = [essex server_host];

  "yorktown_wg0.age".publicKeys = [yorktown laptop_host];

  "saratoga_wg0.age".publicKeys = [saratoga saratoga_host];

  "feedcord.age".publicKeys = [serpe server_host];

  "navidrome.age".publicKeys = [serpe server_host];

  "photoview.age".publicKeys = [serpe server_host];
  "immich.age".publicKeys = [serpe server_host];

  "diun.age".publicKeys = [serpe server_host];

  "restic.age".publicKeys = [serpe server_host];
  "ghtokens.age".publicKeys = [enterprise enterprise_host];
}
