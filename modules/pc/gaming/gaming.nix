{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    lutris
  ];

  programs.steam.enable = true;
}
