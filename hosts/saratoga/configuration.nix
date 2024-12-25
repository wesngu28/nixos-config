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
    #    ../../modules/pc/gaming/waydroid.nix
    #    ../../modules/pc/gaming/hoyoverse.nix
    #    ./libvirtd.nix
  ];

  services.wireguard.fallback = true;

  boot = {
    loader = {
      grub.useOSProber = lib.mkDefault false;
      systemd-boot.enable = lib.mkDefault true;
      efi.canTouchEfiVariables = lib.mkDefault true;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "saratoga";

  time.timeZone = "America/Los_Angeles";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

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

  system.stateVersion = "23.11"; # Did you read the comment?
}
