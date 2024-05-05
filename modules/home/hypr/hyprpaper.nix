{
  inputs,
  pkgs,
  ...
}: let
  wallpaper = "test.png";
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
            # sed -i "s|path = ~/Wallpapers/test.jpg|path = $random_background|" ~/.config/hypr/hyprlock.conf

        fi
      '')
  ];
}
