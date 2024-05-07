{config, ...}: {
  xdg.configFile."fastfetch/config.jsonc".text = ''
    	{
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    		"logo": {
    			"type": "kitty-direct",
    			"source": "${config.home.homeDirectory}/nixos-config/modules/home/cli/rock.png",
    			"width": 34,
    			"height": 17
        },
        "modules": [
            "title",
            "separator",
            {
                "type": "os",
                "key": " OS",
                "keyColor": "yellow",
                "format": "{3}"
            },
            {
                "type": "packages",
                "key": "├󰏖",
                "keyColor": "yellow"
            },
            {
                "type": "kernel",
                "key": "├",
                "keyColor": "yellow"
            },
            {
                "type": "shell",
                "key": "├",
                "keyColor": "yellow"
            },
            {
                "type": "uptime",
                "key": "└󰅐",
                "keyColor": "yellow"
            },
            "break",

            {
                "type": "wm",
                "key": " DE/WM",
                "keyColor": "blue"
            },
            {
                "type": "theme",
                "key": "├󰉼",
                "format": "Catppuccin Mocha Lavender Dark",
                "keyColor": "blue"
            },
            {
                "type": "icons",
                "key": "├󰀻",
                "keyColor": "blue"
            },
            {
                "type": "terminal",
                "key": "├",
                "keyColor": "blue"
            },
            {
                "type": "custom",
                "key": "└󰸉",
                "format": "FiraCode Nerd Font 13.0",
                "keyColor": "blue"
            },
            "break",
            {
                "type": "host",
                "key": "󰌢 PC",
                "keyColor": "green"
            },
            {
                "type": "disk",
                "key": "├",
                "keyColor": "green"
            },
            {
                "type": "memory",
                "key": "└󰑭",
                "keyColor": "green"
            },
            {
                "type": "display",
                "key": "└󰍹",
                "keyColor": "green"
            },
            /*
            "break",
            {
                "type": "player",
                "key": " ",
                "keyColor": "cyan"
            },
            {
                "type": "media",
                "key": "└󰝚",
                "keyColor": "cyan"
            }
            */
        ]
    }
  '';
}
