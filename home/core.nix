{
  config,
  pkgs,
  inputs,
  system,
  ...
}: {
  home.username = "serpe";
  home.homeDirectory = "/home/serpe";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
