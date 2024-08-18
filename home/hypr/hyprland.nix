{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprcursor.nix
  ];

  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

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
        "systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service"
        "gnome-keyring-daemon --start --components=secrets"
        "thunar --daemon"
        "vesktop"
        "sleep 0.5 && wallpaper"
      ];

      general = {
        gaps_in = 10;
        gaps_out = 10;
        border_size = 3;
        no_border_on_floating = true;
        "col.active_border" = "rgb(b4befe)";
        layout = "dwindle";
        allow_tearing = true;
      };

      misc = {
        disable_hyprland_logo = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = false;
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
        "workspace 7, class:^(virt-manager)$"
        "workspace 6, class:^(lutris)$"
        "workspace 6, class:^(steam)$"
        "workspace 6, class:^(explorer.exe)$"
        "workspace 6, class:^(battle.net.exe)$"
        "workspace 6, class:^(sc2_x64.exe)$"
        "workspace 6, class:^(moe.launcher.the-honkers-railway-launcher)"
        "workspace 6, class:^(starrail.exe)$"
        "workspace 3, initialtitle:(Spotify Premium)"
        "workspace 3, title:(Nicotine+)"
        "workspace 3, title:(Jellyfin Media Player)"
        "workspace 3, class:^(feishin)$"
        "workspace 5, title:^(Waydroid)$"
        "workspace 2, class:^(vesktop)$"
        "workspace 1, class:^(code-url-handler)$"
        "workspace 4, class:^(obsidian)"
        "workspace 4, class:^(floorp)"

        "opacity 0.93 0.93,class:^(kitty)$"
        "opacity 0.93 0.93,class:^(floorp)$"
        "opacity 0.93 0.93,class:^(obsidian)$"
        "opacity 0.93 0.93,class:^(vesktop)$"
        "opacity 0.93 0.93,class:^(kitty)$"
        "opacity 0.93 0.93,class:^(steam)$"
        "opacity 0.93 0.93,class:^(lutris)$"
        "opacity 0.93 0.93,class:^(firefox)$"
        "opacity 0.93 0.93,title:(Nicotine+)"
        "opacity 0.93 0.93,title:(Jellyfin Media Player)"
        "opacity 0.93 override 0.93 override,class:^(code-url-handler)$"
        "opacity 0.93 override 0.93 override,initialTitle:^(Spotify Premium)$"

        "suppressevent maximize, class:.*"
        "fullscreen,title:^(Waydroid)$"

        # "float,class:^(thunar)$"
        "float,class:^(battle.net.exe)$"
        "float,class:^(btop)$"
        "float,class:^(yazi)$"
        "float,class:^(imv)$"
        "float,class:^(mpv)$"
        "float,class:^(Gimp-2.10)$"
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
        "float,title:^(Steam - News)$"
        "float,class:^(electron)$,title:^(Open Files)$"
        "float,class:^(steam)$,title:^(Special Offers)$"
        "float,class:^(firefox)$,title:~^(Extension: \(Bitwarden)"
        "float,class:^(Bitwarden)$"
        # "float,class:^(steam)$,title:^(Friends List)$"

        "idleinhibit focus, class:^(mpv)$"
        "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
        "idleinhibit fullscreen, class:^(firefox)$"
        "idleinhibit always, workspace:5"
        "idleinhibit focus, workspace:6"
        "idleinhibit always, workspace:7"

        "workspace special silent, title:^(Firefox.* — Sharing Indicator)$"
        "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
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

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, E, exec, thunar"
        "$mainMod, T, exec, kitty"
        "$mainMod, A, exec, firefox"
        "$mainMod SHIFT, A, exec, firefox --profile ~/.mozilla/firefox/treetabs"
        "$mainMod CTRL, A, exec, firefox -P 'containers'"

        "$mainMod, R, exec, rofi -show drun"

        "$mainMod, Q, killactive"
        "$mainMod SHIFT, W, exit,"
        "$mainMod, F, fullscreen"
        "$mainMod, V, togglefloating"
        "$mainMod, P, pseudo"
        # "$mainMod, J, togglesplit"
        "$mainMod, N, splitratio, 0.3"
        "$mainMod, B, splitratio, -0.3"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, l, movewindow, l"
        "$mainMod, h, movewindow, r"
        "$mainMod, j, movewindow, u"
        "$mainMod, k, movewindow, d"

        "$mainMod SHIFT, x, exec, pkill waybar"
        "$mainMod, x, exec, hyprctl dispatch exec waybar"

        "$mainMod SHIFT, right, workspace, e+1"
        "$mainMod SHIFT, left, workspace, e-1"

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

        "$mainMod, S, exec, grimblast copy area"
        "$mainMod, M, exec, pkill -USR1 hyprlock"
        "$mainMod SHIFT, L, exec, hyprlock"

        # "$mainMod, mouse_down, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+"
        # "$mainMod, mouse_up, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
