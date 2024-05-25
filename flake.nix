{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:MichaelPachec0/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ataraxiasjel-nur = {
      url = "github:AtaraxiaSjel/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      langley = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/langley/configuration.nix
          inputs.home-manager.nixosModules.default
          ./modules/core.nix
          ./modules/programs.nix
          ./modules/gaming.nix
        ];
      };

      # workhorse
      enterprise = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/enterprise/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          inputs.aagl.nixosModules.default
          inputs.agenix.nixosModules.default
          ./modules/core.nix
          ./modules/share.nix
          ./modules/programs.nix
          ./modules/gaming.nix
          ./modules/services/ssh.nix
        ];
      };

      # laptop
      yorktown = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/yorktown/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin
          inputs.aagl.nixosModules.default
          inputs.agenix.nixosModules.default
          ./modules/core.nix
          ./modules/share.nix
          ./modules/programs.nix
          ./modules/services/ssh.nix
        ];
      };

      # testing server config on laptop
      essex = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/essex/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.agenix.nixosModules.default
          ./modules/share.nix
          ./modules/lab.nix
          ./modules/server/ssh.nix
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
