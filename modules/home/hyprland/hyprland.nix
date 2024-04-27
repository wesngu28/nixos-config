{
  inputs,
  pkgs,
  lib,
  ...
}: let
  wallpaper = "test.jpg";
in {
  imports = [
    inputs.hyprpaper.homeManagerModules.hyprpaper
    inputs.hyprlock.homeManagerModules.hyprlock
    inputs.hypridle.homeManagerModules.hypridle
  ];
  home.packages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  services.hyprpaper = {
    enable = true;
    preloads = [
      "~/Wallpapers/${wallpaper}"
    ];

    wallpapers = [
      ",~/Wallpapers/${wallpaper}"
    ];
  };

  programs.hyprlock = {
    enable = true;

    backgrounds = [
      {
        monitor = "";
        path = "~/Wallpapers/${wallpaper}";
        blur_size = 4;
        blur_passes = 3;
        brightness = 0.75;
      }
    ];

    input-fields = [
      {
        monitor = "";
        size = {
          width = 250;
          height = 60;
        };
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgb(11111b)";
        inner_color = "rgb(585b70)";
        font_color = "rgb(cdd6f4)";
        fade_on_empty = false;
        placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
        hide_input = false;
        position = {
          x = 0;
          y = -120;
        };
        halign = "center";
        valign = "center";
      }
    ];
    labels = [
      {
        monitor = "";
        text = "$TIME";
        font_size = 120;
        position = {
          x = 0;
          y = 80;
        };
        valign = "center";
        halign = "center";
      }
    ];
  };

  services.hypridle = {
    enable = true;
    package = pkgs.hypridle;
    lockCmd = "${pkgs.hyprlock}/bin/hyprlock";
    beforeSleepCmd = "loginctl lock-session";
    listeners = [
      {
        timeout = 300;
        onTimeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10% & echo 1 | ${pkgs.coreutils}/bin/tee  /sys/class/leds/asus::kbd_backlight/brightness";
        onResume = "${pkgs.brightnessctl}/bin/brightnessctl -r & echo 2 | ${pkgs.coreutils}/bin/tee /sys/class/leds/asus::kbd_backlight/brightness";
      }
      {
        timeout = 350;
        onTimeout = "hyperctl dispatch dpms off";
        onResume = "hyperctl dispatch dpms on";
      }
      {
        timeout = 1800;
        onTimeout = "${pkgs.systemd}/bin/systemctl suspend";
        onResume = "";
      }
    ];
  };

  programs.wlogout = {
    enable = true;
  };

  xdg.configFile."wlogout/layout".text = ''
    {
        "label" : "lock",
        "action" : "${inputs.hyprlock.packages.${pkgs.system}.hyprlock}/bin/hyprlock",
        "text" : "Lock",
        "keybind" : "l"
    }
    {
        "label" : "hibernate",
        "action" : "systemctl hibernate",
        "text" : "Hibernate",
        "keybind" : "h"
    }
    {
        "label" : "logout",
        "action" : "loginctl terminate-user $USER",
        "text" : "Logout",
        "keybind" : "e"
    }
    {
        "label" : "shutdown",
        "action" : "systemctl poweroff",
        "text" : "Shutdown",
        "keybind" : "s"
    }
    {
        "label" : "suspend",
        "action" : "systemctl suspend",
        "text" : "Suspend",
        "keybind" : "u"
    }
    {
        "label" : "reboot",
        "action" : "systemctl reboot",
        "text" : "Reboot",
        "keybind" : "r"
    }
  '';

  xdg.configFile."wlogout/styles.css".text = ''
      * {
      background-image: none;
    }

    window {
      background-color: rgba(12, 12, 12, 1);
    }

    button {
      color: #ffffff;
      background-color: #1e1e1e;
      border-radius: 20px;
      background-repeat: no-repeat;
      background-position: center;
      background-size: 50%;
      margin: 10px;
    }

    button:hover {
      background-color: #3b393d;
      outline-style: none;
    }

    #lock {
      background-image: image(url("/etc/wlogout-icons/lock.png"));
    }

    #logout {
      background-image: image(url("/etc/wlogout-icons/logout.png"));
    }

    #suspend {
      background-image: image(url("/etc/wlogout-icons/suspend.png"));
    }

    #hibernate {
      background-image: image(url("/etc/wlogout-icons/hibernate.png"));
    }

    #shutdown {
      background-image: image(url("/etc/wlogout-icons/shutdown.png"));
    }

    #reboot {
      background-image: image(url("/etc/wlogout-icons/reboot.png"));
    }
  '';

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
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user start graphical-session.target"
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
