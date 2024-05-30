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

        search = {
          default = "Brave Search";
          order = ["Brave Search" "StartPage" "DuckDuckGo"];
          force = true;

          engines = {
            "Brave Search" = {
              urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
              definedAliases = ["@b"];
            };

            "DuckDuckGo" = {
              urls = [{template = "https://duckduckgo.com/?q={searchTerms}";}];
              definedAliases = ["d"];
            };

            "StartPage" = {
              urls = [{template = "https://www.startpage.com/sp/search?query={searchTerms}";}];
              definedAliases = ["@sp"];
            };

            "Nix Packages" = {
              urls = [{template = "https://search.nixos.org/packages?channel=unstable&type=packages&query={searchTerms}";}];
              definedAliases = ["@np"];
            };

            "NixOS Options" = {
              urls = [{template = "https://search.nixos.org/options?channel=unstable&type=packages&query={searchTerms}";}];
              definedAliases = ["@no"];
            };

            "Home Manager Options" = {
              urls = [{template = "https://home-manager-options.extranix.com/query={searchTerms}";}];
              definedAliases = ["nixh" "@nixh" "@homemanager"];
            };

            "Bing".metaData.hidden = true;
          };
        };
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
