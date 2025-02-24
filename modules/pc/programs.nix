{
  inputs,
  pkgs,
  lib,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-color-emoji
      fira-code
      nerd-fonts.fira-code
      crimson
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        monospace = ["FiraCode Nerd Font"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
  ];

  environment.shells = with pkgs; [zsh];
  programs.zsh.enable = true;
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-media-tags-plugin
    thunar-volman
  ];
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://ezkea.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
  services.gnome.gnome-keyring.enable = true;

  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

  networking.firewall.allowedTCPPorts = [2234];
}
