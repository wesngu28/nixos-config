{pkgs, ...}: {
  imports = [
    ./fastfetch.nix
    ./terminal.nix
  ];

  home.sessionVariables = {
    EDITOR = "nano";
    VISUAL = "code";
  };

  programs = {
    btop.enable = true;
    fzf.enable = true;
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

    zellij = {
      enable = true;
      # enableZshIntegration = true;
      extraConfig = ''
        show_startup_tips false
      '';
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initContent = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        	exec start-hyprland
        fi
        fastfetch
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey '^H' backward-kill-word
      '';

      shellAliases = {
        nixos = "cd ~/nixos-config";
        what-happened = "sudo journalctl -u home-manager-serpe.service -e";
        rbe = "rebuild enterprise";
        wgr = "sudo systemctl restart wg-quick-wg0.service";
        nfu = "cd ~/nixos-config && nix flake update";
        poweroff = "hyprshutdown -t 'Shutting down...' --post-cmd 'systemctl poweroff'";
        reboot = "hyprshutdown -t 'Restarting...' --post-cmd 'systemctl reboot'";
      };
    };
  };
}
