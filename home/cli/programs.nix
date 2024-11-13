{pkgs, ...}: {
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "code";
  };

  home.packages = with pkgs; [
    vim
    du-dust
    fastfetch
    wl-clipboard
    wget
    jq
    xxd
    grim
    slurp

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
