{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    font = "FiraCode Nerd Font 12";

    extraConfig = {
      show-icons = true;
      modi = "drun";
      hover-select = true;
      display-drun = " ";
      drun-display-format = "{name}";
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        font = "FiraCode Nerd Font 12";

        bg0 = mkLiteral "#1e1e2e";
        bg1 = mkLiteral "#7E7E7E80";
        bg2 = mkLiteral "#b4befe";

        fg0 = mkLiteral "#DEDEDE";
        fg1 = mkLiteral "#181825";
        fg2 = mkLiteral "#DEDEDE80";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "#cdd6f4";

        margin = 0;
        padding = 0;
        spacing = 0;
      };

      window = {
        background-color = mkLiteral "@bg0";

        location = mkLiteral "center";
        width = 640;
        border-radius = 8;
      };

      inputbar = {
        padding = mkLiteral "12px";
        spacing = mkLiteral "12px";
        children = mkLiteral "[ icon-search, entry ]";
      };

      icon-search = {
        expand = false;
        filename = mkLiteral "'search'";
        size = mkLiteral "28px";
      };

      "icon-search, entry, element-icon, element-text" = {
        vertical-align = mkLiteral "0.5";
      };

      entry = {
        font = mkLiteral "inherit";

        placeholder = mkLiteral "'Search'";
        placeholder-color = mkLiteral "@fg2";
      };

      message = {
        border = mkLiteral "2px 0 0";
        border-color = mkLiteral "@bg1";
        background-color = mkLiteral "@bg1";
      };

      textbox = {
        padding = mkLiteral "8px 24px";
      };

      listview = {
        lines = 5;
        columns = 1;

        fixed-height = false;
        border = mkLiteral "1px 0 0";
        border-color = mkLiteral "@bg1";
      };

      element = {
        padding = mkLiteral "8px 16px";
        spacing = mkLiteral "16px";
        background-color = mkLiteral "transparent";
      };

      "element normal active" = {
        text-color = mkLiteral "@bg2";
      };

      "element selected normal, element selected active" = {
        background-color = mkLiteral "@bg2";
        text-color = mkLiteral "@fg1";
      };

      element-icon = {
        size = mkLiteral "1em";
      };

      element-text = {
        text-color = mkLiteral "inherit";
      };
    };
  };
}
