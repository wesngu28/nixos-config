{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "FiraCode Nerd Font";
      font_size = "13";
      cursor_blink_interval = "0.5";
      scrollback_lines = 5000;
      remember_window_size = false;
      window_padding_width = 3;
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      allow_remote_control = true;
      # kitty_mod = "ctrl";
      confirm_os_window_close = 0;
    };
    extraConfig = ''
      include ${./catppuccin-mocha.conf}
    '';
  };
}
