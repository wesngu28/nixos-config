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
    catppuccin.enable = true;

    settings.mainBar = {
      position = "top";
      layer = "top";
      height = 5;
      margin-top = 2;
      modules-left = [
        "custom/playerctl#backward"
        "custom/playerctl#play"
        "custom/playerctl#forward"
        "custom/playerctl"
      ];
      modules-center = ["hyprland/workspaces"];
      modules-right = ["tray" "pulseaudio" "custom/power" "clock"];
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
      "custom/playerctl#backward" = {
        format = "󰙣 ";
        return-type = "json";
        exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' --ignore-player firefox -F";
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
        return-type = "json";
        exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' --ignore-player firefox -F";
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
        format = " {}";
        exec = "playerctl metadata --format '{{artist}} - {{title}}' --ignore-player firefox -F";
        max-length = 40;
      };
      "custom/power" = {
        format = "⏻ ";
        on-click = "wlogout";
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

      #custom-playerctl, #workspaces, #tray, #pulseaudio, #memory, #disk, #clock, #custom-power {
          background: ${custom.background};
          padding: 0 0.6em;
          margin-right: 4px;
          margin-left: 2px;
          margin-top: 1px;
          margin-bottom: 1px;
          border-radius: 7px;
      }
    '';
  };

  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
}
