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
          placeholder_text = ''Input Password...'';
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
      lock_cmd = "pidof hyprlock || hyprlock";
      before_sleep_cmd = "loginctl lock-session";
      after_sleep_cmd = "hyprctl dispatch dpms on";
      listener = [
        {
          timeout = 300;
          on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
          on-resume = "${pkgs.hyprlock}/bin/hyprlock";
        }
        {
          timeout = 350;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          onTimeout = "${pkgs.systemd}/bin/systemctl suspend";
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
