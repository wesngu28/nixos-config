let
  serpe_enterprise = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIML/pAN2FTezgdC4PazHVU15CY9YYL7O0dTOSrgym9qn serpe_enterprise";

  enterprise = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAYyHNZ9+1Rm3WfqfHszDPZ2UHNCw6BduNGoKkES9OFK";

  users = [serpe_enterprise];
  systems = [enterprise];
in {
  "enterprise_wg0.age".publicKeys = [serpe_enterprise enterprise];
}
