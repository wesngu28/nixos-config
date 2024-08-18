{
  pkgs,
  lib,
  ...
}: {
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus";
    };

    settings = {
      global = {
        font = "FiraCode Nerd Font Mono 12";
        alignment = "left";
        width = "400";
        height = "400";
        corner_radius = "1";
        padding = "12";
        horizontal_padding = "12";
        markup = "full";
        transparency = "15";
        # frame_color = lib.mkForce "#85796f";
      };

      urgency_low = {
        timeout = 10;
      };

      urgency_normal = {
        timeout = 10;
      };
    };
  };
}
