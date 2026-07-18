{pkgs, ...}: {
  home.packages = [
    (pkgs.discord.override {withVencord = true;})
  ];

  home.file.".config/Vencord/settings/settings.json".text = builtins.toJSON {
    notifyAboutUpdates = true;
    autoUpdate = false;
    autoUpdateNotification = true;
    useQuickCss = true;
    enabledThemes = ["catppuccin-mocha.theme.css"];
    enableReactDevtools = false;
    plugins = {
      AnonymiseFileNames.enabled = true;
      BetterFolders = {
        enabled = true;
        sidebar = true;
        showFolderIcon = 1;
        closeAllHomeButton = false;
        keepIcons = false;
        sidebarAnim = true;
        closeOthers = false;
        closeAllFolders = false;
        forceOpen = false;
      };
      BetterSettings = {
        enabled = true;
        disableFade = true;
        eagerLoad = true;
        organizeMenu = true;
      };
      BetterUploadButton.enabled = true;
      BiggerStreamPreview.enabled = true;
      CallTimer = {
        enabled = true;
        format = "stopwatch";
      };
      ClearURLs.enabled = true;
      CopyFileContents.enabled = true;
      CopyStickerLinks.enabled = true;
      CopyUserURLs.enabled = true;
      CrashHandler = {
        enabled = true;
        attemptToPreventCrashes = true;
        attemptToNavigateToHome = false;
      };
      Dearrow.enabled = true;
      FavoriteEmojiFirst.enabled = true;
      FixImagesQuality.enabled = true;
      FixSpotifyEmbeds = {
        enabled = true;
        volume = 10;
      };
      FixYoutubeEmbeds.enabled = true;
      ForceOwnerCrown.enabled = true;
      FriendsSince.enabled = true;
      KeepCurrentChannel.enabled = true;
      MemberCount = {
        enabled = true;
        memberList = true;
        toolTip = true;
      };
      MessageLinkEmbeds = {
        enabled = true;
        automodEmbeds = "never";
        listMode = "blacklist";
        idList = "";
      };
      NoBlockedMessages.enabled = true;
      NoTypingAnimation.enabled = true;
      OpenInApp = {
        enabled = true;
        spotify = true;
        steam = true;
        epic = false;
      };
      PermissionsViewer.enabled = true;
      RelationshipNotifier = {
        enabled = true;
        notices = false;
        offlineRemovals = true;
        friends = true;
        friendRequestCancels = true;
        servers = true;
        groups = true;
      };
      ReplyTimestamp.enabled = false;
      ReverseImageSearch.enabled = true;
      ServerInfo.enabled = true;
      ShowConnections = {
        enabled = true;
        iconSize = 32;
        iconSpacing = 1;
      };
      # ShowMeYourName.enabled = true;
      Unindent.enabled = true;
      WhoReacted.enabled = true;
      ValidReply.enabled = true;
      ValidUser.enabled = true;
    };
  };

  home.file.".config/Vencord/settings/quickCss.css".text = "some CSS";

  home.file.".config/Vencord/themes/catppuccin-mocha.theme.css".text = ''
    @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-lavender.theme.css");
  '';
}
