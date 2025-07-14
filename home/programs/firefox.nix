{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;

    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      # DNSOverHTTPS = {
      #   Enabled = false;
      #   Locked = true;
      # };
      EnableTrackingProtection = true;
      FirefoxHome = {
        Highlights = false;
        Pocket = false;
        Snippets = false;
        SponsoredPocket = false;
        SponsoredTopSites = false;
      };
      NetworkPrediction = false;
      NoDefaultBookmarks = true;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      SearchBar = "unified";
      SearchSuggestEnabled = false;

      Preferences = {
        "general.autoScroll" = true;

        # Arkenfox
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;

        "browser.startup.page" = 3;
        "browser.startup.homepage" = "about:blank";
        "browser.newpage.enabled" = false;

        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.default.sites" = false;

        "geo.provider.use_geoclue" = false;

        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.shopping.experience2023.enabled" = false;

        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";

        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

        "captivedetect.canonicalURL" = false;
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;

        "browser.safebrowsing.downloads.remote.enabled" = false;

        "network.prefetch-next" = false;
        "network.predictor.enabled" = false;
        "network.predictor.enable-prefetch" = false;
        "network.http.speculative-parallel-limit" = 0;
        "browser.places.speculativeConnect.enabled" = false;

        "network.proxy.socks_remote_dns" = true;
        "network.file.disable_unc_paths" = true;
        "network.gio.supported-protocols" = "";

        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.search.suggest.enabled" = false;
        "browser.search.suggest.searches" = false;
        "browser.urlbar.quicksuggest.dataCollection.enabled" = false;
        "browser.urlbar.trending.featureGate" = false;
        "browser.urlbar.addons.featureGate" = false;
        "browser.urlbar.pocket.featureGate" = false;
        "browser.urlbar.weather.featureGate" = false;
        "browser.urlbar.yelp.featureGate" = false;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;
        "browser.urlbar.update2.engineAliasRefresh" = true;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;

        "signon.autofillForms" = false;
        "signon.formlessCapture.enabled" = false;
        "signon.privateBrowsingCapture.enabled" = false;
        "network.auth.subresource-http-auth-allow" = 1;

        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        # "browser.sessionstore.privacy_level" = 2;

        "security.ssl.require_safe_negotiation" = true;
        "security.cert_pinning.enforcement_level" = 2;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.pki.crlite_mode" = 2;
        "security.tls.enable_0rtt_data" = false;

        # "dom.security.https_only_mode" = true;
        "dom.security.https_first" = true;
        "dom.security.https_first_schemeless" = true;
        "dom.security.https_only_mode_error_page_user_suggestions" = true;
        "dom.security.https_only_mode_send_http_background_request" = false;

        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;

        "network.http.referer.XOriginTrimmingPolicy" = 2;

        "privacy.userContext.ui.enabled" = true;

        "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
        "media.peerconnection.ice.default_address_only" = true;

        "dom.disable_window_move_resize" = true;

        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.uitour.enabled" = false;
        "permissions.manager.defaultsUrl" = "";
        "webchannel.allowObject.urlWhitelist" = "";
        "network.IDN_show_punycode" = true;
        "pdfjs.disabled" = false;
        "pdfjs.enableScripting" = false;
        "browser.contentanalysis.default_allow" = false;

        # "browser.download.useDownloadDir" = false;
        "browser.download.alwaysOpenPanel" = false;
        # "browser.download.manager.addToRecentDocs" = false;
        # "browser.download.always_ask_before_handling_new_types" = true;

        "extensions.enabledScopes" = 5;
        "extensions.postDownloadThirdPartyPrompt" = false;

        "browser.contentblocking.category" = "strict";

        # Fastfox

        # test
        # "nglayout.initialpaint.delay" = 5;
        # "content.notify.interval" = 100000;
        "browser.cache.jsbc_compression_level" = 3;
        "media.memory_cache_max_size" = 65336;

        "gfx.canvas.accelerated.cache-items" = 4096;
        "gfx.canvas.accelerated.cache-size" = 512;
        "gfx.content.skia-font-cache-size" = 20;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.cache_readahead_limit" = 7200;
        "media.cache_resume_threshold" = 3600;
        "image.mem.decode_bytes_at_a_time" = 32768;

        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;
        "network.http.pacing.requests.enabled" = false;
        "network.dnsCacheExpiration" = 3600;
        "network.ssl_tokens_cache_capacity" = 10240;

        "layout.css.grid-template-masonry-value.enabled" = true;
        "dom.enable_web_task_scheduling" = true;
        "layout.css.has-selector.enabled" = true;
        "dom.security.sanitizer.enabled" = true;
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;

        # Securefox
        "network.cookie.sameSite.noneRequiresSecure" = true;
        "privacy.globalprivacycontrol.enabled" = true;
        "security.OCSP.enabled" = 0;
        # "security.OCSP.required" = true;

        "browser.sessionstore.interval" = 60000;

        "privacy.history.custom" = true;
        "security.insecure_connection_text.enabled" = true;
        "security.insecure_connection_text.pbmode.enabled" = true;

        "editor.truncate_user_pastes" = false;
        "security.mixed_content.block_display_content" = true;
        "security.mixed_content.upgrade_display_content" = true;
        "security.mixed_content.upgrade_display_content.image" = true;

        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;

        # Scrolling
        "apz.overscroll.enabled" = true;
        "general.smoothScroll" = true;
        "general.smoothScroll.msdPhysics.enabled" = true;
        "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
        "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
        "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
        "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = 2;
        "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
        "general.smoothScroll.currentVelocityWeighting" = 1;
        "general.smoothScroll.stopDecelerationWeighting" = 1;
        "mousewheel.default.delta_multiplier_y" = 300;

        # Peskyfox

        "browser.privatebrowsing.vpnpromourl" = "";
        "browser.preferences.moreFromMozilla" = false;
        "browser.tabs.tabmanager.enabled" = false;
        "browser.profiles.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.compactmode.show" = true;
        "browser.display.focus_ring_on_anything" = true;
        "browser.display.focus_ring_style" = 0;
        "browser.display.focus_ring_width" = 0;
        "layout.css.prefers-color-scheme.content-override" = 2;
        "browser.privateWindowSeparation.enabled" = false;
        "browser.search.separatePrivateDefault" = true;
        "browser.search.separatePrivateDefault.ui.enabled" = true;
        "cookiebanners.service.mode" = 1;
        "cookiebanners.service.mode.privateBrowsing" = 1;
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.delay" = -1;
        "full-screen-api.warning.timeout" = 0;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.download.open_pdf_attachments_inline" = true;
        "browser.bookmarks.openInTabClosesMenu" = false;
        "browser.menu.showViewImageInfo" = true;
        "findbar.highlightAll" = true;
        "layout.word_select.eat_space_to_next_word" = false;
        "reader.parse-on-load.enabled" = false;
        "browser.bookmarks.max_backups" = 3;
        # "layout.spellcheckDefault" = 0;
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        extensions = {
          force = true;
          packages = with inputs.firefox-addons.packages.${pkgs.system}; [
            auto-tab-discard
            bitwarden
            firefox-color
            libredirect
            stylus
            violentmonkey
          ];
        };

        search = {
          default = "Brave Search";
          order = ["Brave Search" "StartPage" "ddg"];
          force = true;

          engines = {
            "Brave Search" = {
              urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
              definedAliases = ["@b"];
            };

            "Start Page" = {
              urls = [{template = "https://www.startpage.com/sp/search?query={searchTerms}";}];
              definedAliases = ["@sp"];
            };

            "GitHub" = {
              urls = [{template = "https://github.com/search?q={searchTerms}";}];
              definedAliases = ["@gh"];
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
              definedAliases = ["@nh"];
            };

            "bing".metaData.hidden = true;
            "google".metaData.hidden = true;
            "amazondotcom-us".metaData.hidden = true;
            "ebay".metaData.hidden = true;
          };
        };
      };

      containerd = {
        id = 1;
        name = "containers";
        extensions = {
          force = true;
          packages = with inputs.firefox-addons.packages.${pkgs.system}; [
            violentmonkey
          ];
        };
        settings = {
          ui.prefersReducedMotion = "1";
          browser.tabs.allowTabDetach = false;
        };
        userChrome = ''
          .titlebar-min {display:none!important;}
          .titlebar-max {display:none!important;}
          .titlebar-restore {display:none!important;}
          .titlebar-close {display:none!important;}
        '';
      };

      treetabs = {
        id = 2;
        name = "treetabs";
        extensions = {
          force = true;
          packages = with inputs.firefox-addons.packages.${pkgs.system}; [
            bitwarden
            sidebery
          ];
        };
        userChrome = ''
          #TabsToolbar {
              visibility: collapse;
            }
          .titlebar-min {display:none!important;}
          .titlebar-max {display:none!important;}
          .titlebar-restore {display:none!important;}
          .titlebar-close {display:none!important;}
           #tabbrowser-tabs .tabbrowser-tab .tab-close-button {display:none!important}
        '';
      };

      work = {
        id = 3;
        name = "work";
        settings = {
          ui.prefersReducedMotion = "1";
        };
        userChrome = ''
          .titlebar-min {display:none!important;}
          .titlebar-max {display:none!important;}
          .titlebar-restore {display:none!important;}
          .titlebar-close {display:none!important;}
        '';
      };
    };
  };
}
