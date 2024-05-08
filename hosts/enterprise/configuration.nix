# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/programs.nix
    ../../modules/gaming.nix
    ./wireguard.nix
    ../../modules/services/ssh.nix
  ];

  # Bootloader.
  boot.loader = {
    grub.useOSProber = lib.mkDefault false;
    systemd-boot.enable = lib.mkDefault true;
    efi.canTouchEfiVariables = lib.mkDefault true;
  };
  networking.hostName = "serpe";

  # Set your time zone.
  time.timeZone = "America/Phoenix";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  security.polkit.enable = true;

  fileSystems."/mnt/c" = {
    device = "/dev/disk/by-uuid/AE28407128403A9B";
    fsType = "ntfs";
  };

  fileSystems."/mnt/d" = {
    device = "/dev/disk/by-uuid/0A947D80947D6ED7";
    fsType = "ntfs";
  };

  fileSystems."/mnt/f" = {
    device = "/dev/disk/by-uuid/C6223ECF223EC3E9";
    fsType = "ntfs";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "23.11"; # Did you read the comment?
}
