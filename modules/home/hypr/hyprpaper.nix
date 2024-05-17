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
    };
  };

  home.packages = [
    (pkgs.writeShellScriptBin
      "wallpaper"
      ''
        directory=~/Wallpapers
        if [ -d "$directory" ]; then
            random_background=$(ls $directory/*.{jpg,png} | shuf -n 1)

            hyprctl hyprpaper unload all
            hyprctl hyprpaper preload $random_background
            hyprctl hyprpaper wallpaper "DP-2, $random_background"
            # sed -i "s|path = ~/Wallpapers/test.jpg|path = $random_background|" ~/.config/hypr/hyprlock.conf

        fi
      '')
  ];
}
