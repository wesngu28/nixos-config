{
  inputs,
  pkgs,
  ...
}: {
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;
  services.blueman.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nix.extraOptions = ''
    warn-dirty = false
  '';

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Stuff for KDE

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    gwenview
    elisa
    kate
    khelpcenter
    ocular
    print-manager
  ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.videoDrivers = ["amdgpu"];
  services.xserver.deviceSection = ''
    Option "TearFree" "False"
    Option "VariableRefresh" "True"
  '';

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # services.xserver.libinput.enable = true;

  users.users.serpe = {
    isNormalUser = true;
    description = "serpe";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  security.pki.certificateFiles = [./server2.crt];
  boot.supportedFilesystems = ["ntfs"];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "serpe" = {
        imports = [
          ./home/home.nix
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };
}
