#!/usr/bin/env bash
sudo nixos-rebuild switch --option eval-cache false --flake ~/nix/#$1
