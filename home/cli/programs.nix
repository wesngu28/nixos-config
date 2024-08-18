{pkgs, ...}: {
  home.packages = with pkgs; [
    du-dust
    fastfetch
    wl-clipboard
    wget
    jq
    xxd

    # yazi
    yazi
    unar
    fd
    zip
  ];

  programs = {
    btop.enable = true;
    fzf.enable = true;
    lazygit.enable = true;
    zathura.enable = true;
  };
}
