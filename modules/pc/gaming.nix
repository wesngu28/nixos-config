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
    (lutris.override {
      # Intercept buildFHSEnv to modify target packages
      buildFHSEnv = args:
        pkgs.buildFHSEnv (args
          // {
            multiPkgs = envPkgs: let
              # Fetch original package list
              originalPkgs = args.multiPkgs envPkgs;

              # Disable tests for openldap
              customLdap = envPkgs.openldap.overrideAttrs (_: {doCheck = false;});
            in
              # Replace broken openldap with the custom one
              builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [customLdap];
          });
    })
    wineWow64Packages.waylandFull
    # winetricks
    # (bottles.override {
    #   removeWarningPopup = true;
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
          libXcursor
          libXi
          libXinerama
          libXScrnSaver
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
