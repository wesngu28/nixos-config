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
    libsForQt5.qt5ct
    #imagemagick
    #nicotine-plus
    #veracrypt
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  catppuccin = {
    flavour = "mocha";
    accent = "lavender";
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
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
  ];

  home.file.".config/neofetch/config.conf".source = ./cli/neofetch.conf;
  # home.file.".config/neofetch/image.png".source = ./cli/image.png;

  xdg.enable = true;
  gtk = {
    enable = true;
    catppuccin.enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {name = "Roboto";};
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "Catppuccin-Mocha-Lavender";
      package = pkgs.catppuccin-kvantum.override {
        accent = "Lavender";
        variant = "Mocha";
      };
    };
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Catppuccin-Mocha-Lavender
    '';

    "Kvantum/Catppuccin".source = "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Lavender";
  };

  programs.home-manager.enable = true;
}
