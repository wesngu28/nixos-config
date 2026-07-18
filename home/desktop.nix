{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI / BACKGROUND
    dust
    fastfetch
    wl-clipboard
    grim
    slurp
    ffmpeg
    unzip
    gnutar
    zip
    hyprpolkitagent
    alejandra
    playerctl
    fzf
    llama-cpp-vulkan
    jq
    # android-tools
    # p7zip

    # GUI
    gimp3
    obsidian
    sqlitebrowser
    pwvucontrol
    seahorse
    feishin
    swayimg
    proton-vpn
    brave
    spotify
    jellyfin-mpv-shim

    # asunder
    # bitwarden
    # veracrypt
    libreoffice
    obs-studio
    # proton-vpn-cli
  ];

  # programs.yazi = {
  #   enable = true;
  #   settings = {
  #     mgr = {
  #       sort_by = "mtime";
  #       sort_dir_first = true;
  #       show_hidden = true;
  #     };

  #     opener = {
  #       edit = [
  #         {
  #           run = "$VISUAL %s";
  #           for = "unix";
  #           orphan = true;
  #         }
  #       ];

  #       player = [
  #         {run = ''mpv --force-window %s'';}
  #       ];

  #       open = [
  #         {
  #           run = ''xdg-open %s'';
  #           desc = "Open";
  #         }
  #       ];
  #     };
  #   };

  #   keymap = {
  #     mgr.prepend_keymap = [
  #       {
  #         on = "!";
  #         for = "unix";
  #         run = "shell '$SHELL' --block";
  #         desc = "Open $SHELL here";
  #       }
  #       {
  #         on = "<Esc>";
  #         run = "close";
  #         desc = "Cancel input";
  #       }
  #       {
  #         on = ["<C-w>"];
  #         for = "linux";
  #         run = "shell -- file --mime-type -b \"%h\" | grep -q '^image/' && set-as-wallpaper \"%h\"";
  #         desc = "Set hovered file as wallpaper";
  #       }
  #       {
  #         on = "<C-g>";
  #         run = "shell -- file --mime-type -b \"%h\" | grep -q '^image/' && gimp \"%h\"";
  #         desc = "Open GIMP";
  #       }
  #     ];
  #   };
  # };

  xdg.configFile."swayimg/init.lua".text = ''
    -- viewer defaults
    swayimg.viewer.set_default_scale("fit")
    swayimg.viewer.set_window_background(0xff000000)

    -- image list
    swayimg.imagelist.set_order("mtime")   -- change to "alpha" / "numeric" / "size" / "random" if wanted
    swayimg.imagelist.enable_reverse(false)
    swayimg.imagelist.enable_recursive(false)
    swayimg.imagelist.enable_adjacent(true)  -- old "all=yes"
    swayimg.imagelist.enable_fsmon(true)

    -- hide info overlay by default (old "info show=no")
    swayimg.on_initialized(function()
      swayimg.text.hide()
    end)

    -- keybinds
    swayimg.viewer.on_key("h", function()
      swayimg.viewer.switch_image("prev")
    end)

    swayimg.viewer.on_key("l", function()
      swayimg.viewer.switch_image("next")
    end)

    swayimg.viewer.on_key("y", function()
      local img = swayimg.viewer.get_image()
      if img then
        os.execute("wl-copy -t image/png < '" .. img.path .. "'")
      end
    end)

    swayimg.viewer.on_key("x", function()
      local img = swayimg.viewer.get_image()
      if img then
        os.remove(img.path)
        swayimg.text.set_status("File removed: " .. img.path)
      end
    end)

    swayimg.viewer.on_key("w", function()
      local img = swayimg.viewer.get_image()
      if img then
        os.execute("set-as-wallpaper '" .. img.path .. "'")
      end
    end)
  '';

  # feishin :(
  # nixpkgs.config.permittedInsecurePackages = [
  # "electron-36.9.5"
  # ];

  xdg.dataFile."jellyfinmediaplayer/scripts/mpris.so".source = "${pkgs.mpvScripts.mpris}/share/mpv/scripts/mpris.so";

  imports = [
    ./theme.nix
    ./xdg.nix
    ./programs
    ./scripts/urlOpen.nix
    ./cli
    ./wm
  ];
}
