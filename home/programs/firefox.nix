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
          ui.prefersReducedMotion = "1";
          network.dns.disablePrefetch = true;
        };
      };

      work = {
        id = 2;
        name = "work";
      };
    };
  };
}
