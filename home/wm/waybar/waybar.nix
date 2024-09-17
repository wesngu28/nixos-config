{pkgs, ...}: let
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
    catppuccin.enable = false;
    settings.mainBar = {
      position = "top";
      layer = "top";
      height = 5;
      margin-top = 2;
      modules-left = [
        "custom/playerctl#backward"
        "custom/playerctl#play"
        "custom/playerctl#forward"
        "image#music"
        "custom/playerctl"
        "custom/wall"
      ];
      modules-center = ["hyprland/workspaces"];
      modules-right = ["tray" "pulseaudio" "battery" "clock" "custom/power"];
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
        format = "󰙣 ";
        size = 24;
        interval = 1;
        exec = ''
          cover_img=$(playerctl -a metadata mpris:artUrl)
          curl -s "$cover_img" --output "/tmp/cover.jpg"
          echo "/tmp/cover.jpg"
        '';
      };
      "custom/playerctl#backward" = {
        format = "󰙣 ";
        on-click = "playerctl previous";
        on-scroll-up = "playerctl volume .05+";
        on-scroll-down = "playerctl volume .05-";
        format-icons = {
          Playing = "<span>󰙣 </span>";
          Paused = "<span>󰙣 </span>";
          Stopped = "<span>󰙣 </span>";
        };
        tooltip = false;
      };
      "custom/playerctl#play" = {
        format = "{icon}";
        return-type = "json";
        exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' --ignore-player firefox -F";
        on-click = "playerctl play-pause --ignore-player firefox";
        on-scroll-up = "playerctl volume .05+";
        on-scroll-down = "playerctl volume .05-";
        format-icons = {
          Playing = "<span>󰏥 </span>";
          Paused = "<span> </span>";
          Stopped = "<span> </span>";
        };
        tooltip = false;
      };
      "custom/playerctl#forward" = {
        format = "󰙡 ";
        on-click = "playerctl next";
        on-scroll-up = "playerctl volume .05+";
        on-scroll-down = "playerctl volume .05-";
        format-icons = {
          Playing = "<span>󰙡 </span>";
          Paused = "<span>󰙡 </span>";
          Stopped = "<span>󰙡 </span>";
        };
        tooltip = false;
      };
      "custom/playerctl" = {
        format = "  {}";
        exec = "playerctl metadata --format '{{artist}} - {{title}}' --ignore-player firefox -F";
        max-length = 40;
      };
      "custom/power" = {
        format = "⏻ ";
        on-click = "wlogout";
        tooltip = false;
      };
      "custom/wall" = {
        format = "⏻s ";
        on-click = "wallpaper";
        tooltip = false;
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

      #custom-playerctl, #workspaces, #tray, #pulseaudio, #memory, #disk, #clock, #battery, #custom-power {
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

      #custom-power {
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
