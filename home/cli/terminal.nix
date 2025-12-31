{pkgs, ...}: {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "FiraCode Nerd Font:size=13";
      };

      mouse.hide-when-typing = "yes";
    };
  };
}
