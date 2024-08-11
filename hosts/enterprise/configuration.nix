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
    ./libvirtd.nix
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

  # services.desktopManager.plasma6.enable = true;

  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   akonadi
  #   baloo
  #   plasma-browser-integration
  #   elisa
  #   gwenview
  #   kate
  #   khelpcenter
  #   kmailtransport
  #   okular
  #   oxygen
  #   print-manager
  # ];

  services.xserver.xrandrHeads = [
    {
      output = "DP-1";
      monitorConfig = ''
        Option "RightOf" "HDMI-A-1"
        Option "PreferredMode" "3440x1440"
      '';
    }
    {
      output = "HDMI-A-1";
      monitorConfig = ''
        Option "LeftOf" "DP-2"
        Option "Rotate" "Right"
        Option "PreferredMode" "1920x1200"
      '';
    }
  ];

  fileSystems = {
    "/mnt/c" = {
      device = "/dev/disk/by-uuid/6E6EF78E6EF74D79";
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

  users.users.serpe = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDSgL1QLUygF9krWrJ4fuaUbBr4nf9+RVvhyLoBTWmeC enty"
    ];
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
