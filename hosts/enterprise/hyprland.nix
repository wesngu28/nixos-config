{
  wayland.windowManager.hyprland.settings.general = {
    monitor = [
      "DP-2,3440x1440@165,auto,auto"
      "HDMI-A-1,1920x1280p@60,1920x0,auto"
    ];

    workspace = [
      "8, monitor:HDMI-A-1, default: true"
      "6, monitor:DP-2"
      "7, monitor:DP-2"
      "5, monitor:DP-2"
      "4, monitor:DP-2"
      "3, monitor:DP-2"
      "2, monitor:DP-2"
      "1, monitor:DP-2"
    ];
  };

  programs.waybar.settings.mainBar.output = [
    "DP-2"
  ];
}
