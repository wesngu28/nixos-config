{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModule];

  programs.spicetify = {
    enable = true;
    windowManagerPatch = true;
    theme = inputs.spicetify-nix.packages.${pkgs.system}.default.themes.Catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with inputs.spicetify-nix.packages.${pkgs.system}.default.extensions; [
      fullScreen
      shuffle
      fullAlbumDate
      volumePercentage
    ];
  };
}
