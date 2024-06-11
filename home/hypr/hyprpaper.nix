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
      "test-wall"
      ''
        if [ $# -ne 1 ]; then
          echo "Usage: $0 <background>"
          exit 1
        fi

        background="$1"

        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload ~/Wallpapers/$background

        hyprctl hyprpaper wallpaper "DP-2, ~/Wallpapers/$background"
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
            # sed -i "s|path = ~/Wallpapers/test.jpg|path = $random_background|" ~/.config/hypr/hyprlock.conf
        fi
      '')
  ];
}
