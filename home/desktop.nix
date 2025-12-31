{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI / BACKGROUND
    dust
    fastfetch
    wl-clipboard
    jq
    grim
    slurp
    wf-recorder
    ffmpeg
    unar
    fd
    zip
    zellij
    hyprpolkitagent
    alejandra
    mtpfs
    playerctl

    # GUI
    gimp3
    # (vesktop.override {
    #   withSystemVencord = false;
    # })
    obsidian
    sqlitebrowser
    pwvucontrol
    # bitwarden
    # veracrypt
    seahorse
    feishin
    jellyfin-media-player
    # jellyfin-mpv-shim
    file-roller
    swayimg
    limo
    # syncthingtray
    libreoffice
    # obs-studio
    # protonvpn-gui
    brave
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
  # nixpkgs.config.permittedInsecurePackages = [
  # "electron-36.9.5"
  # ];

  xdg.dataFile."jellyfinmediaplayer/scripts/mpris.so".source = "${pkgs.mpvScripts.mpris}/share/mpv/scripts/mpris.so";

  imports = [
    ./theme.nix
    ./xdg.nix
    ./programs
    ./scripts/urlOpen.nix
    ./cli
    ./wm
  ];
}
