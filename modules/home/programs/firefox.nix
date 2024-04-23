{inputs, ...}: {
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
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
      };

      treetabs = {
        id = 2;
        name = "treetabs";
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
          firefox-color
          search-by-image
          tree-style-tab
        ];
      };
    };
  };
}