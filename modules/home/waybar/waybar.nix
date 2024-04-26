{pkgs, ...}: let
  custom = {
    font = "FiraCode Nerd Font";
    font_size = "14px";
    font_weight = "bold";
    text_color = "#cdd6f4";
    secondary_accent = "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "11111B";
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
      margin-bottom = 0;
      margin-left = 0;
      margin-right = 0;
      modules-left = ["hyprland/workspaces" "hyprland/window"];
      modules-center = ["custom/playerctl"];
      modules-right = ["tray" "clock" "memory" "disk" "pulseaudio" "custom/power"];
      clock = {
        format = " {:%I:%M %a %d}";
        tooltip = "true";
        tooltip-format = ''
          <big>{:%Y %B}</big>
          <tt><small>{calendar}</small></tt>'';
      };
      "hyprland/workspaces" = {
        active-only = false;
        disable-scroll = true;
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          "1" = "󰈹";
          "2" = "";
          "3" = "󰘙";
          "4" = "󰙯";
          "5" = "";
          "6" = "";
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
      "custom/playerctl" = {
        format = "{icon} {}";
        exec = "playerctl metadata --format '{{artist}} - {{title}}' --ignore-player firefox -F";
        on-click-middle = "playerctl play-pause";
        on-click = "playerctl previous";
        on-click-right = "playerctl next";
        format-icons = {
          playing = "";
          paused = "";
        };
      };
      "custom/power" = {
        format = "Power";
        tooltip = false;
        on-click = "sleep 0.1 && wlogout";
      };
    };
    style = ''
      * {
          border: none;
          border-radius: 0px;
          padding: 0;
          margin: 0;
          min-height: 0px;
          font-family: ${custom.font};
          font-weight: ${custom.font_weight};
          opacity: ${custom.opacity};
      }

      window#waybar {
          background: none;
      }

      #workspaces {
          font-size: 18px;
          padding-left: 15px;
          margin-right: 7px;
      }

      #workspaces button {
          color: ${custom.text_color};
          padding-left:  6px;
          padding-right: 6px;
      }
      #workspaces button.empty {
          color: #6c7086;
      }
      #workspaces button.active {
          color: #b4befe;
      }

      #tray, #pulseaudio, #memory, #disk, #clock {
          font-size: ${custom.font_size};
          color: ${custom.text_color};
      }

      #memory {
          padding-left: 9px;
          padding-right: 9px;
      }
      #disk {
          padding-left: 9px;
          padding-right: 15px;
      }

      #tray {
          padding: 0 20px;
          margin-left: 7px;
      }

      #pulseaudio {
          padding-left: 15px;
          padding-right: 9px;
          margin-left: 7px;
      }

      #clock {
          padding-left: 9px;
          padding-right: 15px;
      }

      #custom-launcher {
          font-size: 20px;
          color: #b4befe;
          font-weight: ${custom.font_weight};
          padding-left: 10px;
          padding-right: 15px;
      }
    '';
  };

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
}
