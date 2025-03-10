{pkgs, ...}: {
  home.packages = with pkgs; [
    gimp
    asunder
    (vesktop.override {
      withSystemVencord = false;
      electron = pkgs.electron_32;
    })
    obsidian
    sqlitebrowser
    alejandra
    pavucontrol
    lxqt.lxqt-policykit
    bitwarden
    #veracrypt
    seahorse
    wf-recorder
    ffmpeg

    feishin
    playerctl
    jellyfin-media-player
    pinta
    file-roller
    loupe

    syncthingtray

    libreoffice
  ];

  # feishin :(
  nixpkgs.config.permittedInsecurePackages = [
    "electron-32.3.3"
  ];

  xdg.dataFile."jellyfinmediaplayer/scripts/mpris.so".source = "${pkgs.mpvScripts.mpris}/share/mpv/scripts/mpris.so";

  imports = [
    ./theme.nix
    ./xdg.nix
    ./programs
    ./kitty/kitty.nix
    ./scripts/urlOpen.nix
    ./cli
    ./wm
  ];
}
