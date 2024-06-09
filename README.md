# nixos-config

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

5. [Ranger](https://en.wikipedia.org/wiki/USS_Ranger_(CV-4)) (work virtual machine)

### Installation

- For graphical installer, clone the repository and `sudo nixos-rebuild switch --flake .#host`

- For minimal installer,

    Clone repository to /mnt/etc/nixos-config

    `sudo nixos-install --flake .#host` or `sudo nixos-install --flake  https://github.com/wesngu28/nixos-config#host`

Post Installation

- For Wireguard

    - Run wireguard.sh to generate wireguard keys

    - add system pub from /etc/ssh for agenix, add wireguard conf or system

    - scp ~/.ssh/id_ed25519.pub hostname:/home/serpe/.ssh
id_ed25519.pub

- For Syncthing, accept all the incoming requests and outgoing requests

- For Waydroid, init it with GAPPS, then run below for whatever the monitor resolution is
    - `waydroid prop set persist.waydroid.width "3440"`
    - `waydroid prop set persist.waydroid.height "1440"`

- For home labs, set up of the relevant home lab services

- For github, if the system will commit to github, generate ssh key for it

- For Floorp (or whatever vertical browser firefox derivative)
    1. Add Betterfox user.js
    2. Install UBlock, Sideberry

- For Obsidian, enable custom themes and turn on catppuccin mocha

- For qemu vms, create them with virt-manager or terminal  virt-install

`sudo virt-install \
  --name NAME \
  --ram 4096 \
  --vcpus 2 \
  --os-variant VARIANT \
  --network bridge=br0 \
  --graphics spice \
  --cdrom ISOLOCATION \
  --disk path=/var/lib/libvirt/images/NAMEwork.qcow2,format=qcow2
`

- For vms that might need anyconnect, add it through network manager.

### To Do

1. Migrate the primary home server to nix when I am physically at home

2. Attempt to setup Mod Organizer 2 for skyrim modding. This can be done not the nix way.

3. Starship

4. Use a twm of some kind in the vm preferably