{pkgs, ...}: {
  programs.imv = {
    enable = true;
    settings.binds = {
      "<Ctrl+plus>" = "zoom 1";
      "<Ctrl+minus>" = "zoom -1";
      "<Ctrl+equal>" = "zoom actual";
      y = "exec wl-copy -t image/png < \"$imv_current_file\"";
      x = "exec ${pkgs.glib}/bin/gio trash \"$imv_current_file\"; close;";
      w = "exec set-as-wallpaper \"$imv_current_file\"";
    };
  };
}
