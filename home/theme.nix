{
  config,
  lib,
  pkgs,
  ...
}: {
  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
    enable = true;
    waybar.enable = true;
    swaylock.enable = false;
    rofi.enable = false;
    mako.enable = false;
    foot.enable = true;
    zellij.enable = true;
    mpv.enable = false;
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
      gtk-theme = "catppuccin-mocha-lavender-standard";
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = ["lavender"];
        variant = "mocha";
        # tweaks = ["black"];
        # size = "compact";
      };
    };
    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.catppuccin-papirus-folders.override {
    #     flavor = "mocha";
    #     accent = "lavender";
    #   };
    # };
    font = {name = "Noto Sans";};
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.breeze-icons
    libsForQt5.qt5ct
    qt6Packages.qtstyleplugin-kvantum
  ];

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

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
