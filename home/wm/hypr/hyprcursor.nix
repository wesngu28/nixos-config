{pkgs, ...}: let
  themeDir = "${pkgs.bibata-cursors}/share/icons/";
  theme = "Bibata-Modern-Ice";
in {
  wayland.windowManager.hyprland.settings = {
    env = [
      "HYPRCURSOR_SIZE,24"
      "HYPRCURSOR_THEME,${theme}"
    ];
  };

  home.file.".icons" = {
    enable = true;
    source = themeDir;
    target = "~/.icons";
  };

  home.packages = with pkgs; [
    hyprcursor
  ];
}
