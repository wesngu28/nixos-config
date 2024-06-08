{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/core.nix
    ../../modules/pc/firefox.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "ranger";

  time.timeZone = "America/Phoenix";

  users.users.serpe.shell = pkgs.zsh;

  services.openssh.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "${import ../../modules/pc/sddm.nix {inherit pkgs;}}";
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    elisa
    gwenview
    kate
    khelpcenter
    kmailtransport
    konsole
    okular
    oxygen
    print-manager
  ];

  networking.networkmanager.enable = true;
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    brave
    openconnect_openssl
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "serpe" = {
        imports = [
          ../home/core.nix
          ../home/theme.nix
          ../home/programs/vscode.nix
          ../home/programs/imv.nix
          ../home/cli/direnv.nix
          ../home/cli/git.nix
          ../home/cli/zsh.nix
          ../home/kitty/kitty.nix
          ../home/rofi/rofi.nix
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };

  services.spice-vdagentd.enable = true;
  services.spice-autorandr.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
