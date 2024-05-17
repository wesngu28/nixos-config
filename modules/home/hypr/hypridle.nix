{
  inputs,
  pkgs,
  ...
}: let
  wallpaper = "test.png";
in {
  programs.hyprlock = {
    enable = true;

    settings = {
      background = [
        {
          monitor = "";
          path = "~/Wallpapers/Kayoko.jpg";
          blur_size = 4;
          blur_passes = 3;
          brightness = 0.75;
        }
      ];

      input-field = [
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

      # label = [
      #   {
      #     monitor = "";
      #     text = "$TIME";
      #     font_size = 120;
      #     position = {
      #       x = 0;
      #       y = 80;
      #     };
      #     valign = "center";
      #     halign = "center";
      #   }
      # ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
      before_sleep_cmd = "${pkgs.hyprlock}/bin/hyprlock";
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      listener = [
        {
          timeout = 300;
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10% & echo 1 | ${pkgs.coreutils}/bin/tee  /sys/class/leds/asus::kbd_backlight/brightness";
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r & echo 2 | ${pkgs.coreutils}/bin/tee /sys/class/leds/asus::kbd_backlight/brightness";
        }
        {
          timeout = 1200;
          on-timeout = "hyperctl dispatch dpms off";
          on-resume = "hyperctl dispatch dpms on";
        }
      ];
    };
  };

  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "loginctl terminate-user $USER";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];

    style = ''
      * {
      	background-image: none;
      }

      window {
      	background-color: rgba(30, 30, 46, 0.5);
      }

      button {
        color: #cdd6f4;
      	background-color: #313244;
      	border-style: solid;
      	border-width: 5px;
        margin: 10px;
      	background-repeat: no-repeat;
      	background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
      	background-color: #6c7086;
        color: #b4befe;
      	outline-style: none;
      }

      #lock {
         background-image: image(url("icons/lock.png"));
      }

      #logout {
         background-image: image(url("icons/logout.png"));
      }

      #suspend {
         background-image: image(url("icons/suspend.png"));
      }

      #hibernate {
         background-image: image(url("icons/hibernate.png"));
      }

      #shutdown {
         background-image: image(url("icons/shutdown.png"));
      }

      #reboot {
         background-image: image(url("icons/reboot.png"));
      }
    '';
  };

  xdg.configFile."wlogout/icons" = {
    recursive = true;
    source = ./icons;
  };
}
