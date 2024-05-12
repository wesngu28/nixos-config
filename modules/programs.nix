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
    git
    syncthing
    wireguard-tools
    vim
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    (pkgs.writeShellScriptBin "rebuild" ''
      # if git diff --quiet '*.nix'; then
      #     echo "No changes detected, exiting."
      #     exit 0
      # fi

      if [ $# -ne 1 ]; then
          echo "Usage: $0 <system>"
          exit 1
      fi

      system="$1"

      echo "Rebuilding $system"

      sudo nixos-rebuild switch --flake "$HOME/nixos-config/#$system"

      if [ $? -eq 0 ]; then
          echo "Rebuild done for system: $system!"
      fi
    '')
  ];

  environment.shells = with pkgs; [zsh];
  programs.zsh.enable = true;
  programs.thunar.enable = true;
  programs.hyprland.enable = true;

  imports = [
    ./programs/firefox.nix
    ./programs/kdeconnect.nix
    ./services/syncthing.nix
  ];

  # for nicotine-plus
  networking.firewall.allowedTCPPorts = [2234];
}
