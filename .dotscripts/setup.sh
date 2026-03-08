#!/bin/bash
set -euo pipefail

if command -v starship &>/dev/null; then
  mkdir -p "$HOME/.config"
  starship preset gruvbox-rainbow -o "$HOME/.config/starship.toml"
else
  echo "WARNING: starship not found, skipping starship config. Install it from https://starship.rs"
fi
