{
  inputs,
  pkgs,
  ...
}: let
  wallpaper = "test.jpg";
in {
  imports = [
    inputs.hyprpaper.homeManagerModules.hyprpaper
    inputs.hyprlock.homeManagerModules.hyprlock
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

  home.packages = [
    (pkgs.writeShellScriptBin
      "wallpaper"
      ''
        directory=~/Wallpapers
        monitor=`hyprctl monitors | grep Monitor | awk '{print $2}'`

        if [ -d "$directory" ]; then
            random_background=$(ls $directory/*.{jpg,png} | shuf -n 1)

            hyprctl hyprpaper unload all
            hyprctl hyprpaper preload $random_background
            hyprctl hyprpaper wallpaper "$monitor, $random_background"

        fi
      '')
  ];

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
}
