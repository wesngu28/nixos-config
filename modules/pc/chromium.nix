{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (chromium.override {
      enableWideVine = true;
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform,WaylandWindowDecorations,WebUIDarkMode"
        "--enable-wayland-ime"

        "--enable-features=AcceleratedVideoEncoder,VaapiOnNvidiaGPUs,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"
        "--enable-features=VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport"
        "--enable-features=UseMultiPlaneFormatForHardwareVideo"
        "--ignore-gpu-blocklist"
        "--enable-zero-copy"

        "--enable-features=CapReferrerToOriginOnCrossOrigin,ClearCrossSiteCrossBrowsingContextGroupWindowName,ContentSettingsPartitioning"
        "--enable-features=HstsTopLevelNavigationsOnly,LocalNetworkAccessChecks:LocalNetworkAccessChecksWarn/false,LocalNetworkAccessChecksWebRTC"
        "--enable-features=PartitionAllocWithAdvancedChecks:enabled-processes/all-processes"
        "--enable-features=PartitionConnectionsByNetworkIsolationKey,ReduceAcceptLanguage"
        "--enable-features=ScopeMemoryCachePerContext"
        "--enable-features=SplitCodeCacheByNetworkIsolationKey,SplitCacheByNetworkIsolationKey,SplitCacheByIncludeCredentials,SplitCacheByNavigationInitiator"
        "--enable-features=StrictOriginIsolation"

        "--disable-features=AllowSwiftShaderFallback,AllowSoftwareGLFallbackDueToCrash"
        "--disable-features=AutofillServerCommunication,BrowsingTopics,BrowsingTopicsDocumentAPI,BrowsingTopicsParameters,InterestFeedV2,NTPPopularSitesBakedInContent,UsePopularSitesSuggestions"
        "--disable-features=LensStandalone,MediaDrmPreprovisioning"
        "--disable-features=OptimizationHints,OptimizationHintsFetching,OptimizationHintsFetchingAnonymousDataConsent,OptimizationPersonalizedHintsFetching,OptimizationGuideModelDownloading,TextSafetyClassifier"
        "--disable-features=PrivacySandboxSettings4,Reporting,CrashReporting,DocumentReporting,TabHoverCardImages"
        "--disable-features=WebGPUBlobCache,WebGPUService"

        "--force-dark-mode"
        "--component-updater=--disable-pings"
        "--disable-breakpad"
        "--disable-crash-reporter"
        "--extension-content-verification=enforce_strict"
        "--extensions-install-verification=enforce_strict"
        "--no-pings"

        "--wm-window-animations-disabled"
        "--animation-duration-scale=0"

        "--disable-sync-preferences"
        "--disable-features=PreloadMediaEngagementData,MediaEngagementBypassAutoplayPolicies"
        "--enable-blink-features=MiddleClickAutoscroll"
        "--enable-features=OverlayScrollbar"
      ];
    })
  ];

  programs.chromium = {
    enable = true;
    homepageLocation = "https://www.startpage.com/";

    extensions = [
      "bkkmolkhemgaeaeggcmfbghljjjoofoh" # Catppuccin Mocha
    ];

    extraOpts = {
      BraveRewardsDisabled = true;
      BraveWalletDisabled = true;
      BraveVPNDisabled = true;
      BraveAIChatEnabled = false;
      BraveNewsDisabled = true;
      BraveTalkDisabled = true;
      BraveSpeedreaderEnabled = false;
      BraveWaybackMachineEnabled = false;
      BraveP3AEnabled = false;
      BraveStatsPingEnabled = false;
      BraveWebDiscoveryEnabled = false;
      BravePlaylistEnabled = false;
      TorDisabled = true;
      SideSearchEnabled = false;
      AllowDinosaurEasterEgg = false;
      BrowserAddPersonEnabled = false;
      BrowserGuestModeEnabled = false;
      BuiltInDnsClientEnabled = false;

      DefaultSearchProviderEnabled = true;
      DefaultSearchProviderName = "Startpage";
      DefaultSearchProvidershortcut = "@start";
      DefaultSearchProviderSearchURL = "https://www.startpage.com/sp/search?query={searchTerms}";
      DefaultSearchProviderSuggestURL = "https://www.startpage.com/suggestions?query={searchTerms}";
      DefaultSearchProviderIconURL = "https://www.startpage.com/favicon.ico";
      DefaultSearchProviderEncodings = ["UTF-8"];
      RestoreOnStartup = 1;
      SiteSearchSettings = [
        {
          name = "Brave Search";
          shortcut = "b";
          url = "https://search.brave.com/search?q={searchTerms}";
        }
        {
          name = "Startpage";
          shortcut = "sp";
          url = "https://www.startpage.com/sp/search?query={searchTerms}";
          Faviconurl = "https://www.startpage.com/favicon.ico";
        }
        {
          name = "GitHub";
          shortcut = "gh";
          url = "https://github.com/search?q={searchTerms}";
        }
        {
          name = "Nix Packages";
          shortcut = "np";
          url = "https://search.nixos.org/packages?channel=unstable&type=packages&query={searchTerms}";
        }
        {
          name = "NixOS Options";
          shortcut = "no";
          url = "https://search.nixos.org/options?channel=unstable&type=packages&query={searchTerms}";
        }
        {
          name = "Home Manager Options";
          shortcut = "nh";
          url = "https://home-manager-options.extranix.com/query={searchTerms}";
        }
        {
          name = "Nix Code";
          shortcut = "nix";
          url = "https://github.com/search?type=code&q=lang%3Anix+{searchTerms}";
        }
        {
          name = "Reddit";
          shortcut = "!reddit";
          url = "https://reddit.com/search?q={searchTerms}";
        }
      ];

      "AIModeSettings" = 1;
      "AutofillPredictionSettings" = 2;
      "AutomatedPasswordChangeSettings" = 2;
      "BuiltInAIAPIsEnabled" = false;
      "CreateThemesSettings" = 2;
      "DevToolsGenAiSettings" = 2;
      "GeminiSettings" = 1;
      "GenAILocalFoundationalModelSettings" = 1;
      "GoogleSearchSidePanelEnabled" = false;
      "HelpMeWriteSettings" = 2;
      "HistorySearchSettings" = 2;
      "TabCompareSettings" = 2;

      "AlternateErrorPagesEnabled" = false;
      "AudioSandboxEnabled" = true;
      "AutofillAddressEnabled" = false;
      "AutofillCreditCardEnabled" = false;
      "BackgroundModeEnabled" = false;
      "BlockExternalExtensions" = true;
      "BlockThirdPartyCookies" = true;
      "BrowserLabsEnabled" = false;
      "BrowserSignin" = 0;
      "ChromeVariations" = 2;
      "ClickToCallEnabled" = false;
      "CloudPrintProxyEnabled" = false;
      "DefaultBrowserSettingEnabled" = false;
      # "DefaultJavaScriptJitSetting" = 2;
      "DefaultSensorsSetting" = 2;
      "DefaultWebUsbGuardSetting" = 2;
      "DesktopSharingHubEnabled" = false;
      # "Disable3DAPIs" = true;
      "DnsOverHttpsMode" = "automatic";
      "EnableMediaRouter" = false;
      "ExtensionAllowedTypes" = [
        "extension"
        "theme"
      ];
      "ExtensionDeveloperModeSettings" = 1;
      "ExtensionInstallAllowlist" = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh"
        # UBlock Lite, don't install for brave automatically

        "mnjggcdmjocbbbhaepdhchncahnbgone"
        # SponsorBlock

        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden

        "dhdgffkkebhmkfjojejmpbldmpobfkfo" # TamperMonkey

        "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus
      ];
      "ExtensionInstallBlocklist" = ["*"];
      "HardwareAccelerationModeEnabled" = true;
      "HistoryClustersVisible" = false;
      "HttpsOnlyMode" = "force_enabled";
      "LensOverlaySettings" = 1;
      "LensRegionSearchEnabled" = false;
      "LiveTranslateEnabled" = false;
      "MediaRecommendationsEnabled" = false;
      "MetricsReportingEnabled" = false;
      "NativeMessagingBlocklist" = ["*"];
      "NetworkPredictionOptions" = 2;
      "NetworkServiceSandboxEnabled" = true;
      "NTPCardsVisible" = false;
      "PasswordLeakDetectionEnabled" = false;
      "PasswordManagerEnabled" = false;
      "PaymentMethodQueryEnabled" = false;
      "PrivacySandboxAdMeasurementEnabled" = false;
      "PrivacySandboxAdTopicsEnabled" = false;
      "PrivacySandboxPromptEnabled" = false;
      "PrivacySandboxSiteEnabledAdsEnabled" = false;
      "PromotionsEnabled" = false;
      "PromptForDownloadLocation" = true;
      # "ProtectedContentIdentifiersAllowed" = false;
      "RelatedWebsiteSetsEnabled" = false;
      "RemoteAccessHostAllowRemoteAccessConnections" = false;
      "RemoteAccessHostAllowRemoteSupportConnections" = false;
      "RemoteAccessHostFirewallTraversal" = false;
      "RemoteDebuggingAllowed" = false;
      "SafeBrowsingDeepScanningEnabled" = false;
      "SafeBrowsingExtendedReportingEnabled" = false;
      "SafeBrowsingProtectionLevel" = 1;
      "SafeBrowsingSurveysEnabled" = false;
      "SearchSuggestEnabled" = false;
      "SharedClipboardEnabled" = false;
      "ShoppingListEnabled" = false;
      "ShowFullUrlsInAddressBar" = true;
      "SitePerProcess" = true;
      "SpellCheckServiceEnabled" = false;
      "SyncDisabled" = true;
      "TLS13EarlyDataEnabled" = false;
      "TranslateEnabled" = false;
      "TranslatorAPIAllowed" = false;
      "UrlKeyedAnonymizedDataCollectionEnabled" = false;
      "UrlKeyedMetricsAllowed" = false;
      "UserAgentReduction" = 2;
      "UserFeedbackAllowed" = false;
      "WebRtcIPHandling" = "disable_non_proxied_udp";
      "WebRtcTextLogCollectionAllowed" = false;
      "WebUsbAskForUrls" = ["https://grapheneos.org"];
    };
  };
}
