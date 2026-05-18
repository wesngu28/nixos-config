{
  pkgs,
  config,
  ...
}: {
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
      settings = {
        user = {
          name = "wesngu28";
          email = "wesley@wesngu28.com";
        };
      };
      # userName = "wesngu28";
      # userEmail = "wesley@wesngu28.com";
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
        nfu-safe = "cd ~/nixos-config && nix flake update --override-input hyprland . --override-input hy3 .";
        suspend = "hyprshutdown -t 'Suspending...' --post-cmd 'systemctl suspend' || systemctl suspend";
        poweroff = "hyprshutdown -t 'Shutting down...' --post-cmd 'systemctl poweroff' || systemctl poweroff";
        reboot = "hyprshutdown -t 'Restarting...' --post-cmd 'systemctl reboot' || systemctl reboot";
        windose = "hyprshutdown -t 'Booting into windows...' --post-cmd 'systemctl reboot --boot-loader-entry=windows_windows10.conf' || systemctl reboot --boot-loader-entry=windows_windows10.conf";
        shuffle = "mpv --shuffle --no-resume-playback . --scale=ewa_lanczossharp --cscale=ewa_lanczossharp --dscale=mitchell --interpolation=yes";
      };
    };
  };
}
