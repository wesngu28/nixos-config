{ inputs, pkgs, ... }:

{

  imports = [ inputs.spicetify-nix.homeManagerModule ];

  programs.spicetify =
  {
    enable = true;
    theme = inputs.spicetify-nix.packages.${pkgs.system}.default.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with inputs.spicetify-nix.packages.${pkgs.system}.default.extensions; [
      fullScreen
      shuffle
      fullAlbumDate
      volumePercentage
    ];
  };

}