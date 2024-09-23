{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;

    configDir = ./.;

    extraPackages = with pkgs; [
      gnome.gnome-bluetooth_1_0
    ];
  };
}
