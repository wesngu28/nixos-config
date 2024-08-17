{
  inputs,
  pkgs,
  lib,
  ...
}: let
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    if ! ${pkgs.playerctl} -a status | grep -q 'Playing'; then
      # echo NOTHING_PLAYING
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in {
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
          on-timeout = suspendScript.outPath;
        }
      ];
    };
  };
}
