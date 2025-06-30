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
    ../../modules/wireguard.nix
    ../../modules/core.nix
    ../../modules/desktop.nix
    ../../modules/pc/gaming/waydroid.nix
    ../../modules/pc/gaming/hoyoverse.nix
    ./libvirtd.nix
  ];

  services.wireguard.autostart = false;
  services.wireguard.fallback = true;

  home-manager.users."serpe" = {
    home.packages = with pkgs; [
      nicotine-plus
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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
        # A2DP support
        Enable = "Source,Sink,Media,Socket";
        # Battery level display
        Experimental = true;
      };
    };
  };

  services.blueman.enable = true;

  systemd.services.restart-bluetooth-on-suspension = {
    description = "Restart bluetooth on suspension.";
    wantedBy = ["post-resume.target"];
    after = ["post-resume.target"];
    script = ''
      rfkill block bluetooth
      rfkill unblock bluetooth
    '';
    serviceConfig.Type = "oneshot";
  };

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
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000"];
    };

    "/mnt/f" = {
      device = "/dev/disk/by-uuid/C6223ECF223EC3E9";
      fsType = "ntfs-3g";
      options = ["rw" "uid=1000"];
    };
  };

  users.users.serpe = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDSgL1QLUygF9krWrJ4fuaUbBr4nf9+RVvhyLoBTWmeC enty"
    ];
  };

  # services.clamav = {
  #   daemon.enable = true;
  #   updater.enable = true;
  # };

  system.stateVersion = "23.11"; # Did you read the comment?
}
