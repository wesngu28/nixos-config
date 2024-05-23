#!/usr/bin/env bash
if [ $# -ne 1 ]; then
  echo "Usage: $0 <hostname"
  exit 1
fi


hostname="$1"

cd ~/nixos-config/hosts

mkdir $hostname

sudo rm /etc/nixos/configuration.nix

cp /etc/nixos/configuration.nix ~/nixos-config/hosts/$hostname/configuration.nix

sudo ln -s ~/nixos-config/hosts/$hostname/configuration.nix /etc/nixos/configuration.nix

cp /etc/nixos/hardware-configuration.nix ~/nixos-config/hosts/$hostname/

sudo rm /etc/nixos/hardware-configuration.nix

echo "Configuration.nix symlink created, remember to do something with hardware-configuration"
