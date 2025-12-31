{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      autofit-larger = "1280x720";
      save-position-on-quit = true;
      target-colorspace-hint-mode = "source";
    };
    bindings = {
      UP = "add volume 2";
      DOWN = "add volume -2";
      WHEEL_UP = "add volume 2";
      WHEEL_DOWN = "add volume -2";
      n = "playlist-next";
      p = "playlist-prev";
      Del = "run ${pkgs.glib}/bin/gio move \${path} /run/user/1000/gvfs/sftp:host=essex,user=serpe/media/trash; playlist-remove current";
      g = "run ${pkgs.glib}/bin/gio move \${path} ../";
    };
    scripts = with pkgs; [
      mpvScripts.mpris
    ];
  };
}
