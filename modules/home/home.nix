{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "serpe";
  home.homeDirectory = "/home/serpe";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    gimp
    vesktop
    obsidian
    jellyfin-media-player
    inputs.ataraxiasjel-nur.packages."x86_64-linux".waydroid-script
    #imagemagick
    #nicotine-plus
    #veracrypt
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.git = {
    enable = true;
    userName = "wesngu28";
    userEmail = "wesley@wesngu28.com";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      source ~/.p10k.zsh
      neofetch
    '';

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };

  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    theme = ./catppuccin-mocha.rasi;
    extraConfig = {
      show-icons = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./programs/spotify.nix
    ./programs/firefox.nix
    ./programs/vscode.nix
    ./programs/vencord.nix
    ./cli/kitty.nix
    ./hyprland.nix
  ];

  home.file.".config/neofetch/config.conf".source = ./cli/neofetch.conf;
  home.file.".config/neofetch/image.png".source = ./cli/image.png;

  programs.home-manager.enable = true;
}
