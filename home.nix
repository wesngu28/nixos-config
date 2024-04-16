{ config, pkgs, inputs, ... }:

{
  home.username = "serpe";
  home.homeDirectory = "/home/serpe";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    gimp
    vesktop
    obsidian
    jellyfin-media-player

    #steam
    #lutris
    #waydroid
    #nicotine-plus
    #veracrypt

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.git = {
    enable = true;
    userName = "wesngu28";
    userEmail = "wesley@wesngu28.com";
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./home/programs/spotify.nix
    ./home/programs/firefox.nix
    ./home/programs/vscode.nix
    ./home/programs/vencord.nix
  ];

  programs.home-manager.enable = true;
}
