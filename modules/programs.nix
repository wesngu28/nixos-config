{
  inputs,
  pkgs,
  lib,
  ...
}: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-color-emoji
    fira-code
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  environment.systemPackages = with pkgs; [
    syncthing
    wireguard-tools
    vim
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
  ];

  environment.shells = with pkgs; [zsh];
  programs.zsh.enable = true;
  programs.thunar.enable = true;
  programs.hyprland.enable = true;
  services.gnome.gnome-keyring.enable = true;

  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

  imports = [
    ./programs/firefox.nix
    ./programs/kdeconnect.nix
    ./services/syncthing.nix
  ];

  # for nicotine-plus
  networking.firewall.allowedTCPPorts = [2234];
}
