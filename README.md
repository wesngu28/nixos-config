# nixos-config

A terrible nixos config.

## Hosts

US ww2 carriers

1. [Langley](https://en.wikipedia.org/wiki/USS_Langley_(CV-1)) - (virtualbox host)
2. [Enterprise](https://en.wikipedia.org/wiki/USS_Enterprise_(CV-6)) (primary machine, workstation, gaming)

|                | Program    |
|----------------|------------|
| WM/DE          | Hyprland with waybar, dunst  |
| Terminal       | Kitty        |
| Shell          | zsh with powerlevel10k |
| Editor         | vscode (for now, being skill issued)     |
| Browser        | Firefox, Floorp for vertical secondary|
| Launcher       | Rofi)          |
| Theme          | Catppuccin Mocha (lavender) |
| Music          | Feishin      |
| Notes          | Obsidian      |

3. [Yorktown](https://en.wikipedia.org/wiki/USS_Yorktown_(CV-5)) (laptop)
4. [Essex](https://en.wikipedia.org/wiki/USS_Essex_(CV-9)) (home server)

Secondary home server, primary one still runs Debian but most tasks have been offloaded. Some services:

- Download Client: JDownloader2
- Music Server: Navidrome
- Media Player: Jellyfin
- Paperless NGX
- RSS Reader: FreshRSS

### Installation

Clone repository to /mnt/etc/nixos-config

`sudo nixos-install --flake .#host` or `sudo nixos-install --flake  https://github.com/wesngu28/nixos-config#host`

Post Installation

1. wireguard

    - If host will be accessing server, run wireguard.sh to generate wireguard keys

    - add system pub from /etc/ssh for agenix, add wireguard conf or system

    - scp ~/.ssh/id_ed25519.pub hostname:/home/serpe/.ssh
id_ed25519.pub

2. Finish Syncthing setup

3. Set up waydroid, and run

    whatever the monitor resolution is
    - `waydroid prop set persist.waydroid.width "3440"`
    - `waydroid prop set persist.waydroid.height "1440"`

4. Finish set up of relevant home lab services

5. If the system will commit to github, generate ssh key for it
6. For Floorp (or whatever vertical browser firefox derivative)
    1. Add Betterfox user.js
    2. Install UBlock, Sideberry (better than tst)

### To Do

1. Migrate the primary home server to nix when I am physically at home

2. Starship