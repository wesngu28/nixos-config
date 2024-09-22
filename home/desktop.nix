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

    feishin
    playerctl
    jellyfin-media-player

    syncthingtray
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
