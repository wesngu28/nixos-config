# nixos-config

A terrible nixos config.

### --impure / out of band

Maybe set up git crypt or some other solution with these at some point? Still needs out of band elements regardless

1. Wireguard

Run wireguard.sh

Public IP - two separate wireguard servers, most devices only need one

Server public key - not needed to be hidden I guess but for comfort

Run bad_secret_management.sh to have git ignore it because secrets haven't been set up.

2. github_key.sh - run to generate and get public key for github cloning

3. Server certificate authorities

Waydroid

waydroid prop set persist.waydroid.width "3440"
waydroid prop set persist.waydroid.height "1440"