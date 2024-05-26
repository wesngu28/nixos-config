{
  config,
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.ataraxiasjel-nur.packages.${pkgs.system}.waydroid-script
  ];

  virtualisation.waydroid.enable = true;
}
