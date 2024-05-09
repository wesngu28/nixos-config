{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
  ];

  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    catppuccin.enable = true;

    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "NIXOS_OZONE_WL,1"
        "GDK_BACKEND,wayland,x11"
        "XDG_SESSION_TYPE,wayland;xcb"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];
      exec-once = [
        "waybar"
        "lxqt-policykit-agent"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user start graphical-session.target"
        "thunar --daemon"
        "wallpaper"
      ];

      general = {
        monitor = [
          "DP-2,3440x1440@165,auto,auto"
          "HDMI-A-1,1920x1080p@60,1920x0,auto"
          ",preferred,auto,auto"
        ];
        gaps_in = 10;
        gaps_out = 10;
        border_size = 3;
        no_border_on_floating = true;
        layout = "dwindle";

        allow_tearing = false;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 2;
        touchpad.natural_scroll = false;
      };

      decoration = {
        rounding = 10;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      windowrule = [
        "fullscreen,0,waydroid"
      ];

      windowrulev2 = [
        "workspace 4, class:^(lutris)$"
        "workspace 4, class:^(steam)$"
        "workspace 4, initialTitle:^(Spotify Premium)$"
        "workspace 5, title:^(Waydroid)$"
        "workspace 2, class:^(vesktop)$"
        "workspace 1, class:^(code-url-handler)$"
        "workspace 6,class:^(obsidian)"

        "opacity 0.93 0.93,class:^(kitty)$"
        "opacity 0.93 0.93,class:^(obsidian)$"
        "opacity 0.93 0.93,class:^(vesktop)$"
        "opacity 0.93 0.93,class:^(kitty)$"
        "opacity 0.93 0.93,class:^(steam)$"
        "opacity 0.93 0.93,class:^(lutris)$"
        "opacity 0.93 0.93,class:^(firefox)$"
        "opacity 0.93 override 0.93 override,class:^(code-url-handler)$"
        "opacity 0.93 override 0.93 override,initialTitle:^(Spotify Premium)$"

        "suppressevent maximize, class:.*"
        "fullscreen,title:^(Waydroid)$"
        "float,class:^(thunar)$"
        "float,class:^(btop)$"
        "float,class:^(yazi)$"
        "float,class:^(imv)$"
        "float,class:^(mpv)$"
        "float,class:^(pavucontrol)$"
        "float,class:^(blueman-manager)$"
        "float,class:^(polkit)$,title:^(Authentication)$"
        "float,title:^(Media viewer)$"
        "float,title:^(Volume Control)$"
        "float,title:^(Picture-in-Picture)$"
        "float,title:^(DevTools)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
        "float, title:^(Steam - News)$"
        "float,class:^(electron)$,title:^(Open Files)$"
        "float,class:^(steam)$,title:^(Special Offers)$"
        "float,class:^(firefox)$,title:~^(Extension: \(Bitwarden)"
        # "float,class:^(steam)$,title:^(Friends List)$"

        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
        "idleinhibit fullscreen, class:^(firefox)$"

        "workspace special silent, title:^(Firefox.* — Sharing Indicator)$"
        "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
      ];

      workspace = [
        "8, monitor:HDMI-A-1, default: true"
      ];

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, E, exec, thunar"
        "$mainMod, T, exec, kitty"
        "$mainMod, A, exec, firefox"
        "$mainMod SHIFT, A, exec, firefox --profile ~/.mozilla/firefox/treetabs"
        "$mainMod CTRL, A, exec, firefox --profile ~/.mozilla/firefox/containerd"

        "$mainMod, R, exec, rofi -show drun"

        "$mainMod, Q, killactive"
        "$mainMod SHIFT, W, exit,"
        "$mainMod, F, fullscreen"
        "$mainMod, V, togglefloating"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod SHIFT, l, movewindow, l"
        "$mainMod SHIFT, h, movewindow, r"
        "$mainMod SHIFT, j, movewindow, u"
        "$mainMod SHIFT, k, movewindow, d"

        "$mainMod SHIFT, right, workspace, +1"
        "$mainMod SHIFT, left, workspace, -1"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"

        "$mainMod SHIFT, b, exec, hyprctl dispatch exec waybar"
        "$mainMod, S, exec, grimblast copy area"
        "$mainMod, M, exec, pkill -USR1 hyprlock"

        # "$mainMod, mouse_down, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+"
        # "$mainMod, mouse_downe, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
