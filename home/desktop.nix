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

    # feishin
    playerctl
    jellyfin-media-player
    pinta
    loupe

    syncthingtray

    libreoffice
  ];

  nixpkgs.config.allowUnfree = true;

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
