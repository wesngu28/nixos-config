{
  inputs,
  pkgs,
  ...
}: {
  home.file.".config/hypr/hyprpaper.conf".text = ''
    splash = false
    ipc = true
  '';

  wayland.windowManager.hyprland.extraConfig = ''
    exec-once=waypaper --random
  '';

  home.packages = with pkgs; [
    waypaper
    hyprpaper
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

        mkdir -p ~/.config/swaylock

        config_file=~/.config/swaylock/config

        if grep -q '^image=' "$config_file"; then
          sed -i "s|^image=.*|image=$background|" "$config_file"
        else
          echo "image=$background" >> "$config_file"
        fi
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
            mkdir -p ~/.config/swaylock

            config_file=~/.config/swaylock/config

            if grep -q '^image=' "$config_file"; then
              sed -i "s|^image=.*|image=$random_background|" "$config_file"
            else
              echo "image=$random_background" >> "$config_file"
            fi
        fi
      '')
  ];
}
