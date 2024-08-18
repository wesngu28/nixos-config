{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      # source ~/.p10k.zsh
      fastfetch
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';

    shellAliases = {
      nixos = "cd ~/nixos-config";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      line_break.disabled = true;
    };
  };
}
