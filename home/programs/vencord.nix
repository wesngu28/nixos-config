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
      #   notifyAboutUpdates = true;
      #   autoUpdate = false;
      #   autoUpdateNotification = true;
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
        clearURLs.enable = true;
        crashHandler.enable = true;
        dearrow.enable = true;
        favoriteEmojiFirst.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        forceOwnerCrown.enable = true;
        friendsSince.enable = true;
        keepCurrentChannel.enable = true;
        lastFMRichPresence = {
          enable = false;
          shareUsername = false;
          hideWithSpotify = true;
          nameFormat = "artist";
          useListeningStatus = true;
          missingArt = "lastfmLogo";
          showLastFmLogo = true;
        };
        memberCount.enable = true;
        messageLinkEmbeds.enable = true;
        noBlockedMessages.enable = true;
        openInApp.enable = true;
        permissionsViewer.enable = true;
        relationshipNotifier.enable = true;
        reverseImageSearch.enable = true;
        serverInfo.enable = true;
        showConnections.enable = true;
        # showMeYourName = {
        #   enable = true;
        #   mode = "nick-user";
        # };
        unindent.enable = true;
        whoReacted.enable = true;
      };
    };
  };

  home.file.".config/vesktop/settings/settings.json".text = ''    {
        "notifyAboutUpdates": true,
        "autoUpdate": false,
        "autoUpdateNotification": true,
        "useQuickCss": false,
        "enabledThemes": [ "catppuccin-mocha.theme.css" ],
        "enableReactDevtools": false,
        "frameless": false,
        "transparent": false,
        "winCtrlQ": false,
        "disableMinSize": false,
        "winNativeTitleBar": false,
        "plugins": {
            "BadgeAPI": {
                "enabled": true
            },
            "ChatInputButtonAPI": {
                "enabled": false
            },
            "CommandsAPI": {
                "enabled": true
            },
            "ContextMenuAPI": {
                "enabled": true
            },
            "MemberListDecoratorsAPI": {
                "enabled": false
            },
            "MessageAccessoriesAPI": {
                "enabled": false
            },
            "MessageDecorationsAPI": {
                "enabled": false
            },
            "MessageEventsAPI": {
                "enabled": true
            },
            "MessagePopoverAPI": {
                "enabled": true
            },
            "NoticesAPI": {
                "enabled": true
            },
            "ServerListAPI": {
                "enabled": false
            },
            "NoTrack": {
                "enabled": true
            },
            "Settings": {
                "enabled": true,
                "settingsLocation": "aboveActivity"
            },
            "SupportHelper": {
                "enabled": true
            },
            "AlwaysAnimate": {
                "enabled": false
            },
            "AlwaysTrust": {
                "enabled": false
            },
            "AnonymiseFileNames": {
                "enabled": false
            },
            "WebRichPresence (arRPC)": {
                "enabled": false
            },
            "BANger": {
                "enabled": false
            },
            "BetterFolders": {
                "enabled": true,
                "sidebar": true,
                "showFolderIcon": 1,
                "closeAllHomeButton": false,
                "keepIcons": false,
                "sidebarAnim": true,
                "closeOthers": false,
                "closeAllFolders": false,
                "forceOpen": false
            },
            "BetterGifAltText": {
            },
            "BetterGifPicker": {
                "enabled": false
            },
            "BetterNotesBox": {
                "enabled": true,
                "hide": true,
                "noSpellCheck": false
            },
            "BetterRoleContext": {
                "enabled": false
            },
            "BetterRoleDot": {
                "enabled": false,
                "bothStyles": false,
                "copyRoleColorInProfilePopout": false
            },
            "BetterSettings": {
                "enabled": true,
                "disableFade": true,
                "eagerLoad": true,
                "organizeMenu": true
            },
            "BetterUploadButton": {
                "enabled": true
            },
            "BiggerStreamPreview": {
                "enabled": false
            },
            "BlurNSFW": {
                "enabled": false
            },
            "CallTimer": {
                "enabled": true,
                "format": "stopwatch"
            },
            "ClearURLs": {
                "enabled": true
            },
            "ClientTheme": {
                "enabled": false
            },
            "ColorSighted": {
                "enabled": false
            },
            "ConsoleShortcuts": {
                "enabled": false
            },
            "CopyUserURLs": {
                "enabled": false
            },
            "CrashHandler": {
                "enabled": true,
                "attemptToPreventCrashes": true,
                "attemptToNavigateToHome": false
            },
            "CustomRPC": {
                "enabled": false
            },
            "Dearrow": {
                "enabled": true
            },
            "Decor": {
                "enabled": false
            },
            "DisableCallIdle": {
                "enabled": false
            },
            "EmoteCloner": {
                "enabled": false
            },
            "Experiments": {
                "enabled": false
            },
            "F8Break": {
                "enabled": false
            },
            "FakeNitro": {
                "enabled": false
            },
            "FakeProfileThemes": {
                "enabled": false
            },
            "FavoriteEmojiFirst": {
                "enabled": true
            },
            "FavoriteGifSearch": {
                "enabled": false
            },
            "FixCodeblockGap": {
                "enabled": false
            },
            "FixSpotifyEmbeds": {
                "enabled": true,
                "volume": 10
            },
            "FixYoutubeEmbeds": {
                "enabled": false
            },
            "ForceOwnerCrown": {
                "enabled": true
            },
            "FriendInvites": {
                "enabled": false
            },
            "FriendsSince": {
                "enabled": true
            },
            "GameActivityToggle": {
                "enabled": false
            },
            "GifPaste": {
                "enabled": false
            },
            "GreetStickerPicker": {
                "enabled": false
            },
            "HideAttachments": {
                "enabled": false
            },
            "iLoveSpam": {
                "enabled": false
            },
            "IgnoreActivities": {
                "enabled": false
            },
            "ImageZoom": {
                "enabled": false,
                "saveZoomValues": true,
                "invertScroll": true,
                "nearestNeighbour": true,
                "square": false,
                "zoom": 2,
                "size": 100,
                "zoomSpeed": 0.5
            },
            "InvisibleChat": {
                "enabled": false,
                "savedPasswords": "password, Password"
            },
            "KeepCurrentChannel": {
                "enabled": true
            },
            "LastFMRichPresence": {
                "enabled": false,
                "shareUsername": false,
                "hideWithSpotify": true,
                "nameFormat": "artist",
                "useListeningStatus": true,
                "missingArt": "lastfmLogo",
                "showLastFmLogo": true
            },
            "LoadingQuotes": {
                "enabled": false
            },
            "MemberCount": {
                "enabled": true,
                "memberList": true,
                "toolTip": true
            },
            "MessageClickActions": {
                "enabled": false,
                "enableDeleteOnClick": true,
                "enableDoubleClickToEdit": true,
                "enableDoubleClickToReply": true,
                "requireModifier": false
            },
            "MessageLinkEmbeds": {
                "enabled": false,
                "automodEmbeds": "never",
                "listMode": "blacklist",
                "idList": ""
            },
            "MessageLogger": {
                "enabled": false,
                "deleteStyle": "text",
                "logDeletes": true,
                "logEdits": true,
                "ignoreBots": false,
                "ignoreSelf": false,
                "ignoreUsers": "",
                "ignoreChannels": "",
                "ignoreGuilds": ""
            },
            "MessageTags": {
                "enabled": false
            },
            "MoreCommands": {
                "enabled": false
            },
            "MoreKaomoji": {
                "enabled": false
            },
            "MoreUserTags": {
                "enabled": false
            },
            "Moyai": {
                "enabled": false
            },
            "MutualGroupDMs": {
                "enabled": false
            },
            "NewGuildSettings": {
                "enabled": false
            },
            "NoBlockedMessages": {
                "enabled": false
            },
            "NoDevtoolsWarning": {
                "enabled": false
            },
            "NoF1": {
                "enabled": false
            },
            "NoMosaic": {
                "enabled": false
            },
            "NoPendingCount": {
                "enabled": false
            },
            "NoProfileThemes": {
                "enabled": true
            },
            "NoReplyMention": {
                "enabled": false
            },
            "NoScreensharePreview": {
                "enabled": false
            },
            "NoTypingAnimation": {
                "enabled": false
            },
            "NoUnblockToJump": {
                "enabled": false
            },
            "NormalizeMessageLinks": {
                "enabled": false
            },
            "NotificationVolume": {
                "enabled": false
            },
            "NSFWGateBypass": {
                "enabled": false
            },
            "OnePingPerDM": {
                "enabled": false
            },
            "oneko": {
                "enabled": false
            },
            "OpenInApp": {
                "enabled": true,
                "spotify": true,
                "steam": true,
                "epic": false
            },
            "OverrideForumDefaults": {
                "enabled": false
            },
            "Party mode 🎉": {
                "enabled": false
            },
            "PermissionFreeWill": {
                "enabled": false
            },
            "PermissionsViewer": {
                "enabled": false
            },
            "petpet": {
                "enabled": false
            },
            "PictureInPicture": {
                "enabled": false
            },
            "PinDMs": {
                "enabled": false
            },
            "PlainFolderIcon": {
                "enabled": false
            },
            "PlatformIndicators": {
                "enabled": false
            },
            "PreviewMessage": {
                "enabled": false
            },
            "PronounDB": {
                "enabled": false
            },
            "QuickMention": {
                "enabled": false
            },
            "QuickReply": {
                "enabled": false
            },
            "ReactErrorDecoder": {
                "enabled": false
            },
            "ReadAllNotificationsButton": {
                "enabled": false
            },
            "RelationshipNotifier": {
                "enabled": true,
                "notices": false,
                "offlineRemovals": true,
                "friends": true,
                "friendRequestCancels": true,
                "servers": true,
                "groups": true
            },
            "ResurrectHome": {
                "enabled": false
            },
            "RevealAllSpoilers": {
                "enabled": false
            },
            "ReverseImageSearch": {
                "enabled": true
            },
            "ReviewDB": {
                "enabled": false
            },
            "RoleColorEverywhere": {
                "enabled": false
            },
            "SearchReply": {
                "enabled": false
            },
            "SecretRingToneEnabler": {
                "enabled": false
            },
            "SendTimestamps": {
                "enabled": false
            },
            "ServerListIndicators": {
                "enabled": false
            },
            "ServerProfile": {
                "enabled": false
            },
            "ShikiCodeblocks": {
                "enabled": false
            },
            "ShowAllMessageButtons": {
                "enabled": false
            },
            "ShowConnections": {
                "enabled": true,
                "iconSize": 32,
                "iconSpacing": 1
            },
            "ShowHiddenChannels": {
                "enabled": false,
                "hideUnreads": true,
                "showMode": 0,
                "defaultAllowedUsersAndRolesDropdownState": true
            },
            "ShowMeYourName": {
                "enabled": true,
                "mode": "nick-user",
                "displayNames": false,
                "inReplies": false
            },
            "ShowTimeouts": {
                "enabled": false
            },
            "SilentMessageToggle": {
                "enabled": false
            },
            "SilentTyping": {
                "enabled": false,
                "showIcon": false,
                "isEnabled": true
            },
            "SortFriendRequests": {
                "enabled": false
            },
            "SpotifyControls": {
                "enabled": false,
                "hoverControls": false,
                "useSpotifyUris": false
            },
            "SpotifyCrack": {
                "enabled": false
            },
            "SpotifyShareCommands": {
                "enabled": false
            },
            "StartupTimings": {
                "enabled": false
            },
            "SuperReactionTweaks": {
                "enabled": false
            },
            "TextReplace": {
                "enabled": false
            },
            "ThemeAttributes": {
                "enabled": false
            },
            "TimeBarAllActivities": {
                "enabled": false
            },
            "Translate": {
                "enabled": false
            },
            "TypingIndicator": {
                "enabled": false,
                "includeCurrentChannel": true,
                "includeMutedChannels": false,
                "includeBlockedUsers": false,
                "indicatorMode": 3
            },
            "TypingTweaks": {
                "enabled": false
            },
            "Unindent": {
                "enabled": true
            },
            "UnlockedAvatarZoom": {
                "enabled": false
            },
            "UnsuppressEmbeds": {
                "enabled": false
            },
            "UrbanDictionary": {
                "enabled": false
            },
            "UserVoiceShow": {
                "enabled": false
            },
            "USRBG": {
                "enabled": false
            },
            "ValidUser": {
                "enabled": false
            },
            "VoiceChatDoubleClick": {
                "enabled": false
            },
            "VcNarrator": {
                "enabled": false
            },
            "VencordToolbox": {
                "enabled": false
            },
            "ViewIcons": {
                "enabled": false,
                "format": "webp",
                "imgSize": "1024"
            },
            "ViewRaw": {
                "enabled": false,
                "clickMethod": "Left"
            },
            "VoiceMessages": {
                "enabled": false
            },
            "WebContextMenus": {
                "enabled": true,
                "addBack": true
            },
            "WebKeybinds": {
                "enabled": true
            },
            "WhoReacted": {
                "enabled": true
            },
            "Wikisearch": {
                "enabled": false
            },
            "XSOverlay": {
                "enabled": false
            }
        },
        "notifications": {
            "timeout": 5000,
            "position": "bottom-right",
            "useNative": "not-focused",
            "logLimit": 50
        },
        "cloud": {
            "authenticated": false,
            "url": "https://api.vencord.dev/",
            "settingsSync": false,
            "settingsSyncVersion": 1713162574514
        }
      }'';
  home.file.".config/vesktop/settings.json".text = ''    {
        "minimizeToTray": "on",
        "discordBranch": "stable",
        "arRPC": true,
        "splashColor": "rgb(205, 214, 244)",
        "splashBackground": "rgb(30, 30, 46)",
        "customTitleBar": true,
        "splashTheming": true
      }'';

  home.file.".config/vesktop/themes/catppuccin-mocha.theme.css".text = ''
    /**
    * @name Catppuccin Mocha
    * @author winston#0001
    * @authorId 505490445468696576
    * @version 0.2.0
    * @description 🎮 Soothing pastel theme for Discord
    * @website https://github.com/catppuccin/discord
    * @invite r6Mdz5dpFc
    * **/

    @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-lavender.theme.css");
  '';
}
