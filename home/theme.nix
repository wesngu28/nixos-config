{
  lib,
  pkgs,
  ...
}: {
  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
    enable = true;
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      icon.enable = true;
    };
    font = {name = "Noto Sans";};
    # theme = {
    #   name = "Dracula";
    #   package = pkgs.dracula-theme;
    # };
    # iconTheme = {
    #   name = "Papirus";
    #   package = pkgs.catppuccin-papirus-folders.override {
    #     accent = "lavender";
    #     flavor = "mocha";
    #   };
    # };
  };

  # qt = {
  #   enable = true;
  #   style.name = "kvantum";
  #   platformTheme.name = "kvantum";
  # };

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    breeze-icons
    libsForQt5.qt5ct
    qt6Packages.qtstyleplugin-kvantum
    # wallust
    # matugen
    pywal
  ];

  # home.file.".config/wallust/templates" = {
  #   source = ./templates;
  #   recursive = true;
  # };

  # home.file.".config/wallust/wallust.toml".text = ''
  #   backend = "wal"
  #   color_space = "labmixed"
  #   palette = "dark16"
  #   threshold = 10

  #   [templates]
  #   dir.template = ""
  #   dir.target = "~/.cache/wal/"
  #   dir.pywal = true

  #   kitty.template = 'kitty.conf'
  #   kitty.target = '~/.cache/wal/kitty.conf'
  #   vscode = { template="pywal-colors",  target="~/.cache/wal/colors" }
  # '';
}
