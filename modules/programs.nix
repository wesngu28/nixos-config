{
  inputs,
  pkgs,
  lib,
  ...
}: {
  fonts.packages = with pkgs; [
    fira-code
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  programs.hyprland.enable = true;
  # programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

  environment.systemPackages = with pkgs; [
    du-dust
    btop
    curl
    git
    neofetch
    syncthing
    wget
    xclip
    wireguard-tools
    alejandra
    pamixer
    pavucontrol
    playerctl
    yazi
    lxqt.lxqt-policykit
    (catppuccin-kde.override {
      flavour = ["mocha"];
      accents = ["lavender"];
    })
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

  imports = [
    ./programs/firefox.nix
    ./services/syncthing.nix
  ];
}
