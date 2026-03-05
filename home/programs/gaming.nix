{pkgs, ...}: {
  programs.retroarch = {
    enable = false;

    cores = {
      melonds = {
        enable = true;
        package = pkgs.libretro.melonds;
      };

      # citra = {
      #   enable = true;
      #   package = pkgs.libretro.citra;
      # };

      # dolphin = {
      #   enable = true;
      #   package = pkgs.libretro.dolphin;
      # };

      # mgba = {
      #   enable = true;
      #   package = pkgs.libretro.mgba;
      # };

      # sameboy = {
      #   enable = true;
      #   package = pkgs.libretro.sameboy;
      # };
    };

    settings = {
      video_driver = "vulkan";
      menu_driver = "xmb";
    };
  };

  home.packages = with pkgs; [
    melonds
  ];
}
