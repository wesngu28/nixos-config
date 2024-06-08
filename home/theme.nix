{pkgs, ...}: {
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    breeze-icons
    libsForQt5.qt5ct
    qt6Packages.qtstyleplugin-kvantum
  ];

  catppuccin = {
    flavor = "mocha";
    accent = "lavender";
  };

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    catppuccin.enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "lavender";
        flavor = "mocha";
      };
    };
    font = {name = "Noto Sans";};
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
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
}
