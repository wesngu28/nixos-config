{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprcursor.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    # xwayland.enable = true;
    package = null;
    # portalPackage = null;
    # plugins = [inputs.hy3.packages.x86_64-linux.hy3];
    configType = "lua";
    extraConfig = builtins.readFile ./hyprland.lua;
  };
}
