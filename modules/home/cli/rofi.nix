{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;
    terminal = "${pkgs.kitty}/bin/kitty";
    catppuccin.enable = true;
    extraConfig = {
      show-icons = true;
    };
  };
}
