{
  inputs,
  pkgs,
  ...
}: {
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # imports = [
  #   ./sleep.nix
  # ];

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
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

  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIIDUTCCAjmgAwIBAgIIEC4F+Og3+GwwDQYJKoZIhvcNAQELBQAwIDERMA8GA1UE
      AxMIZGViYnktY2ExCzAJBgNVBAYTAlVTMB4XDTIyMDkyMDA0MzMwOFoXDTMyMDkx
      NzA0MzMwOFowIDERMA8GA1UEAxMIZGViYnktY2ExCzAJBgNVBAYTAlVTMIIBIjAN
      BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApSbgAwaii4WGQhTdGQNmotvB8/UK
      gFrDBDKvxcafLXtanAY+haYX7eFzd77Oo+ZscdUEb05jGfkpDQAhglCjrHqrFHMv
      eGV/876ihdpifZ9Jky4FAJK6DepoImmo8EcYMC80EBmTfxdgFOBIzat/NnXe2wHt
      iQrJRH4E5HjIJerZl5dYKOqb5MdWPqv8kcXQtUIC6n8b3iCfXsQgOeM3p0BgJEC2
      AzJYIh1WbofquL/vU0IMgCa9NEwuHz1JI1cpk26cJLU9yIXwz+F4gixvCAhUVZS1
      aeSKVieYc0JPO0RE7uVIrcdSYVgjvU7A2894WEbxuHaTq3zyVkLVr8r6yQIDAQAB
      o4GOMIGLMB0GA1UdDgQWBBRMpOZXDAeZ5xGnd2XYUKjwIiJsmDBPBgNVHSMESDBG
      gBRMpOZXDAeZ5xGnd2XYUKjwIiJsmKEkpCIwIDERMA8GA1UEAxMIZGViYnktY2Ex
      CzAJBgNVBAYTAlVTgggQLgX46Df4bDAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIB
      BjANBgkqhkiG9w0BAQsFAAOCAQEAikoWPikGQh/UNFUKHyrf/nvpnfOfSxHNTHhu
      vIoEq/yrizbc2CtXzEjcFdC8PIOXWMO8NUWGkPZd4S/1LnYkwB/VH15EZ49EDfaE
      SF4VECstFRztpeJVUuuq0b3g+lCRnO8NKlYZ1lpI5JZlZsLhx+Ze/J7YxYqMZ6FK
      p6pW077WS51m32uV9Jk3vMTbZYSXuO3ysBd1qE7ssgwHAtn97T9LO1V0UOTSHe8x
      Z2u5re7V3SwlOBdYxOvjUyaxVsDq+FVivoB/9jfn0KzP/hDIwwmi2zMs7rIi91uZ
      OKRJrL5JaFqjQAgXEKcF54IQmakrKqM7/ECXmnyclFPR1U6BPQ==
      -----END CERTIFICATE-----

    ''
    ''
      -----BEGIN CERTIFICATE-----
      MIIFDTCCA3WgAwIBAgIBADANBgkqhkiG9w0BAQsFADB6MQswCQYDVQQGEwJVUzET
      MBEGA1UECAwKV2FzaGluZ3RvbjEQMA4GA1UEBwwHU2VhdHRsZTERMA8GA1UECgwI
      Q291bnRlcnMxITAfBgkqhkiG9w0BCQEWEmNlcnRhQHNpZGVyb2NhLmNvbTEOMAwG
      A1UEAwwFZGViYnkwHhcNMjMxMDMwMDMxNTUxWhcNMjYwMjAxMDMxNTUxWjB6MQsw
      CQYDVQQGEwJVUzETMBEGA1UECAwKV2FzaGluZ3RvbjEQMA4GA1UEBwwHU2VhdHRs
      ZTERMA8GA1UECgwIQ291bnRlcnMxITAfBgkqhkiG9w0BCQEWEmNlcnRhQHNpZGVy
      b2NhLmNvbTEOMAwGA1UEAwwFZGViYnkwggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAw
      ggGKAoIBgQCttAW5hVbsijKSH1LyLl8FXk5xTjYVtGbhhhn1qoMzZDZyItvuMJMP
      gDAeAQo0FSuXm/lZtABXf3RVJCF5ibb9HNcP28DWqNGn3Nc6xVxl61/5UGrDu5bV
      iphL4kD2IT0vXBiqKWckfcjuC/r53d9uhiEhiuHfQh8z8vzWV0WI1DFZkFAjUMAq
      q/tNTiUnCIm2epI5VoOfQOrEU6RKj9hnQB/jCinETaVqxQ66SRlGhYPHRcNm8ZRx
      S659eUkOKucgEVOUQL/WP/ia7w0/AIYEH3ktNTas8Gq10aquhzbYspWgbYL3J8UW
      o3HhOc00n7e0AJAE0jPo2BGs8yp3QYxo6hUcW/BkbNmx1btaSaxZBwFR8IicVjWr
      XYeZCVcInGBclwOOOgdvo+MzJ8p54R9wig84UP4vzK8L5CbsMIScC7xFCSE0dCPP
      j5zOg+sFt6ypjxoZEjEz/D/dwfjBDKczSTvThaqJc+l/5oGrU2ulnj8cMLwWBAdD
      7VNB4rPfnTcCAwEAAaOBnTCBmjA3BglghkgBhvhCAQ0EKhYoT1BOc2Vuc2UgR2Vu
      ZXJhdGVkIENlcnRpZmljYXRlIEF1dGhvcml0eTAdBgNVHQ4EFgQUOqKJ+gcoN2Uz
      MarY7wz+yNXwoQcwHwYDVR0jBBgwFoAUOqKJ+gcoN2UzMarY7wz+yNXwoQcwDwYD
      VR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMCAYYwDQYJKoZIhvcNAQELBQADggGB
      AAx+PWS7klVK51lqTeEu7VcNlKiIHmIkCmbj5e+lRnTwDhH4OVyMYaYxG72J9HDE
      jmytk2UewBsAm/xF18EyQSFHF8V5TTFfwYHuGKwZfVJ8fXED8NZ3oPQeK+HIM68Z
      H2vFBxCYj9oumG04GullDE985i0Q0ty+kk+4JKYSWZdaKcGDrzlyj9p4iVbZ03yW
      vV8s61vDivuvZcUqrsFpR5EqoS1etaGosILJyxJd4wkKMFIFLctqOyM94K95jRgy
      IYSZ5t4KeGdF0j07O7eaWTcYYSDlXGGYDfR4d0cHDKlURCx9D8Cpr6Jj5XMdsrsV
      tY9lJa/fkx6OwjWpL3HO7NrBo2TzqluSVxlQWhMw8RTTT77y84T1kInf6hEDBcws
      IU1HMQY+w0YyMc4KXBbgyLCnJbVURYZyJJ1IFHSIGzUymBECv/cqD/GVAPFUMLmF
      amMgm2QhiGwv6ibCvnI1AQhBmJ+x6rQSiW1LZCbsX0RGTmsvIXgZ+HQIBnPtkuQB
      GQ==
      -----END CERTIFICATE-----
    ''
  ];
  boot.supportedFilesystems = ["ntfs"];
  boot.kernel.sysctl = {"vm.swappiness" = 10;};

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
