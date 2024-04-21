{pkgs, ...}: {
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

      # Prettier
      "prettier.trailingComma" = "none";

      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
      };
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
        eamodio.gitlens
        kamadorueda.alejandra
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
