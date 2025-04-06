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

  hardware.enableRedistributableFirmware = true;

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
    fastfetch
    google-chrome
    openconnect_openssl
    btop
    du-dust
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "serpe" = {
        nixpkgs.config.allowUnfree = true;

        imports = [
          ../../home/core.nix
          ../../home/programs/vscode.nix
          ../../home/cli
          ../../home/programs/firefox.nix
          inputs.catppuccin.homeModules.catppuccin
        ];
      };
    };
  };

  services.spice-vdagentd.enable = true;

  users.users.serpe.extraGroups = ["docker"];
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  virtualisation.docker.daemon.settings = {
    data-root = "/home/serpe/docker";
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
