{pkgs, ...}: {
  imports = [
    ./fastfetch.nix
  ];

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
    wf-recorder
    ffmpeg

    yazi
    unar
    fd
    zip
  ];

  programs = {
    btop.enable = true;
    fzf.enable = true;
    # lazygit.enable = true;
    zathura.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    git = {
      enable = true;
      userName = "wesngu28";
      userEmail = "wesley@wesngu28.com";
    };

    starship = {
      enable = true;
      settings = {
        line_break.disabled = true;
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        	exec Hyprland
        fi
        # cat ~/.cache/wallust/sequences
        # cat /home/serpe/.cache/wal/sequences
        fastfetch
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
      '';

      shellAliases = {
        nixos = "cd ~/nixos-config";
        what-happened = "sudo journalctl -u home-manager-serpe.service -e";
        rbe = "rebuild enterprise";
        wgr = "sudo systemctl restart wg-quick-wg0.service";
        nfu = "cd ~/nixos-config && nix flake update";
        projects = "cd ~/Projects";
      };
    };
  };
}
