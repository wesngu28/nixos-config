let
  serpe_enterprise = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGnjKj4EyU0zid0YX/Ggj+UiqQYYeVB5pKSsP/rtY1tU serpe_enterprise";
  serpe_essex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAV1zvjdq4ELPNXoch57QdiDsU22yYvGyEZVrE5s94Ek serpe_essex";

  enterprise = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAYyHNZ9+1Rm3WfqfHszDPZ2UHNCw6BduNGoKkES9OFK";
  essex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGFj7MVayLlxwlyBozk1ncYm8vrqYYCNv/Qb2PWT269X";

  users = [serpe_enterprise serpe_essex];
  systems = [enterprise essex];
in {
  "enterprise_wg0.age".publicKeys = [serpe_enterprise enterprise];

  "feedcord.age".publicKeys = [serpe_enterprise enterprise essex serpe_essex];

  "navidrome.age".publicKeys = [ serpe_essex ];
}
