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

  fonts.fontconfig = {
    defaultFonts = {
      serif = ["Noto Serif"];
      sansSerif = ["Noto Sans"];
      monospace = ["FiraCode Nerd Font"];
    };
  };

  environment.systemPackages = with pkgs; [
    syncthing
    wireguard-tools
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

  networking.firewall.allowedTCPPorts = [2234];
}
