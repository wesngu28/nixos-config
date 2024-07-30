{
  inputs,
  pkgs,
  ...
}: let
  wallpaper = "test.png";
in {
  programs.swaylock = {
    enable = true;
    catppuccin.enable = false;

    settings = {
      image = "~/Wallpapers/Kayoko.jpg";
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      lock_cmd = "pidof swaylock || swaylock";
      before_sleep_cmd = "pidof swaylock || swaylock";
      after_sleep_cmd = "hyprctl dispatch dpms on";
      listener = [
        {
          timeout = 300;
          on-timeout = "swaylock";
        }
        {
          timeout = 350;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1200;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "swaylock";
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
