{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          auto-tab-discard
          bitwarden
          firefox-color
          return-youtube-dislikes
          search-by-image
          sponsorblock
          stylus
          web-scrobbler
          violentmonkey
        ];
      };

      containerd = {
        id = 1;
        name = "containers";
        settings = {
          network.dns.disablePrefetch = true;
        };
      };

      treetabs = {
        id = 2;
        name = "treetabs";
        extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
          bitwarden
          firefox-color
          search-by-image
          tree-style-tab
        ];
        userChrome = ''
          #TabsToolbar {
              visibility: collapse;
            }
        '';
      };

      work = {
        id = 3;
        name = "work";
      };
    };
  };
}
