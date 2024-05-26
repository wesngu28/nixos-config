{
  wayland.windowManager.hyprland.settings.general = {
    monitor = [
      "DP-2,3440x1440@165,auto,auto"
      "HDMI-A-1,1920x1280p@60,1920x0,auto"
    ];
  };

  programs.waybar.settings.mainBar.output = [
    "DP-2"
  ];
}
