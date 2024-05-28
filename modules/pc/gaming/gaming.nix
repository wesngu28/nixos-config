{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    lutris
    gamemode
  ];

  programs.steam = {
    enable = true;
    # extraCompatPackages = with pkgs; [
    #   proton-ge-bin
    # ];
  };
}
