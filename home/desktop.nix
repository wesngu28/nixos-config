{pkgs, ...}: {
  home.packages = with pkgs; [
    gimp
    asunder
    (vesktop.override {
      withSystemVencord = false;
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
    # protonvpn-gui
  ];

  # feishin :(
  nixpkgs.config.permittedInsecurePackages = [
    "electron-33.4.11"
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
