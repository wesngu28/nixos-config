{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/wireguard.nix
    ../../modules/core.nix
    ../../modules/desktop.nix
  ];

  environment.systemPackages = with pkgs; [
    brightnessctl
    pulsemixer
  ];

  services.tlp.enable = true;
  services.upower.enable = true;

  services.logind.extraConfig = ''
    HandlePowerKey=suspend
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  networking.hostName = "yorktown";
  time.timeZone = "America/Los_Angeles";

  system.stateVersion = "23.11";
}
