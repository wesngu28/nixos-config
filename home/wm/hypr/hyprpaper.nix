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

        hyprctl hyprpaper wallpaper "DP-2, $background"
      ''
    )
    (pkgs.writeShellScriptBin
      "wallpaper"
      ''
        directory=~/Wallpapers
        monitors=`hyprctl monitors | grep Monitor | awk '{print $2}'`
        if [ -d "$directory" ]; then
            random_background=$(ls $directory/*.{jpg,png} | shuf -n 1)

            hyprctl hyprpaper unload all
            hyprctl hyprpaper preload $random_background
            for monitor in $monitors; do
                hyprctl hyprpaper wallpaper "$monitor, $random_background"
            done
            sed -i "s|image=.*|image=$random_background|" ~/.config/swaylock/config
        fi
      '')
  ];
}
