{inputs, ...}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    vesktop.enable = false;
    quickCss = "some CSS";
    config = {
      useQuickCss = true;
      themeLinks = [
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha-lavender.theme.css"
      ];
      enabledThemes = ["catppuccin-mocha.theme.css"];
      frameless = true;
      notifyAboutUpdates = true;
      autoUpdate = false;
      autoUpdateNotification = true;
      enableReactDevtools = false;
      transparent = false;
      disableMinSize = false;
      plugins = {
        anonymiseFileNames.enable = true;
        betterFolders.enable = true;
        betterNotesBox.enable = true;
        betterSettings.enable = true;
        betterUploadButton.enable = true;
        biggerStreamPreview.enable = true;
        callTimer.enable = true;
        ClearURLs.enable = true;
        copyFileContents.enable = true;
        copyStickerLinks.enable = true;
        CopyUserURLs.enable = true;
        crashHandler.enable = true;
        dearrow.enable = true;
        favoriteEmojiFirst.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        forceOwnerCrown.enable = true;
        friendsSince.enable = true;
        keepCurrentChannel.enable = true;
        memberCount.enable = true;
        messageLinkEmbeds.enable = true;
        noBlockedMessages.enable = true;
        noTypingAnimation.enable = true;
        openInApp.enable = true;
        permissionsViewer.enable = true;
        relationshipNotifier.enable = true;
        replyTimestamp.enable = true;
        reverseImageSearch.enable = true;
        serverInfo.enable = true;
        showConnections.enable = true;
        showMeYourName.enable = true;
        unindent.enable = true;
        whoReacted.enable = true;
        validReply.enable = true;
        validUser.enable = true;
      };
    };
  };
}
