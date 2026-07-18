{
  osConfig,
  inputs,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    extraSessionCommands = ''
      export QT_QPA_PLATFORM=wayland
      export SDL_VIDEODRIVER=wayland
    '';

    extraConfig = ''
      output DP-2 resolution 3440x1440 position 0 0 adaptive_sync on
    '';

    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      menu = "rofi -show drun";
      focus = {
        followMouse = "no";
      };
      bars = [
        {
          command = "waybar";
        }
      ];
      left = "h";
      right = "l";
      up = "k";
      down = "j";
      startup = [
        {command = "systemctl --user start hyprpolkitagent";}
        {command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP";}
        {command = "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP";}
        {command = "systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service";}
        {command = "gnome-keyring-daemon --start --components=secrets";}
        {command = "kdeconnect-indicator";}
        {command = "blueman-applet";}
        {command = "hyprpaper";}
        {command = "sleep 0.5 && wallpaper";}
      ];
      gaps = {
        inner = 5;
        outer = 5;
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
        };
        "type:touchpad" = {
          natural_scroll = "disabled";
        };
      };
      output =
        if osConfig.networking.hostName == "enterprise"
        then {
          "DP-2" = {
            resolution = "3440x1440";
            position = "0 0";
          };
        }
        else {
          "*" = {
            resolution = "preferred";
            position = "0 0";
          };
        };
      # workspaces =
      #   if osConfig.networking.hostName == "enterprise"
      #   then [
      #     {
      #       name = "1";
      #       output = "DP-2";
      #     }
      #     {
      #       name = "2";
      #       output = "DP-2";
      #     }
      #     {
      #       name = "3";
      #       output = "DP-2";
      #     }
      #     {
      #       name = "4";
      #       output = "DP-2";
      #     }
      #     {
      #       name = "5";
      #       output = "DP-2";
      #     }
      #     {
      #       name = "6";
      #       output = "DP-2";
      #     }
      #     {
      #       name = "7";
      #       output = "DP-2";
      #     }
      #   ]
      #   else [];
      colors = {
        focused = {
          border = "#b4befe";
          background = "#b4befe";
          text = "#11111b";
          indicator = "#b4befe";
          childBorder = "#b4befe";
        };
      };
      window = {
        border = 3;
        # borderColor = "rgb(b4befe)";
        titlebar = false;
        commands = [
          # Workspace assignments
          {
            criteria = {class = "virt-manager";};
            command = "move to workspace 7";
          }
          {
            criteria = {class = "lutris";};
            command = "move to workspace 6";
          }
          {
            criteria = {class = "steam";};
            command = "move to workspace 6";
          }
          {
            criteria = {class = "explorer.exe";};
            command = "move to workspace 6";
          }
          {
            criteria = {class = "battle.net.exe";};
            command = "move to workspace 6";
          }
          {
            criteria = {class = "sc2_x64.exe";};
            command = "move to workspace 6";
          }
          {
            criteria = {class = "moe.launcher.the-honkers-railway-launcher";};
            command = "move to workspace 6";
          }
          {
            criteria = {class = "starrail.exe";};
            command = "move to workspace 6";
          }
          {
            criteria = {title = "Spotify Premium";};
            command = "move to workspace 3";
          }
          {
            criteria = {title = "Nicotine+";};
            command = "move to workspace 3";
          }
          {
            criteria = {title = "Jellyfin Media Player";};
            command = "move to workspace 3";
          }
          {
            criteria = {class = "feishin";};
            command = "move to workspace 3";
          }
          {
            criteria = {title = "Waydroid";};
            command = "move to workspace 5";
          }
          {
            criteria = {class = "vesktop";};
            command = "move to workspace 2";
          }
          {
            criteria = {class = "discord";};
            command = "move to workspace 2";
          }
          {
            criteria = {class = "obsidian";};
            command = "move to workspace 4";
          }
          {
            criteria = {class = "brave";};
            command = "move to workspace 4";
          }

          # Opacity
          {
            criteria = {class = "foot";};
            command = "opacity 0.93";
          }
          {
            criteria = {class = "obsidian";};
            command = "opacity 0.93";
          }
          {
            criteria = {class = "vesktop";};
            command = "opacity 0.93";
          }
          {
            criteria = {class = "discord";};
            command = "opacity 0.93";
          }
          {
            criteria = {class = "steam";};
            command = "opacity 0.93";
          }
          {
            criteria = {class = "lutris";};
            command = "opacity 0.93";
          }
          {
            criteria = {class = "chromium";};
            command = "opacity 0.93";
          }
          {
            criteria = {class = "firefox";};
            command = "opacity 0.93";
          }
          {
            criteria = {class = "Code";};
            command = "opacity 0.93";
          }
          {
            criteria = {title = ".*YouTube.*";};
            command = "opacity 1";
          }
          {
            criteria = {title = "Jellyfin";};
            command = "opacity 1";
          }
          {
            criteria = {title = "Jellyfin Media Player";};
            command = "opacity 1";
          }

          # Float windows
          {
            criteria = {class = "battle.net.exe";};
            command = "floating enable";
          }
          {
            criteria = {class = "btop";};
            command = "floating enable";
          }
          {
            criteria = {class = "swayimg";};
            command = "floating enable";
          }
          {
            criteria = {class = "mpv";};
            command = "floating enable";
          }
          {
            criteria = {title = "GNU Image Manipulation Program";};
            command = "floating enable";
          }
          {
            criteria = {class = "pwvucontrol";};
            command = "floating enable";
          }
          {
            criteria = {class = "blueman-manager";};
            command = "floating enable";
          }
          {
            criteria = {
              class = "polkit";
              title = "Authentication";
            };
            command = "floating enable";
          }
          {
            criteria = {title = "Media viewer";};
            command = "floating enable";
          }
          {
            criteria = {title = "Volume Control";};
            command = "floating enable";
          }
          {
            criteria = {title = "Open Folder";};
            command = "floating enable";
          }
          {
            criteria = {class = "org.gnome.FileRoller";};
            command = "floating enable";
          }
          {
            criteria = {title = "Picture-in-Picture";};
            command = "floating enable";
          }
          {
            criteria = {title = "DevTools";};
            command = "floating enable";
          }
          {
            criteria = {title = "Open File";};
            command = "floating enable";
          }
          {
            criteria = {class = "xdg-desktop-portal-gtk";};
            command = "floating enable";
          }
          {
            criteria = {class = "waypaper";};
            command = "floating enable";
          }
          {
            criteria = {
              class = "electron";
              title = "Open Files";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "firefox";
              title = ".*Bitwarden.*";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "steam";
              title = "Friends List";
            };
            command = "floating enable";
          }

          # Center windows
          {
            criteria = {class = "xdg-desktop-portal-gtk";};
            command = "move position center";
          }
          {
            criteria = {title = "Visual Studio Code";};
            command = "move position center";
          }
        ];
      };
      keybindings = {
        "${modifier}+e" = "exec thunar";
        "${modifier}+t" = "exec foot";
        "${modifier}+a" = "exec firefox";
        "${modifier}+shift+a" = "exec firefox --profile ~/.mozilla/firefox/treetabs";
        "${modifier}+ctrl+a" = "exec firefox -P containers";
        "${modifier}+r" = "exec rofi -show drun";
        "${modifier}+q" = "kill";
        "${modifier}+shift+w" = "exit";
        "${modifier}+f" = "fullscreen";
        "${modifier}+v" = "floating toggle";
        "${modifier}+left" = "focus left";
        "${modifier}+right" = "focus right";
        "${modifier}+up" = "focus up";
        "${modifier}+down" = "focus down";
        "${modifier}+l" = "move left";
        "${modifier}+h" = "move right";
        "${modifier}+j" = "move up";
        "${modifier}+k" = "move down";
        "${modifier}+x" = "exec pkill waybar || waybar";
        "${modifier}+shift+right" = "workspace next";
        "${modifier}+shift+left" = "workspace prev";
        "${modifier}+1" = "workspace 1";
        "${modifier}+2" = "workspace 2";
        "${modifier}+3" = "workspace 3";
        "${modifier}+4" = "workspace 4";
        "${modifier}+5" = "workspace 5";
        "${modifier}+6" = "workspace 6";
        "${modifier}+7" = "workspace 7";
        "${modifier}+8" = "workspace 8";
        "${modifier}+9" = "workspace 9";
        "${modifier}+shift+1" = "move container to workspace 1";
        "${modifier}+shift+2" = "move container to workspace 2";
        "${modifier}+shift+3" = "move container to workspace 3";
        "${modifier}+shift+4" = "move container to workspace 4";
        "${modifier}+shift+5" = "move container to workspace 5";
        "${modifier}+shift+6" = "move container to workspace 6";
        "${modifier}+shift+7" = "move container to workspace 7";
        "${modifier}+shift+8" = "move container to workspace 8";
        "${modifier}+shift+9" = "move container to workspace 9";
        "${modifier}+s" = "exec slurp | grim -g - - | wl-copy --type image/png && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F%T).png";
        "${modifier}+shift+s" = "exec grim - | wl-copy --type image/png && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F%T).png";
        "${modifier}+m" = "exec pkill -USR1 hyprlock";
        "${modifier}+shift+l" = "exec hyprlock";

        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPrev" = "exec playerctl previous";
        "XF86AudioNext" = "exec playerctl next";

        "${modifier}+BTN_LEFT" = "move";
        "${modifier}+BTN_RIGHT" = "resize";
      };
    };
  };
}
