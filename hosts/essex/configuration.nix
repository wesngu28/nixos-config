# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./wireguard.nix
    ../../modules/core.nix
    ../../modules/lab.nix
    ./server.nix
    ../../modules/pc/gaming/waydroid.nix
    ../../modules/pc/gaming/hoyoverse.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.interfaces.enp0s31f6 = {
    ipv4.addresses = [
      {
        address = "10.60.80.10";
        prefixLength = 24;
      }
    ];
  };

  networking.defaultGateway = "10.60.80.1";
  networking.nameservers = ["10.60.80.1"];

  fileSystems."/mnt/veracrypt1" = {
    device = "/dev/disk/by-uuid/68E46314003E0F36";
    fsType = "ntfs";
  };

  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "decrypt" ''
      cd /mnt/veracrypt1
      ${pkgs.veracrypt}/bin/veracrypt --mount Files
      cd ~
    '')
  ];

  time.timeZone = "America/Phoenix";

  users.users.serpe = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEK2sw9QK+/9hu9aRN9ajwLSdr1e1uuX7gbEKJ+V6uY+ az"
    ];
  };

  programs.git = {
    enable = true;
    config = {
      user.name = "wesngu28";
      user.email = "wesley@wesngu28.com";
    };
  };

  services.openssh = {
    enable = true;
  };

  networking.hostName = "essex";

  system.stateVersion = "23.11"; # Did you read the comment?
}
