# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./wireguard.nix
    ../../modules/core.nix
    ../../modules/desktop.nix
    ../../modules/pc/gaming/waydroid.nix
    ../../modules/pc/gaming/hoyoverse.nix
  ];

  home-manager.users."serpe" = {
    home.packages = with pkgs; [
      nicotine-plus
    ];
    imports = [
      ./hyprland.nix
    ];
  };

  boot = {
    loader = {
      grub.useOSProber = lib.mkDefault false;
      systemd-boot.enable = lib.mkDefault true;
      efi.canTouchEfiVariables = lib.mkDefault true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "enterprise";

  time.timeZone = "America/Phoenix";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  fileSystems = {
    "/mnt/c" = {
      device = "/dev/disk/by-uuid/AE28407128403A9B";
      fsType = "ntfs";
    };

    "/mnt/d" = {
      device = "/dev/disk/by-uuid/0A947D80947D6ED7";
      fsType = "ntfs";
    };

    "/mnt/f" = {
      device = "/dev/disk/by-uuid/C6223ECF223EC3E9";
      fsType = "ntfs";
    };
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
