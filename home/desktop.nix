{pkgs, ...}: {
  home.packages = with pkgs; [
    gimp
    pinta
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
    gnome.seahorse
    gnome.file-roller

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
    ./programs/firefox.nix
    ./programs/vscode.nix
    ./programs/vencord.nix
    ./programs/spotify.nix
    ./programs/imv.nix
    ./programs/mpv.nix
    ./cli/direnv.nix
    ./cli/git.nix
    ./cli/zsh.nix
    ./cli/fastfetch.nix
    ./cli/programs.nix
    ./kitty/kitty.nix
    ./hypr/hyprland.nix
    ./waybar/waybar.nix
    ./rofi/rofi.nix
    ./dunst/dunst.nix
    ./scripts/urlOpen.nix
  ];
}
