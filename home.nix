{ config, pkgs, inputs, ... }:

{
  home.username = "serpe";
  home.homeDirectory = "/home/serpe";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    gimp
    vesktop
    obsidian
    jellyfin-media-player

    #steam
    #lutris
    #waydroid
    #nicotine-plus
    #veracrypt

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.git = {
    enable = true;
    userName = "wesngu28";
    userEmail = "wesley@wesngu28.com";
  };

  nixpkgs.config.allowUnfree = true;

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
          web-scrobbler
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

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    userSettings = {

      # Workbench
      "workbench.colorTheme" = "Catppuccin Mocha";
      "catppuccin.accentColor" = "lavender";
      "workbench.localHistory.maxFileEntries" = 100;
      "workbench.startupEditor" = "none";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.tips.enabled" = false;
      "workbench.list.smoothScrolling" = true;

      # Git
      "git.autofetch" = true;
      "git.openRepositoryInParentFolders" = "always";
      "scm.countBadge" = "focused";

      # Editor
      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.fontSize" = 14.5;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorWidth" = 4;
      "editor.fontFamily" = "Fira Code";
      "editor.fontLigatures" = true;
      "editor.guides.bracketPairs" = "active";
      "editor.guides.indentation" = false;
      "editor.lineHeight" = 1.45;
      "editor.linkedEditing" = true;
      "editor.minimap.renderCharacters" = false;
      "editor.smoothScrolling" = true;
      "editor.unicodeHighlight.invisibleCharacters" = true;
      "explorer.compactFolders" = false;
      "breadcrumbs.enabled" = false;

      # Terminal
      "terminal.integrated.enableMultiLinePasteWarning" = "never";
      "terminal.integrated.fontFamily" = "FiraCode Nerd Font";

      # Behaviors
      "telemetry.telemetryLevel" = "off";
      "security.workspace.trust.untrustedFiles" = "open";
      "update.mode" = "start";
      "extensions.autoUpdate" = false;

      "window.openFilesInNewWindow" = "default";
      "window.commandCenter" = false;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;

      # Search
      "search.collapseResults" = "auto";
      "search.exclude" = {
          "**/venv" = true;
      };

      # Files
      "files.insertFinalNewline" = false;
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;

      # Prettier
      "prettier.trailingComma" = "none";

    };

    extensions = with pkgs.vscode-extensions; [
     jnoortheen.nix-ide
     catppuccin.catppuccin-vsc
     ms-vscode-remote.remote-ssh
     pkief.material-icon-theme
     mhutchie.git-graph
     svelte.svelte-vscode
     astro-build.astro-vscode
     bradlc.vscode-tailwindcss
     shd101wyy.markdown-preview-enhanced
     christian-kohler.npm-intellisense
     christian-kohler.path-intellisense
     dbaeumer.vscode-eslint
     esbenp.prettier-vscode
     ms-python.python
     ms-python.vscode-pylance
     ritwickdey.liveserver
     usernamehw.errorlens
     eamodio.gitlens
   ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.86.0";
        sha256 = "sha256-JsbaoIekUo2nKCu+fNbGlh5d1Tt/QJGUuXUGP04TsDI=";
      }
      {
        name = "remote-explorer";
        publisher = "ms-vscode";
        version = "0.5.2024031109";
        sha256 = "sha256-t8CeOuoCaK8ecJqMXRx8kA4CtP0x4srcn2SCez5tHOU=";
      }
    ];

  };

	home.file.".config/vesktop/settings/settings.json".text = ''{
    "notifyAboutUpdates": true,
    "autoUpdate": false,
    "autoUpdateNotification": true,
    "useQuickCss": false,
    "themeLinks": [
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha-lavender.theme.css"
    ],
    "enabledThemes": [],
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
            "enabled": false
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
            "statusName": "some music",
            "nameFormat": "status-name",
            "useListeningStatus": false,
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
            "enabled": false
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
            "enabled": true,
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
	home.file.".config/vesktop/settings.json".text = ''{
    "minimizeToTray": "on",
    "discordBranch": "stable",
    "arRPC": true,
    "splashColor": "rgb(205, 214, 244)",
    "splashBackground": "rgb(30, 30, 46)",
    "customTitleBar": true,
    "splashTheming": true
  }'';

  programs.home-manager.enable = true;
}
