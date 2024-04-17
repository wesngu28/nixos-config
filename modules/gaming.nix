{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    lutris
  ];

  virtualisation.waydroid.enable = true;

  programs.steam.enable = true;
}
