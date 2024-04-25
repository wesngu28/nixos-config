{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    lutris
  ];

  virtualisation.waydroid.enable = true;

  programs.steam.enable = true;

  # genshin
  # programs.anime-game-launcher.enable = true;

  # star rail
  programs.honkers-railway-launcher.enable = true;

  # hi3
  # programs.honkers-launcher.enable = true;
}
