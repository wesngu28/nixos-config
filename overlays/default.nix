{inputs, ...}: {
  nixpkgs-staging = final: _prev: {
    staging = import inputs.nixpkgs-staging {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
