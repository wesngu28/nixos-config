{pkgs, ...}: {
  # nixpkgs.overlays = [
  #   (self: super: {
  #     mpv-notify-send = super.callPackage ../../packages/mpv-notify-send {};
  #   })
  # ];
  programs.mpv = {
    enable = true;
    config = {
      autofit-larger = "1280x720";
      save-position-on-quit = true;
    };
    bindings = {
      UP = "add volume 2";
      DOWN = "add volume -2";
    };
    scripts = with pkgs; [
      mpvScripts.mpris
      # mpv-notify-send
    ];
  };
}
