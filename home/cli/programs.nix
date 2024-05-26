{pkgs, ...}: {
  home.packages = with pkgs; [
    du-dust
    fastfetch
    wl-clipboard
    wget
    jq

    # yazi
    yazi
    unar
    zoxide
    fd
    zip
  ];

  programs.bat = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.btop = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.fzf = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.lazygit = {
    enable = true;
    catppuccin.enable = true;
  };

  programs.zathura = {
    enable = true;
    catppuccin.enable = true;
  };
}
