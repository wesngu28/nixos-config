{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.catppuccin.enable = true;

    initExtra = ''
      # source ~/.p10k.zsh
      fastfetch
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';

    shellAliases = {
      nixos = "cd ~/nixos-config";
    };

    # plugins = [
    #   {
    #     name = "powerlevel10k";
    #     src = pkgs.zsh-powerlevel10k;
    #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #   }
    #   {
    #     name = "powerlevel10k-config";
    #     src = ./p10k-config;
    #     file = ".p10k.zsh";
    #   }
    # ];
  };

  programs.starship = {
    enable = true;
    settings = {
      line_break.disabled = true;
    };
  };
}
