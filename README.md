# nixos-config

A terrible nixos config.

## Hosts

1. [Langley](https://en.wikipedia.org/wiki/USS_Langley_(CV-1)) (virtualbox host)
  testing environment
3. [Enterprise](https://en.wikipedia.org/wiki/USS_Enterprise_(CV-6)) (primary machine, workstation, gaming)
  most battle stars, the workhorse
4. [Yorktown](https://en.wikipedia.org/wiki/USS_Yorktown_(CV-5))
   laptops
6. [Essex](https://en.wikipedia.org/wiki/USS_Essex_(CV-9)) (home server)

### Installation

Clone repository to /mnt/etc/nixos-config

`sudo nixos-install --flake .#host` or `sudo nixos-install --flake  https://github.com/wesngu28/nixos-config#host`

Post Installation

1. wireguard

    - If host will be accessing server, run wireguard.sh to generate wireguard keys

    - ssh-key-scan and add system or ssh-keygen for agenix, add wireguard conf or system

2. Finish Syncthing setup

3. Set up waydroid, and run

    whatever the monitor resolution is
    - `waydroid prop set persist.waydroid.width "3440"`
    - `waydroid prop set persist.waydroid.height "1440"`

4. Finish set up of relevant home lab services

5. If the system will commit to github, generate ssh key for it

### To Do

1. Migrate the primary home server to nix when I am physically at home

2. Starship