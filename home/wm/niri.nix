{
  pkgs,
  inputs,
  config,
  ...
}: let
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    playerctl status -i kdeconnect | grep Playing -q
    if [ $? -eq 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in {
  imports = [inputs.niri.homeModules.niri];

  home.packages = with pkgs; [
    swaybg
    xwayland-satellite
    (pkgs.writeShellScriptBin
      "wallpaper"
      ''
        if [ -z "$1" ]; then
            category=0
            directory=~/Wallpapers
        else
            category=$1
            directory=~/Wallpapers/$category
        fi
        monitors=`hyprctl monitors | grep Monitor | awk '{print $2}'`
        if [ -d "$directory" ]; then
            random_background=$(find $directory -type f \( -iname '*.jpg' -o -iname '*.png' \) -not -name '*_thumb.jpg' -not -name '*_thumb.png' | shuf -n 1)

            swaybg -i $random_background -m fill

            mkdir -p ~/.config/swaylock

            config_file=~/.config/swaylock/config

            if grep -q '^image=' "$config_file"; then
              sed -i "s|^image=.*|image=$random_background|" "$config_file"
            else
              echo "image=$random_background" >> "$config_file"
            fi
        fi
      '')
  ];

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "after-resume";
        command = "niri msg action power-on-monitors";
      }
    ];
    timeouts = [
      {
        timeout = 350;
        command = "niri msg action power-off-monitors";
      }
      {
        timeout = 1200;
        command = suspendScript.outPath;
      }
    ];
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      prefer-no-csd = true;

      spawn-at-startup = [
        {command = ["waybar"];}
        {command = ["xwayland-satellite"];}
        {command = ["systemctl" "--user" "start" "hyprpolkitagent"];}
        {command = ["gnome-keyring-daemon" "--start" "--components=secrets"];}
        {command = ["kdeconnect-indicator"];}
        {command = ["wallpaper"];}
      ];

      hotkey-overlay = {
        skip-at-startup = true;
      };

      environment = {
        DISPLAY = ":0";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        QT_QPA_PLATFORM = "wayland";
        QT_QPA_PLATFORMTHEME = "qt5ct";
      };

      input = {
        touchpad.natural-scroll = false;
      };

      outputs = {
        "DP-2" = {
          enable = true;
          mode = {
            width = 3440;
            height = 1440;
            refresh = 164.900;
          };
          scale = 1;
          variable-refresh-rate = "on-demand";
        };

        "HDMI-A-1" = {
          enable = true;
          position = {
            x = 1920;
            y = 0;
          };
        };
      };

      layout = {
        gaps = 12;
        border = {
          width = 2;
        };
      };

      workspaces = {
        "1".name = "main";
        "2".name = "chat";
        "3".name = "media";
        "4".name = "trees";
        "5".name = "waydroid";
        "6".name = "games";
        "7".name = "work";
      };

      window-rules = [
        {
          geometry-corner-radius = {
            bottom-left = 12.0;
            bottom-right = 12.0;
            top-left = 12.0;
            top-right = 12.0;
          };
          clip-to-geometry = true;
          opacity = 0.93;
          draw-border-with-background = false;
          open-fullscreen = false;
          open-maximized = false;
          focus-ring = {
            active = {color = "#b4befe";};
          };
          default-column-width = {
            proportion = 0.33;
          };
        }
        {
          matches = [
            {app-id = "vesktop";}
          ];
          open-on-workspace = "chat";
        }
        {
          matches = [
            {app-id = "Nicotine";}
            {app-id = "jellyfin";}
            {app-id = "feishin";}
          ];
          open-on-workspace = "media";
        }
        {
          matches = [
            {app-id = "pwvucontrol";}
            {app-id = ".blueman-manager-wrapped";}
          ];
          open-floating = true;
        }
        {
          matches = [
            {app-id = "waydroid";}
            {app-id = "steam_app_*";}
            {app-id = "starrail.exe";}
            {app-id = "gamescope";}
          ];
          open-fullscreen = true;
          variable-refresh-rate = true;
          open-maximized = true;
        }
        {
          matches = [
            {app-id = "waydroid";}
          ];
          open-on-workspace = "waydroid";
        }
        {
          matches = [
            {app-id = "steam_app_*";}
            {app-id = "starrail.exe";}
            {app-id = "gamescope";}
            {app-id = "honkers";}
          ];
          open-on-workspace = "games";
        }
        {
          matches = [
            {app-id = "virt-manager";}
          ];
          open-on-workspace = "work";
        }
        {
          matches = [
            {app-id = "firefox";}
          ];
          opacity = 0.82;
        }
        {
          matches = [
            {
              app-id = "firefox";
              title = "YouTube";
            }
            {
              app-id = "mpv";
            }
            {
              title = "imv";
            }
            {
              title = "Jellyfin Media Player";
            }
          ];
          opacity = 1.0;
        }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+t".action.spawn = "kitty";
        "Mod+d".action.spawn = "fuzzel";
        "Mod+a".action.spawn = "firefox";
        "Mod+e".action.spawn = "thunar";

        "Mod+v".action = toggle-window-floating;
        "Mod+q".action = close-window;
        # "Mod+s".action = screenshot-screen;

        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
        };
        "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "5%-"];
        "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "+5%"];
        "Mod+Left".action.focus-column-left = {};
        "Mod+Down".action.focus-window-down = {};
        "Mod+Up".action.focus-window-up = {};
        "Mod+Right".action.focus-column-right = {};
        "Mod+H".action.focus-column-left = {};
        "Mod+J".action.focus-window-down = {};
        "Mod+K".action.focus-window-up = {};
        "Mod+L".action.focus-column-right = {};

        "Mod+Ctrl+Left".action.move-column-left = {};
        "Mod+Ctrl+Down".action.move-window-down = {};
        "Mod+Ctrl+Up".action.move-window-up = {};
        "Mod+Ctrl+Right".action.move-column-right = {};
        "Mod+Ctrl+H".action.move-column-left = {};
        "Mod+Ctrl+J".action.move-window-down = {};
        "Mod+Ctrl+K".action.move-window-up = {};
        "Mod+Ctrl+L".action.move-column-right = {};

        # Alternative commands that move across workspaces when reaching
        # the first or last window in a column.
        # Mod+J     { focus-window-or-workspace-down; }
        # Mod+K     { focus-window-or-workspace-up; }
        # Mod+Ctrl+J     { move-window-down-or-to-workspace-down; }
        # Mod+Ctrl+K     { move-window-up-or-to-workspace-up; }

        "Mod+Home".action.focus-column-first = {};
        "Mod+End".action.focus-column-last = {};
        "Mod+Ctrl+Home".action.move-column-to-first = {};
        "Mod+Ctrl+End".action.move-column-to-last = {};

        "Mod+Shift+Left".action.focus-monitor-left = {};
        "Mod+Shift+Down".action.focus-monitor-down = {};
        "Mod+Shift+Up".action.focus-monitor-up = {};
        "Mod+Shift+Right".action.focus-monitor-right = {};
        "Mod+Shift+H".action.focus-monitor-left = {};
        "Mod+Shift+J".action.focus-monitor-down = {};
        "Mod+Shift+K".action.focus-monitor-up = {};
        "Mod+Shift+L".action.focus-monitor-right = {};

        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = {};
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = {};
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = {};
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = {};
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = {};
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = {};
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = {};
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = {};

        # Alternatively, there are commands to move just a single window:
        # Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
        # ...

        # And you can also move a whole workspace to another monitor:
        # Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
        # ...

        "Mod+Page_Down".action.focus-workspace-down = {};
        "Mod+Page_Up".action.focus-workspace-up = {};
        "Mod+U".action.focus-workspace-down = {};
        "Mod+I".action.focus-workspace-up = {};
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = {};
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = {};
        "Mod+Ctrl+U".action.move-column-to-workspace-down = {};
        "Mod+Ctrl+I".action.move-column-to-workspace-up = {};

        # Alternatively, there are commands to move just a single window:
        # Mod+Ctrl+Page_Down { move-window-to-workspace-down; }
        # ...

        "Mod+Shift+Page_Down".action.move-workspace-down = {};
        "Mod+Shift+Page_Up".action.move-workspace-up = {};
        "Mod+Shift+U".action.move-workspace-down = {};
        "Mod+Shift+I".action.move-workspace-up = {};

        # You can bind mouse wheel scroll ticks using the following syntax.
        # These binds will change direction based on the natural-scroll setting.
        #
        # To avoid scrolling through workspaces really fast, you can use
        # the cooldown-ms property. The bind will be rate-limited to this value.
        # You can set a cooldown on any bind, but it's most useful for the wheel.
        # "Mod+Shift+Down" = {
        #   cooldown-ms = 150;
        #   action.focus-workspace-down = {};
        # };
        # "Mod+Shift+Up" = {
        #   cooldown-ms = 150;
        #   action.focus-workspace-up = {};
        # };
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = {};
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = {};
        };
        "Mod+WheelScrollDown" = {action.focus-column-right = {};};
        "Mod+WheelScrollUp" = {action.focus-column-left = {};};

        "Mod+WheelScrollRight".action.focus-column-right = {};
        "Mod+WheelScrollLeft".action.focus-column-left = {};
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = {};
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = {};

        # Usually scrolling up and down with Shift in applications results in
        # horizontal scrolling; these binds replicate that.
        "Mod+Shift+WheelScrollDown".action.focus-column-right = {};
        "Mod+Shift+WheelScrollUp".action.focus-column-left = {};
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = {};
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = {};

        # Similarly, you can bind touchpad scroll "ticks".
        # Touchpad scrolling is continuous, so for these binds it is split into
        # discrete intervals.
        # These binds are also affected by touchpad's natural-scroll, so these
        # example binds are "inverted", since we have natural-scroll enabled for
        # touchpads by default.
        # Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
        # Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

        # You can refer to workspaces by index. However, keep in mind that
        # niri is a dynamic workspace system, so these commands are kind of
        # "best effort". Trying to refer to a workspace index bigger than
        # the current workspace count will instead refer to the bottommost
        # (empty) workspace.
        #
        # For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
        # will all refer to the 3rd workspace.
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        # Alternatively, there are commands to move just a single window:
        # Mod+Ctrl+1 { move-window-to-workspace 1; }

        # Switches focus between the current and the previous workspace.
        # Mod+Tab { focus-workspace-previous; }

        "Mod+Comma".action.consume-window-into-column = {};
        "Mod+Period".action.expel-window-from-column = {};

        # There are also commands that consume or expel a single window to the side.
        # Mod+BracketLeft  { consume-or-expel-window-left; }
        # Mod+BracketRight { consume-or-expel-window-right; }

        "Mod+R".action.switch-preset-column-width = {};
        "Mod+Shift+R".action.reset-window-height = {};
        "Mod+F".action.maximize-column = {};
        "Mod+Shift+F".action.fullscreen-window = {};
        "Mod+C".action.center-column = {};

        # Finer width adjustments.
        # This command can also:
        # * set width in pixels: "1000"
        # * adjust width in pixels: "-5" or "+5"
        # * set width as a percentage of screen width: "25%"
        # * adjust width as a percentage of screen width: "-10%" or "+10%"
        # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
        # set-column-width "100" will make the column occupy 200 physical screen pixels.
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";

        # Finer height adjustments when in column with other windows.
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # Actions to switch layouts.
        # Note: if you uncomment these, make sure you do NOT have
        # a matching layout switch hotkey configured in xkb options above.
        # Having both at once on the same hotkey will break the switching,
        # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
        # Mod+Space       { switch-layout "next"; }
        # Mod+Shift+Space { switch-layout "prev"; }

        "Print".action.screenshot = {};
        "Ctrl+Print".action.screenshot-screen = {};
        "Alt+Print".action.screenshot-window = {};
      };
    };
  };
}
