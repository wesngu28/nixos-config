{pkgs, ...}: {
  imports = [
    ./server/docker.nix
    ./server/nginx.nix
    ./server/containers/containers.nix
    ./server/containers/media.nix
    ./server/containers/rss.nix
    ./server/containers/paperless.nix
    ./server/samba.nix
    # ./server/containers/syncthing.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.extraOptions = ''
    warn-dirty = false
  '';

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  environment.systemPackages = with pkgs; [
    veracrypt
    git
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
