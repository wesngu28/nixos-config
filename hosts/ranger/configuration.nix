{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "ranger";

  time.timeZone = "America/Phoenix";

  programs.zsh.enable = true;
  users.users.serpe.shell = pkgs.zsh;

  services.openssh.enable = true;

  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  hardware.graphics.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    akonadi
    baloo
    plasma-browser-integration
    elisa
    gwenview
    kate
    khelpcenter
    kmailtransport
    okular
    oxygen
    print-manager
  ];

  networking.networkmanager.enable = true;
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    google-chrome
    openconnect_openssl
    btop
    du-dust
    yed
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "serpe" = {
        nixpkgs.config.allowUnfree = true;

        imports = [
          ../../home/core.nix
          ../../home/programs/vscode.nix
          ../../home/cli/git.nix
          ../../home/cli/zsh.nix
          ../../home/programs/firefox.nix
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };

  services.spice-vdagentd.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
