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
    # unar
    fd
    zip
    zellij
    hyprpolkitagent
    alejandra
    # mtpfs
    playerctl
    yazi
    fzf
    zoxide
    # p7zip
    file

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
    # limo
    # syncthingtray
    libreoffice
    # obs-studio
    # protonvpn-gui
    brave
  ];

  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        sort_by = "mtime";
        sort_dir_first = true;
        show_hidden = true;
      };

      opener = {
        edit = [
          {
            run = "$VISUAL %s";
            for = "unix";
            orphan = true;
          }
        ];

        player = [
          {run = ''mpv --force-window %s'';}
        ];

        open = [
          {
            run = ''xdg-open %s'';
            desc = "Open";
          }
        ];
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = "!";
          for = "unix";
          run = "shell '$SHELL' --block";
          desc = "Open $SHELL here";
        }
        {
          on = "<Esc>";
          run = "close";
          desc = "Cancel input";
        }
        {
          on = ["<C-w>"];
          for = "linux";
          run = "shell -- file --mime-type -b \"%h\" | grep -q '^image/' && set-as-wallpaper \"%h\"";
          desc = "Set hovered file as wallpaper";
        }
        {
          on = "<C-g>";
          run = "shell -- file --mime-type -b \"%h\" | grep -q '^image/' && gimp \"%h\"";
          desc = "Open GIMP";
        }
      ];
    };
  };

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
