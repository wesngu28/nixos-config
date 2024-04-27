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
    alejandra
    pamixer
    pavucontrol
    playerctl
    yazi
    lxqt.lxqt-policykit
    du-dust
    neofetch
    wl-clipboard
    wget
    jq
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
    ./scripts/urlOpen.nix
  ];

  home.file.".config/neofetch/config.conf".source = ./cli/neofetch.conf;

  programs.bat = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.btop = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.fzf = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.imv = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.lazygit = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.mpv = {
    enable = true;
    # catppuccin.enable = true;
    config = {
      save-position-on-quit = true;
    };
    bindings = {
      UP = "add volume 2";
      DOWN = "add volume -2";
    };
  };

  programs.zathura = {
    enable = true;
    catppuccin.enable = true;
  };

  # programs.zellij = {
  #   enable = true;
  #   catppuccin.enable = true;
  # };

  programs.home-manager.enable = true;
}
