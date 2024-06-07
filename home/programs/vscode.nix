{pkgs, ...}: {
  programs.vscode = {
    enable = true;

    userSettings = {
      # Workbench
      "workbench.colorTheme" = "Catppuccin Mocha";
      "catppuccin.accentColor" = "lavender";
      "workbench.localHistory.maxFileEntries" = 100;
      "workbench.startupEditor" = "none";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.tips.enabled" = false;
      "workbench.list.smoothScrolling" = true;
      # "workbench.activityBar.visible" = false;
      "workbench.activityBar.location" = "hidden";
      "workbench.layoutControl.enabled" = false;
      "window.titleBarStyle" = "custom";

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
      "editor.minimap.enabled" = false;
      "editor.accessibilitySupport" = "off";

      # Terminal
      "terminal.integrated.defaultProfile.linux" = "zsh";
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
      "extensions.ignoreRecommendations" = true;

      # Prettier
      "prettier.trailingComma" = "none";

      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
      };

      "gitblame.inlineMessageEnabled" = true;
      "vim.useSystemClipboard" = true;
    };

    extensions = with pkgs.vscode-extensions;
      [
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
        kamadorueda.alejandra
        waderyan.gitblame
        vscodevim.vim
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
}
