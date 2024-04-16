{ pkgs, ... }:

{

  fonts.packages = with pkgs; [
    fira-code
    (nerdfonts.override { fonts = [ "FiraCode"]; })
  ];

  environment.systemPackages = with pkgs; [
    curl
    git
    neofetch
    syncthing
    wget
    wireguard-tools
  ];

  imports = [
    ./programs/firefox.nix
    ./services/syncthing.nix
  ];

}