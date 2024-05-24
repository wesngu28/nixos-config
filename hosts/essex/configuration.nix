# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.useDHCP = true;
  #networking.interfaces.enp0s31f6 = {
  #  ipv4.addresses = [{
  #    address = "10.60.80.10";
  #    prefixLength = 24;
  #  }];
  #};

  fileSystems."/mnt/veracrypt1" = {
    device = "/dev/disk/by-uuid/4E9EA45F9EA44177";
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
    initialPassword = "pw123";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
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

  system.stateVersion = "23.11"; # Did you read the comment?

}
