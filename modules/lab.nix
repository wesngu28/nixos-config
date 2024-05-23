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
  environment.systemPackages = with pkgs; [
    veracrypt
  ];
}
