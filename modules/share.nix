{
  inputs,
  pkgs,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.extraOptions = ''
    warn-dirty = false
  '';

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nixpkgs.config.allowUnfree = true;

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

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
