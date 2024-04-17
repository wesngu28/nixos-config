{
  inputs,
  pkgs,
  ...
}: {
  fonts.packages = with pkgs; [
    fira-code
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  environment.systemPackages = with pkgs;
    [
      du-dust
      btop
      curl
      git
      neofetch
      syncthing
      wget
      xclip
      wireguard-tools

      (pkgs.writeShellScriptBin "rebuild" ''
        if git diff --quiet '*.nix'; then
            echo "No changes detected, exiting."
            exit 0
        fi

        if [ $# -ne 1 ]; then
            echo "Usage: $0 <system>"
            exit 1
        fi

        system="$1"

        echo "Rebuilding $system"

        sudo nixos-rebuild switch --flake "$HOME/nixos-config/#$system" &> "nixos-switch-$system.log" || (cat "nixos-switch-$system.log" | grep --color error && exit 1)

        if [ $? -eq 0 ]; then
            echo "Rebuild done for system: $system!"
        fi
      '')
    ]
    ++ [inputs.alejandra.defaultPackage.x86_64-linux];

  imports = [
    ./programs/firefox.nix
    ./services/syncthing.nix
  ];
}
