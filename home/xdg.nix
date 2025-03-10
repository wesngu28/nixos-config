{
  inputs,
  pkgs,
  ...
}: {
  xdg = {
    enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
    desktopEntries = {
      open_url = {
        name = "Open Url";
        genericName = "Open Url";
        exec = "open_url %u";
        terminal = false;
        categories = ["Network"];
        mimeType = ["x-scheme-handler/http" "x-scheme-handler/https"];
        noDisplay = true;
      };

      set-as-wallpaper = {
        name = "Set as Wallpaper";
        genericName = "Set as Wallpaper";
        exec = "set-as-wallpaper %u";
        terminal = false;
        mimeType = ["image/png" "image/jpg" "image/jpeg"];
      };

      firefox-trees = {
        name = "Firefox Trees";
        genericName = "Web Browser";
        exec = "firefox -P \"treetabs\"";
        icon = "firefox";
        terminal = false;
        categories = ["Network" "WebBrowser"];
        mimeType = ["text/html" "text/xml"];
      };

      firefox-containers = {
        name = "Firefox Containers";
        genericName = "Web Browser";
        exec = "firefox -P \"containers\"";
        icon = "firefox";
        terminal = false;
        categories = ["Network" "WebBrowser"];
        mimeType = ["text/html" "text/xml"];
      };

      firefox-work = {
        name = "Firefox Work";
        genericName = "Web Browser";
        exec = "firefox -P \"work\"";
        icon = "firefox";
        terminal = false;
        categories = ["Network" "WebBrowser"];
        mimeType = ["text/html" "text/xml"];
      };

      windose = {
        name = "Windose";
        exec = "systemctl reboot --boat-loader-entry=auto-windows";
        terminal = false;
      };

      # spotify = {
      #   name = "Spotify";
      #   type = "Application";
      #   icon = "spotify";
      #   exec = "spotify";
      #   terminal = false;
      #   genericName = "Music Player";
      #   categories = ["Audio" "Music" "Player" "AudioVideo"];
      # };
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["zathura.desktop"];
        "application/x-extension-htm" = ["firefox.desktop"];
        "application/x-extension-html" = ["firefox.desktop"];
        "application/x-extension-shtml" = ["firefox.desktop"];
        "application/x-extension-xht" = ["firefox.desktop"];
        "application/x-extension-xhtml" = ["firefox.desktop"];
        "application/x-extension-xhtml+xml" = ["firefox.desktop"];
        "text/html" = ["firefox-containers.desktop" "code.desktop"];

        "application/zip" = "org.gnome.FileRoller.desktop";
        "application/x-tar" = "org.gnome.FileRoller.desktop";
        "application/x-bzip2" = "org.gnome.FileRoller.desktop";
        "application/x-gzip" = "org.gnome.FileRoller.desktop";

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

        "image/png" = ["imv-dir.desktop" "gimp.desktop" "pinta.desktop" "set-as-wallpaper.desktop"];
        "image/jpg" = ["imv-dir.desktop" "gimp.desktop" "pinta.desktop" "set-as-wallpaper.desktop"];
        "image/jpeg" = ["imv-dir.desktop" "gimp.desktop" "pinta.desktop" "set-as-wallpaper.desktop"];
        "image/gif" = ["org.gnome.Loupe.desktop"];

        "inode/directory" = ["thunar.desktop"];

        "x-scheme-handler/http" = ["open_url.desktop"];
        "x-scheme-handler/https" = ["open_url.desktop"];
      };
    };
  };

  home.activation.hideApps =
    inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"]
    ''
      sed -i 's/Icon=.*/NoDisplay=true/' ~/.local/share/applications/waydroid.com.desktop || true
      sed -i 's/Icon=.*/NoDisplay=true/' ~/.local/share/applications/waydroid.org.desktop || true
      sed -i 's/Icon=.*/NoDisplay=true/' ~/.local/share/applications/Proton*.desktop || true
      sed -i 's/Icon=.*/NoDisplay=true/' ~/.local/share/applications/Steam*.desktop || true
    '';

  xdg.configFile = {
    "xfce4/helpers.rc".text = ''
      TerminalEmulator=kitty.desktop
      TerminalEmulatorDismissed=true
    '';

    "Thunar/uca.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <actions>
      <action>
              <icon>kitty</icon>
              <name>Open Terminal Here</name>
              <submenu></submenu>
              <unique-id>1716857250902518-1</unique-id>
              <command>kitty %f</command>
              <description>Open kitty in the current directoryy</description>
              <range></range>
              <patterns>*</patterns>
              <startup-notify/>
              <directories/>
      </action>
      <action>
              <icon>code</icon>
              <name>Open Code Here</name>
              <submenu></submenu>
              <unique-id>1716857250902518-1</unique-id>
              <command>code %f</command>
              <description>Open VSCode in the current directory</description>
              <range></range>
              <patterns>*</patterns>
              <startup-notify/>
              <directories/>
      </action>
      <action>
              <icon>pinta</icon>
              <name>Set Wallpaper</name>
              <submenu></submenu>
              <unique-id>1716857250902518-1</unique-id>
              <command>set-as-wallpaper %f</command>
              <description>Example for a custom action</description>
              <range></range>
              <patterns>*</patterns>
              <startup-notify/>
              <image-files />
      </action>
      </actions>
    '';
  };
}
