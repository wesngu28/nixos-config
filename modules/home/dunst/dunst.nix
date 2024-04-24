{pkgs, ...}: {
  services.dunst = {
    enable = true;
    catppuccin.enable = true;
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus";
    };

    settings = {
      global = {
        font = "FiraCode Nerd Font Mono 8";
        alignment = "left";
        width = "300";
        height = "300";
        corner_radius = "2";
        padding = "10";
        horizontal_padding = "10";
        markup = "full";
        transparency = "15";
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
