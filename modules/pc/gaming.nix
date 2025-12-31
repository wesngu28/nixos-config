{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    gamemode
    protontricks
    gamescope
    lutris
    wineWowPackages.waylandFull
    # winetricks
    # (bottles.override {
    #  removeWarningPopup = true;
    # })

    waydroid-helper
  ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    package = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
    };
  };

  # genshin
  # programs.anime-game-launcher.enable = true;

  # star rail
  programs.honkers-railway-launcher.enable = true;

  # hi3
  # programs.honkers-launcher.enable = true;

  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };
}
