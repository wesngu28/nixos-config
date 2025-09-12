with import <nixpkgs> {};
  pkgs.mkShell rec {
    name = "workEnv";
    buildInputs = with pkgs; [
      awscli2
      aws-vault
      ssm-session-manager-plugin
    ];
  }
