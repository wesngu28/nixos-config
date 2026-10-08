{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  home.file.".vscode/argv.json".text = ''
    {
      "enable-crash-reporter": false,
      "password-store": "gnome-libsecret",
      "enable-proposed-api": [
        "jeanp413.open-remote-ssh"
      ]
    }
  '';

  home.file.".vscode-oss/argv.json".text = ''
    {
      "enable-crash-reporter": false,
      "password-store": "gnome-libsecret",
      "enable-proposed-api": [
        "jeanp413.open-remote-ssh"
      ]
    }
  '';

  programs.vscodium = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      catppuccin.catppuccin-vsc
      # catppuccin.catppuccin-vsc-icons
      mhutchie.git-graph
      svelte.svelte-vscode
      astro-build.astro-vscode
      bradlc.vscode-tailwindcss
      christian-kohler.npm-intellisense
      christian-kohler.path-intellisense
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
      ms-python.python
      ms-python.vscode-pylance
      ritwickdey.liveserver
      usernamehw.errorlens
      kamadorueda.alejandra
      mads-hartmann.bash-ide-vscode
    ];

    profiles.default.userSettings = {
      "workbench.localHistory.maxFileEntries" = 100;
      "workbench.startupEditor" = "none";
      "workbench.tips.enabled" = false;
      "workbench.list.smoothScrolling" = true;
      "workbench.activityBar.location" = "default";
      "workbench.layoutControl.enabled" = false;

      "window.titleBarStyle" = "custom";

      "git.autofetch" = true;
      "git.openRepositoryInParentFolders" = "always";
      "scm.countBadge" = "focused";

      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.fontSize" = 14.5;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorWidth" = 3;
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
        "**/node_modules" = true;
        "**/.git" = true;
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

      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;

      "chat.agent.enabled" = false;
      "chat.disableAIFeatures" = true;

      "claudeCode.disableLoginPrompt" = true;

      "json.schemaDownload.trustedDomains" = {
        "https://raw.githubusercontent.com/" = true;
      };

      "workbench.settings.editor" = "ui";
    };
  };

  programs.vscode = {
    enable = false;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      catppuccin.catppuccin-vsc
      # catppuccin.catppuccin-vsc-icons
      ms-vscode-remote.remote-ssh
      ms-vscode.remote-explorer
      mhutchie.git-graph
      svelte.svelte-vscode
      astro-build.astro-vscode
      bradlc.vscode-tailwindcss
      christian-kohler.npm-intellisense
      christian-kohler.path-intellisense
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
      ms-python.python
      ms-python.vscode-pylance
      ritwickdey.liveserver
      usernamehw.errorlens
      kamadorueda.alejandra
      mads-hartmann.bash-ide-vscode
    ];

    profiles.default.userSettings = {
      "workbench.localHistory.maxFileEntries" = 100;
      "workbench.startupEditor" = "none";
      "workbench.tips.enabled" = false;
      "workbench.list.smoothScrolling" = true;
      "workbench.activityBar.location" = "default";
      "workbench.layoutControl.enabled" = false;

      "window.titleBarStyle" = "custom";

      "git.autofetch" = true;
      "git.openRepositoryInParentFolders" = "always";
      "scm.countBadge" = "focused";

      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.fontSize" = 14.5;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorWidth" = 3;
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
        "**/node_modules" = true;
        "**/.git" = true;
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

      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;

      "chat.agent.enabled" = false;
      "chat.disableAIFeatures" = true;

      "claudeCode.disableLoginPrompt" = true;

      "json.schemaDownload.trustedDomains" = {
        "https://raw.githubusercontent.com/" = true;
      };
    };
  };

  home.activation.makeVSCodeConfigWritable = let
    configDirName =
      {
        vscode = "Code";
        vscode-insiders = "Code - Insiders";
        vscodium = "VSCodium";
      }.${
        config.programs.vscodium.package.pname
      };

    configPath = "${config.xdg.configHome}/${configDirName}/User/settings.json";
  in
    lib.hm.dag.entryAfter ["linkGeneration"] ''
      target="$(readlink -f '${configPath}')"
      install -m 0640 "$target" '${configPath}'
    '';
}
