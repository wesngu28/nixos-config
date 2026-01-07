{
  osConfig,
  inputs,
  pkgs,
  ...
}: let
  xrandr-command =
    if osConfig.networking.hostName == "enterprise"
    then "xrandr --output DP-2 --primary"
    else "xrandr --output";
in {
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprcursor.nix
  ];

  home.packages = [
    inputs.hyprshutdown.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    # xwayland.enable = true;
    package = null;
    # portalPackage = null;
    plugins = [inputs.hy3.packages.x86_64-linux.hy3];

    extraConfig = ''
      render:new_render_scheduling = false
    '';

    settings = {
      env = [
        "XCURSOR_SIZE,24"
        # "NIXOS_WAYLAND,1"
        # "NIXOS_OZONE_WL,1"
      ];

      exec-once = [
        # "ags -b hypr"
        "waybar"
        # "swaync"
        "systemctl --user start hyprpolkitagent"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service"
        "gnome-keyring-daemon --start --components=secrets"
        "kdeconnect-indicator"
        "hyprpaper"
        xrandr-command
        "sleep 0.5 && wallpaper"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 3;
        "col.active_border" = "rgb(b4befe)";
        layout = "hy3";
        allow_tearing = true;
      };

      misc = {
        disable_hyprland_logo = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        render_unfocused_fps = 60;
        vrr = 3;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 2;
        touchpad.natural_scroll = false;
      };

      decoration = {
        rounding = 10;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 4, myBezier"
          "windowsOut, 1, 4, default, popin 80%"
          "border, 1, 5, default"
          "borderangle, 1, 4, default"
          "fade, 1, 4, default"
          "workspaces, 1, 5, default"
        ];
      };

      # cursor = {
      #   default_monitor = "DP-2";
      # };

      # master = {
      #   mfact = 0.5;
      #   orientation = "center";
      #   new_status = "master";
      #   new_on_top = true;
      #   new_on_active = "before";
      # };

      monitor =
        if osConfig.networking.hostName == "enterprise"
        then [
          "DP-2,3440x1440@164.90,auto,auto"
          # "HDMI-A-1,1920x1280p@60,1920x0,auto"
        ]
        else ",preferred,auto,1";

      workspace =
        if osConfig.networking.hostName == "enterprise"
        then [
          "7, monitor:DP-2"
          "6, monitor:DP-2"
          "5, monitor:DP-2"
          "4, monitor:DP-2"
          "3, monitor:DP-2"
          "2, monitor:DP-2"
          "1, monitor:DP-2"
        ]
        else [];

      windowrule = [
        "workspace 7, match:class ^(virt-manager)$"

        "workspace 6, match:class ^(lutris)$"
        "workspace 6, match:class ^(steam)$"
        "workspace 6, match:initial_class ^(steam_app_)(.*)$"
        "workspace 6, match:class ^(explorer.exe)$"
        "workspace 6, match:class ^(battle.net.exe)$"
        "workspace 6, match:class ^(sc2_x64.exe)$"
        "workspace 6, match:class ^(moe.launcher.the-honkers-railway-launcher)$"
        "workspace 6, match:class ^(starrail.exe)$"
        "workspace 3, match:initial_title ^(Spotify Premium)$"
        "workspace 3, match:title ^(Nicotine\+)$"
        "workspace 3, match:title ^(Jellyfin Media Player)$"
        "workspace 3, match:class ^(feishin)$"
        "workspace 5, match:title ^(Waydroid)$"
        "workspace 2, match:class ^(vesktop)$"
        "workspace 2, match:class ^(discord)$"
        # "workspace 1, match:class ^(Code)$"
        "workspace 4, match:class ^(obsidian)$"
        "workspace 4, match:class ^(brave)$"

        "opacity 0.93 0.93,match:class ^(foot)$"
        # "opacity 0.93 0.93,match:class ^(brave)$"
        "opacity 0.93 0.93,match:class ^(obsidian)$"
        "opacity 0.93 0.93,match:class ^(vesktop)$"
        "opacity 0.93 0.93,match:class ^(discord)$"
        "opacity 0.93 0.93,match:class ^(foot)$"
        "opacity 0.93 0.93,match:class ^(steam)$"
        "opacity 0.93 0.93,match:class ^(lutris)$"
        "opacity 0.93 0.93,match:class ^(firefox)$"
        "opacity 0.93 0.93,match:class ^(chromium)$"
        "opacity 1,match:title ^.*(YouTube — Mozilla Firefox)"
        "opacity 1,match:title ^.*(YouTube — Chromium)"
        "opacity 1,match:title ^.*(Jellyfin)"
        "opacity 0.93 0.93,match:title (Nicotine+)"
        "opacity 1,match:title (Jellyfin Media Player)"
        "opacity 0.93 override 0.93 override,match:class (Code)"
        "opacity 0.93 override 0.93 override,match:initial_title (Spotify Premium)$"

        "suppress_event maximize, match:class .*"
        "fullscreen true,match:title (Waydroid)$"

        # "float,class (thunar)$"
        "border_size 0,match:float true"
        "float true,match:class (battle.net.exe)$"
        "float true,match:class (btop)$"
        "float true,match:class (swayimg)$"
        "float true,match:class (mpv)$"
        "float true,match:title (GNU Image Manipulation Program)$"
        "float true,match:class (pwvucontrol)$"
        "float true,match:class (blueman-manager)$"
        "float true,match:class (polkit)$,match:title (Authentication)$"
        "float true,match:title (Media viewer)$"
        "float true,match:title (Volume Control)$"
        "float true,match:title (Open Folder)$"
        "float true,match:class org.gnome.FileRoller"
        "float true,match:title ^(Media viewer)$"
        "float true,match:title ^(Volume Control)$"
        "float true,match:title ^(Picture-in-Picture)$"
        "float true,match:title (DevTools)$"
        "float true,match:title (Rename.*)$"
        "float true,match:class (file_progress)$"
        "float true,match:class (confirm)$"
        "float true,match:class (dialog)$"
        "float true,match:class (download)$"
        "float true,match:class (notification)$"
        "float true,match:class (file.*)$"
        "float true,match:class (confirmreset)$"
        "float true,match:title (Open File)$"
        "float true,match:title (branchdialog)$"
        "float true,match:title (Confirm to replace files)$"
        "float true,match:title (File Operation Progress)$"
        "float true,match:title (Steam - News)$"
        "float true,match:class (electron)$,match:title (Open Files)$"
        "float true,match:class (xdg-desktop-portal-gtk)$"
        "float true,match:class (steam)$,match:title (Special Offers)$"
        "float true,match:class (firefox)$,match:title (.*Bitwarden Password Manager.*)$"
        "float true,match:modal true"
        "float true,match:title (Extension)$"
        "float true,match:title (Bluetooth Devices)$"
        "float true,match:class (steam)$,match:title (Friends List)$"
        "float true,match:class (waypaper)$"
        "float true,match:title (Pipewire Volume Control)$"

        "center true,match:class (xdg-desktop-portal-gtk)$"
        "center true,match:title (Visual Studio Code)$"
        "center true,match:title ^(Save)(.*)"
        "center true,match:title ^(Select)(.*)"
        "center true,match:title (.*)(save to)(.*)"

        "idle_inhibit focus, match:class (mpv)$"
        "idle_inhibit focus, match:class (firefox)$, match:title (.*YouTube.*)$"
        "idle_inhibit fullscreen, match:class (firefox)$"
        "idle_inhibit always, match:workspace 5"
        "idle_inhibit focus, match:workspace 6"
        "idle_inhibit always, match:workspace 7"

        "stay_focused true, match:title ()$,match:class (steam)$"
        "min_size 1 1, match:title ()$,match:class (steam)$"

        "workspace special silent, match:title (Firefox.* — Sharing Indicator)$"
        "workspace special silent, match:title (.*is sharing (your screen|a window)\.)$"

        "render_unfocused on, match:title (Honkai: Star Rail)$"
      ];

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, E, exec, thunar"
        "$mainMod, T, exec, foot"
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

        # "$mainMod, N, exec, swaync-client -t -sw"

        "$mainMod, N, layoutmsg, mfact exact 0.5"
        "$mainMod, B, layoutmsg, mfact exact 0.33"

        "$mainMod, G, layoutmsg, swapwithmaster"

        "$mainMod, left, hy3:movefocus, l"
        "$mainMod, right, hy3:movefocus, r"
        "$mainMod, up, hy3:movefocus, u"
        "$mainMod, down, hy3:movefocus, d"

        "$mainMod, l, hy3:movewindow, l"
        "$mainMod, h, hy3:movewindow, r"
        "$mainMod, j, hy3:movewindow, u"
        "$mainMod, k, hy3:movewindow, d"

        "$mainMod, x, exec, pkill waybar || waybar"

        "$mainMod SHIFT, right, workspace, e+1"
        "$mainMod SHIFT, left, workspace, e-1"

        "$mainMod, 1, workspace, 1"
        ", code:91, workspace, 1"
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

        "$mainMod, S, exec, slurp | grim -g - - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F%T).png"
        "$mainMod SHIFT, S, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F%T).png"
        "$mainMod, M, exec, pkill -USR1 hyprlock"
        "$mainMod SHIFT, L, exec, hyprlock"
      ];

      bindle = [
        ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      bindl = [
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioNext, exec, playerctl next"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
