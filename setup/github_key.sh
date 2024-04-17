#!/usr/bin/env bash

ssh-keygen -t ed25519 -C "wesley@wesngu28.com" -f ~/.ssh/id_ed25519

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_ed25519

xclip -sel clip < ~/.ssh/id_ed25519.pub

sudo chmod 400 ~/.ssh/id_ed25519

echo "SSH key generated, added to SSH agent, and public key copied to clipboard."