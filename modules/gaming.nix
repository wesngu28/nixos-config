{ pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    # lutris
    # waydroid
  ];

  programs.steam.enable = true;

}