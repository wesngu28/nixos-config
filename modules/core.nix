{
  inputs,
  pkgs,
  ...
}: {
  users.users.serpe = {
    isNormalUser = true;
    description = "serpe";
    extraGroups = ["networkmanager" "wheel"];
  };

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];

    extraOptions = ''
      warn-dirty = false
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  nixpkgs.config.allowUnfree = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
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
  };

  environment.systemPackages = with pkgs; [
    git
    inputs.agenix.packages."${pkgs.system}".default
    (pkgs.writeShellScriptBin "rebuild" ''
      # if git diff --quiet '*.nix'; then
      #     echo "No changes detected, exiting."
      #     exit 0
      # fi

      if [ $# -ne 1 ]; then
          echo "Usage: $0 <system>"
          exit 1
      fi

      system="$1"

      echo "Rebuilding $system"

      sudo nixos-rebuild switch --flake "$HOME/nixos-config/#$system"

      if [ $? -eq 0 ]; then
          echo "Rebuild done for system: $system!"
      fi
    '')
  ];

  boot.supportedFilesystems = ["ntfs"];
}
