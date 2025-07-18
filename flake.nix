{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-staging.url = "github:nixos/nixpkgs/staging-next";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # niri.url = "github:sodiboo/niri-flake";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
    # nixpkgs-staging,
    ...
  } @ inputs: {
    nixosConfigurations = {
      langley = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/langley/configuration.nix
          inputs.home-manager.nixosModules.default
          ./modules/core.nix
        ];
      };

      # workhorse
      enterprise = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          # nixpkgs-staging = import nixpkgs-staging {
          #   system = "x86_64-linux";
          #   config.allowUnfree = true;
          # };
        };
        modules = [
          ./hosts/enterprise/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          inputs.aagl.nixosModules.default
          inputs.agenix.nixosModules.default
        ];
      };

      # seattle
      saratoga = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/saratoga/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          #inputs.aagl.nixosModules.default
          inputs.agenix.nixosModules.default
        ];
      };

      # laptop
      yorktown = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/yorktown/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          inputs.agenix.nixosModules.default
        ];
      };

      # work vm
      ranger = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/ranger/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
        ];
      };

      # secondary (primary in terms of proximity i guess) server
      essex = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/essex/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.agenix.nixosModules.default
          inputs.vscode-server.nixosModules.default
          ({
            config,
            pkgs,
            ...
          }: {
            services.vscode-server.enable = true;
          })
        ];
      };
    };
  };
}
