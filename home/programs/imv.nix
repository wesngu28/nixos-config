{
  programs.imv = {
    enable = true;
    settings.binds = {
      n = "next";
      p = "prev";
      w = "quit";
      "<Ctrl+plus>" = "zoom 1";
      "<Ctrl+minus>" = "zoom -1";
      "<Ctrl+equal>" = "zoom actual";
      y = ''exec wl-copy -t image/png < "$imv_current_file"'';
    };
  };
}
