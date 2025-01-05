{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./pc/programs.nix
    ./pc/kdeconnect.nix
    ./pc/syncthing.nix
    ./pc/gaming/gaming.nix
    ./pc/ssh.nix
  ];

  environment.systemPackages = with pkgs; [
    inputs.agenix.packages."${pkgs.system}".default
  ];

  users.users.serpe.shell = pkgs.zsh;

  networking.networkmanager.enable = true;
  # systemd.services.NetworkManager-wait-online.enable = false;

  services = {
    # displayManager = {
    #   sddm = {
    #     enable = true;
    #     theme = "${import ./pc/sddm.nix {inherit pkgs;}}";
    #     wayland.enable = true;
    #   };
    # };

    # printing.enable = true;

    tumbler.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";
      displayManager.lightdm.enable = false;

      # likely to never ever ever ever go green
      videoDrivers = ["amdgpu"];
      deviceSection = ''
        Option "TearFree" "False"
        Option "VariableRefresh" "True"
      '';

      excludePackages = [pkgs.xterm];

      # libinput.enable = true;
    };

    pipewire = {
      enable = true;
      wireplumber = {
        enable = true;
        extraConfig = {
          "10-disable-camera" = {
            "wireplumber.profiles" = {
              main."monitor.libcamera" = "disabled";
            };
          };
        };
      };
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    pulseaudio.enable = false;
  };

  security.rtkit.enable = true;
  security.pam.services.swaylock = {};

  hardware = {
    graphics = {
      enable32Bit = true;
      enable = true;
    };
  };

  security.polkit.enable = true;

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

  boot.kernel.sysctl = {"vm.swappiness" = 10;};

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "serpe" = {
        imports = [
          ../home/core.nix
          ../home/desktop.nix
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
  };
}
