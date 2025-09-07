{pkgs, ...}: {
  home.packages = with pkgs; [
    # gimp
    gimp3
    # asunder
    # (vesktop.override {
    #   withSystemVencord = false;
    # })
    obsidian
    sqlitebrowser
    alejandra
    pavucontrol
    hyprpolkitagent
    # bitwarden
    # veracrypt
    seahorse

    feishin
    playerctl
    jellyfin-media-player
    file-roller
    swayimg
    limo

    # syncthingtray

    libreoffice
    # protonvpn-gui
  ];

  home.file.".config/swayimg/config".text = ''
    [general]
    size=1200,750

    [viewer]
    window = #000000ff
    scale = fit

    [list]
    order=mtime
    reverse=no
    loop =yes
    recursive=no
    all=yes
    fsmon=yes

    [keys.viewer]
    h=prev_file
    l=next_file
    y=exec wl-copy -t image/png < '%';
    x=exec rm -f '%' && echo "File removed: %";
    w=exec set-as-wallpaper '%'

    [info]
    show = no
  '';

  # feishin :(
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
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
