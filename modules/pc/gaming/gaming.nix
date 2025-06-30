{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  # nixpkgs-staging = final: _prev: {
  #   staging = import inputs.nixpkgs-staging {
  #     system = final.system;
  #     config.allowUnfree = true;
  #   };
  # };

  # nixpkgs = {
  #   overlays = [
  #     (final: prev: {
  #       staging = import inputs.nixpkgs-staging {
  #         system = final.system;
  #         config.allowUnfree = true;
  #       };
  #     })
  #   ];
  # };

  environment.systemPackages = with pkgs; [
    # lutris
    gamemode
    protontricks
    gamescope
    wineWowPackages.waylandFull
    winetricks
    # bottles
    # staging.gst_all_1.gst-plugins-bad
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
}
