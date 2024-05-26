{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin
      "open_url"
      (builtins.readFile ./urlOpen.sh))
  ];
}
