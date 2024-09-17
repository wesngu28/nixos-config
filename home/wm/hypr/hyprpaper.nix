{
  inputs,
  pkgs,
  ...
}: let
  wallpaper = "test.png";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Wallpapers/${wallpaper}"
      ];

      wallpaper = [
        ",~/Wallpapers/${wallpaper}"
      ];

      splash = false;
    };
  };

  home.packages = with pkgs; [
    # waypaper
    (
      pkgs.writeShellScriptBin
      "set-as-wallpaper"
      ''
        if [ -z "$1" ]; then
            exit 1
        fi
        background="$1"

        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload $background

        monitors=`hyprctl monitors | grep Monitor | awk '{print $2}'`
        for monitor in $monitors; do
            hyprctl hyprpaper wallpaper "$monitor, $background"
        done
      ''
    )
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

            hyprctl hyprpaper unload all
            hyprctl hyprpaper preload $random_background
            for monitor in $monitors; do
                hyprctl hyprpaper wallpaper "$monitor, $random_background"
            done
            # sed -i "s|image=.*|image=$random_background|" ~/.config/swaylock/config
        fi
      '')
  ];
}
