{
  wayland.windowManager.hyprland.settings.general = {
    monitor = "eDP-1,highres,auto,1";

    workspace = [
      "1, monitor:eDP-1, default: true"
    ];
  };

  programs.waybar.settings.mainBar.output = [
    "eDP-1"
  ];
}
