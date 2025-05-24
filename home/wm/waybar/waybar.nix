{
  osConfig,
  pkgs,
  ...
}: let
  custom = {
    font = "FiraCode Nerd Font";
    font_size = "14px";
    font_weight = "bold";
    text_color = "#cdd6f4";
    secondary_accent = "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "#1e1e2e";
    opacity = "0.98";
  };
in {
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      position = "top";
      layer = "top";
      height = 5;
      margin-top = 2;
      output =
        if osConfig.networking.hostName == "enterprise"
        then [
          "DP-2"
        ]
        else "";
      modules-left = [
        "custom/playerctl#backward"
        "custom/playerctl#play"
        "custom/playerctl#forward"
        # "image#music"
        "custom/playerctl"
      ];
      modules-center = ["hyprland/workspaces"];
      modules-right = ["custom/wall" "custom/wireguard" "tray" "pulseaudio" "battery" "clock" "custom/weather" "custom/power"];
      clock = {
        format = " {:%I:%M %a %d}";
        tooltip = "true";
        tooltip-format = ''
          <big>{:%Y %B}</big>
          <tt><small>{calendar}</small></tt>'';
      };
      "hyprland/window" = {
        format = "{title}";
        max-length = 50;
      };
      "hyprland/workspaces" = {
        active-only = false;
        disable-scroll = true;
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "󰓷";
          "6" = "";
          "7" = "";
        };
      };
      memory = {
        format = "󰟜 {used} GiB";
        interval = 2;
      };
      disk = {
        format = "󰋊 {percentage_used}%";
        interval = 60;
      };
      tray = {
        icon-size = 20;
        spacing = 10;
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰖁 {volume}%";
        format-icons = {default = [" "];};
        scroll-step = 3;
        on-click = "pavucontrol";
      };
      battery = {
        format = "{icon} {capacity}%";
        format-icons = ["" "" "" "" ""];
      };
      "image#music" = {
        size = 24;
        interval = 1;
        exec = ''
          cover_img=$(playerctl --player playerctld metadata mpris:artUrl 2>/dev/null)
          if [[ $? -ne 0 || -z "$cover_img" ]]; then
              exit 1
          fi
          curl -s "$cover_img" --output "/tmp/cover.jpg"
          echo "/tmp/cover.jpg"
        '';
      };
      "custom/playerctl#backward" = {
        format = "󰙣";
        return-type = "json";
        exec = "playerctl --player playerctld metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
        on-click = "playerctl --player playerctld previous";
        on-scroll-up = "playerctl --player playerctld volume .05+";
        on-scroll-down = "playerctl --player playerctld volume .05-";
        tooltip = false;
      };
      "custom/playerctl#play" = {
        format = "{icon}";
        return-type = "json";
        exec = "playerctl --player playerctld metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
        on-click = "playerctl --player playerctld play-pause";
        on-scroll-up = "playerctl --player playerctld volume .05+";
        on-scroll-down = "playerctl --player playerctld volume .05-";
        format-icons = {
          Playing = "<span>󰏥</span>";
          Paused = "<span></span>";
          Stopped = "<span></span>";
        };
      };
      "custom/playerctl#forward" = {
        format = "󰙡";
        return-type = "json";
        exec = "playerctl --player playerctld metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
        on-click = "playerctl --player playerctld next";
        on-scroll-up = "playerctl --player playerctld volume .05+";
        on-scroll-down = "playerctl --player playerctld volume .05-";
        tooltip = false;
      };
      "custom/playerctl" = {
        format = "<span>󰎈 {} 󰎈</span>";
        return-type = "json";
        max-length = 40;
        exec = "playerctl --player playerctld metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
        on-click = "";
      };
      # "custom/power" = {
      #   format = "⏻ ";
      #   on-click = "wlogout";
      #   tooltip = false;
      # };
      # "custom/swaync" = {
      #   # source: <https://github.com/ErikReider/SwayNotificationCenter#waybar-example>
      #   exec-if = "which swaync-client";
      #   exec = "swaync-client -swb";
      #   return-type = "json";
      #   escape = true;
      #   format = "{icon}"; # or "{icon} {}" to include notif count
      #   format-icons = {
      #     notification = " <span foreground='#ff968b'><sup></sup></span>";
      #     none = " ";
      #     dnd-notification = "<span foreground='#ff968b'><sup></sup></span>";
      #     dnd-none = "";
      #     inhibited-notification = "<span foreground='#ff968b'><sup></sup></span>";
      #     inhibited-none = "";
      #     dnd-inhibited-notification = "<span foreground='#ff968b'><sup></sup></span>";
      #     dnd-inhibited-none = "";
      #     #  
      #   };
      #   tooltip = false;
      #   on-click = "swaync-client -t -sw";
      #   on-click-right = "swaync-client -d -sw";
      # };
      "custom/power" = {
        format = " ";
        tooltip = false;
        menu = "on-click";
        menu-file =
          pkgs.writeText "powermenu.xml"
          ''
            <?xml version="1.0" encoding="UTF-8"?>
            <interface>
              <object class="GtkMenu" id="menu">
                <child>
                  <object class="GtkSeparatorMenuItem" id="delimiter1"/>
                </child>
                <child>
            		  <object class="GtkMenuItem" id="lock">
            			  <property name="label">Lock</property>
                  </object>
            	  </child>
                <child>
            		  <object class="GtkMenuItem" id="suspend">
            			  <property name="label">Suspend</property>
                  </object>
            	  </child>
                <child>
                  <object class="GtkSeparatorMenuItem" id="delimiter2"/>
                </child>
                <child>
            		  <object class="GtkMenuItem" id="reboot">
            			  <property name="label">Reboot</property>
            		  </object>
                </child>
                <child>
                  <object class="GtkMenuItem" id="shutdown">
            			  <property name="label">Shutdown</property>
                  </object>
                </child>
              </object>
            </interface>
          '';
        menu-actions = {
          lock = "swaylock";
          suspend = "systemctl suspend";
          reboot = "systemctl reboot";
          shutdown = "systemctl poweroff";
        };
      };
      "custom/wall" = {
        format = " ";
        on-click = "waypaper";
        on-click-right = "wallpaper";
        tooltip = false;
      };
      "custom/wireguard" = {
        format = "{}";
        exec = "bash -c '[ -d /sys/class/net/wg0 ] && echo 󰌾 || echo 󰿆'";
        interval = 600;
        tooltip = false;
      };
      "custom/weather" = {
        tooltip = true;
        format = "{}";
        exec = ''
          WEATHER_API_URL="https://api.open-meteo.com/v1/forecast?latitude=32.2217&longitude=-110.9265&current=weather_code,temperature_2m&hourly=precipitation_probability&daily=temperature_2m_max&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=America%2FPhoenix&forecast_days=1"

          weather_data=$(curl -s "$WEATHER_API_URL")

          current_temp=$(echo "$weather_data" | jq '.current.temperature_2m')
          current_time=$(echo "$weather_data" | jq -r '.current.time')
          daily_high=$(echo "$weather_data" | jq '.daily.temperature_2m_max[0]')

          echo "{\"text\":\"$current_temp°F\", \"tooltip\":\"Daily high: $daily_high°F - $current_time\"}"
        '';
        interval = 3600;
        return-type = "json";
      };
    };
    style = ''
      * {
          font-size: ${custom.font_size};
          font-family: ${custom.font};
          font-weight: ${custom.font_weight};
          opacity: ${custom.opacity};
      }

      window#waybar {
          background: none;
      }

      #workspaces button {
          color: ${custom.text_color};
      }
      #workspaces button.active {
          color: #cba6f7;
      }

      #custom-playerctl, #workspaces, #custom-wall, #tray, #pulseaudio, #memory, #disk, #clock, #battery, #custom-swaync, #custom-weather, #custom-wireguard {
          color: ${custom.text_color};
          padding: 0 0.6em;
          margin-right: 4px;
          margin-left: 2px;
          margin-top: 1px;
          margin-bottom: 1px;
      }

      #clock {
        color: #cba6f7;
      }

      #pulseaudio {
        color: #89dceb;
      }

      #custom-swaync {
        color: #f38ba8;
      }

      .modules-right,.modules-left,.modules-center {
          background-color: ${custom.background};
          border-radius: 7px;
          margin-right: 4px;
          margin-left: 2px;
      }

      .modules-right {
          margin-right: 4px;
      }

      .modules-left {
          margin-left: 4px;
      }

      #workspaces button.active {
          color: #b4befe;
      }
    '';
  };

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
}
