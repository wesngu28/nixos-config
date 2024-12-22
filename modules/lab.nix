{pkgs, ...}: {
  imports = [
    ./server/docker.nix
    ./server/services/samba.nix
    ./server/services/ssh.nix
    ./server/services/timer.nix
  ];

  networking.firewall.allowedTCPPorts = [8384 22000];
  networking.firewall.allowedUDPPorts = [22000 21027];
}
