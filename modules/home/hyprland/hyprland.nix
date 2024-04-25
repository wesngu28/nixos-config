{
  inputs,
  pkgs,
  lib,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    preloads = [
      "~/Wallpapers/"
    ];

    wallpapers = [
      ",~/Wallpapers"
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    catppuccin.enable = true;

    # plugins = [
    #   inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
    # ];

    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "NIXOS_OZONE_WL,1"
        "GDK_BACKEND,wayland,x11"
        "XDG_SESSION_TYPE,wayland;xcb"
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      exec-once = [
        "waybar"
        "lxqt-policykit-agent"
        # "mako"
        # "dunst"
      ];

      general = {
        monitor = [
          "DP-1,3440x1440@165,auto,auto"
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

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "float,class:^(pavucontrol)$"
        "float,class:^(blueman-manager)$"
      ];

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, E, exec, thunar"
        "$mainMod, Q, exec, kitty"
        "$mainMod, A, exec, firefox"
        "$mainMod SHIFT, A, exec, firefox --profile ~/.mozilla/firefox/treetabs"
        "$mainMod CTRL, A, exec, firefox --profile ~/.mozilla/firefox/containerd"

        "$mainMod, R, exec, rofi -show drun"

        "$mainMod, W, killactive"
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

        "$mainMod CTRL, P, exec, pkill waybar && hyprctl dispatch exec waybar"
        "$mainMod, S, exec, grimblast copy area"

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
