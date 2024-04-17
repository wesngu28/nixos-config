#!/usr/bin/env bash

sudo rm /etc/nixos/configuration.nix

sudo ln -s ~nixos-config/configuration.nix /etc/nixos/configuration.nix

echo "Configuration.nix symlink created, remember to do something with hardware-configuration"