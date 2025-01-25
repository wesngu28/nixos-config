{
  pkgs,
  inputs,
  ...
}: {
  home.file.".vscode/argv.json".text = ''
    {
      "enable-crash-reporter": false,
      "password-store": "gnome-libsecret"
    }
  '';

  programs.vscode = {
    enable = true;

    userSettings = {
      # Workbench
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
      "catppuccin.accentColor" = "lavender";
      "workbench.localHistory.maxFileEntries" = 100;
      "workbench.startupEditor" = "none";
      "workbench.tips.enabled" = false;
      "workbench.list.smoothScrolling" = true;
      # "workbench.activityBar.visible" = false;
      "workbench.activityBar.location" = "top";
      "workbench.layoutControl.enabled" = false;
      # "window.menuBarVisibility" = "compact";
      "window.titleBarStyle" = "custom";

      # Git
      "git.autofetch" = true;
      "git.openRepositoryInParentFolders" = "always";
      "scm.countBadge" = "focused";

      # Editor
      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.fontSize" = 14.5;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorWidth" = "3";
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
      "editor.formatOnSave" = true;

      "[html]" = {
        "editor.formatOnSave" = false;
      };

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
      "files.associations" = {
        "*.css" = "tailwindcss";
      };
      "extensions.ignoreRecommendations" = true;

      # Prettier
      "prettier.trailingComma" = "es5";
      "prettier.tabWidth" = 2;
      "prettier.singleQuote" = true;
      "prettier.printWidth" = 120;
      "prettier.arrowParens" = "avoid";
      "prettier.semi" = false;

      "editor.defaultFormatter" = "esbenp.prettier-vscode";

      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
      };

      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[svelte]" = {
        "editor.defaultFormatter" = "svelte.svelte-vscode";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      "vim.useSystemClipboard" = true;

      "typescript.suggest.paths" = false;
      "javascript.suggest.paths" = false;

      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;
    };

    extensions = with pkgs.vscode-extensions;
      [
        jnoortheen.nix-ide
        # catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        ms-vscode-remote.remote-ssh
        mhutchie.git-graph
        svelte.svelte-vscode
        astro-build.astro-vscode
        bradlc.vscode-tailwindcss
        christian-kohler.npm-intellisense
        christian-kohler.path-intellisense
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode
        ms-python.vscode-pylance
        ritwickdey.liveserver
        usernamehw.errorlens
        kamadorueda.alejandra
        mads-hartmann.bash-ide-vscode
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "python";
          publisher = "ms-python";
          version = "latest";
          sha256 = "sha256-MB8Vq2rjO37yW3Zh+f8ek/yz0qT+ZYHn/JnF5ZA6CXQ=";
        }
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "latest";
          sha256 = "sha256-yeX6RAJl07d+SuYyGQFLZNcUzVKAsmPFyTKEn+y3GuM=";
        }
        {
          name = "remote-explorer";
          publisher = "ms-vscode";
          version = "latest";
          sha256 = "sha256-wAxei9TYi23O+KkG6cxoCv9dkJi9FolFTUeDoQCzYB4=";
        }
      ];
  };
}
