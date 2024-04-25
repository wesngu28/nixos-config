{pkgs, ...}: {
  xdg.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "image/*" = ["nsxiv.desktop"];
    };
    defaultApplications = {
      "application/pdf" = ["zathura.desktop"];
      "application/x-extension-htm" = ["firefox.desktop"];
      "application/x-extension-html" = ["firefox.desktop"];
      "application/x-extension-shtml" = ["firefox.desktop"];
      "application/x-extension-xht" = ["firefox.desktop"];
      "application/x-extension-xhtml" = ["firefox.desktop"];
      "application/x-extension-xhtml+xml" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop" "code.desktop"];

      "text/csv" = ["code.desktop"];
      "text/markdown" = ["code.desktop"];
      "text/plain" = ["code.desktop"];
      "text/x-python3" = ["code.desktop"];
      "text/x-python" = ["code.desktop"];
      "text/x-js" = ["code.desktop"];
      "text/x-ts" = ["code.desktop"];
      "text/x-tex" = ["code.desktop"];
      "application/x-yaml" = ["code.desktop"];
      "application/json" = ["code.desktop"];
      "application/xml" = ["code.desktop"];

      "video/mp4" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
      "video/ogg" = ["mpv.desktop"];
      "video/x-flv" = ["mpv.desktop"];
      "video/x-ms-wmv" = ["mpv.desktop"];
      "video/x-ogm+ogg" = ["mpv.desktop"];
      "video/x-theora+ogg" = ["mpv.desktop"];

      "audio/mp3" = ["mpv.desktop"];
      "audio/wav" = ["mpv.desktop"];
      "audio/flac" = ["mpv.desktop"];
      "audio/ogg" = ["mpv.desktop"];

      "image/png" = ["imv.desktop"];
      "image/jpeg" = ["imv.desktop"];
      "image/gif" = ["imv.desktop"];

      "inode/directory" = ["thunar.desktop"];
    };
  };
}
