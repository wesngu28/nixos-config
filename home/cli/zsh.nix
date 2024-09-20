{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
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
      nfu = "nix flake update";
      projects = "cd ~/Projects";
    };
  };
}
