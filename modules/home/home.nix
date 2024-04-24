{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "serpe";
  home.homeDirectory = "/home/serpe";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    gimp
    vesktop
    obsidian
    jellyfin-media-player
    sqlitebrowser
    inputs.ataraxiasjel-nur.packages."x86_64-linux".waydroid-script
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.breeze-icons
    libsForQt5.qt5ct
    loupe
    mpv
    alejandra
    pamixer
    pavucontrol
    playerctl
    yazi
    lxqt.lxqt-policykit
    du-dust
    btop
    neofetch
    wl-clipboard
    wget
    #imagemagick
    #nicotine-plus
    #veracrypt
  ];

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./theme.nix
    ./xdg.nix
    ./programs/spotify.nix
    ./programs/firefox.nix
    ./programs/vscode.nix
    ./programs/vencord.nix
    ./cli/direnv.nix
    ./cli/git.nix
    ./cli/kitty/kitty.nix
    ./hyprland/hyprland.nix
    ./waybar/waybar.nix
    ./cli/rofi.nix
    ./cli/zsh.nix
    ./dunst/dunst.nix
  ];

  home.file.".config/neofetch/config.conf".source = ./cli/neofetch.conf;

  programs.home-manager.enable = true;
}
