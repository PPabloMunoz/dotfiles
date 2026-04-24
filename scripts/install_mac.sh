#!/bin/sh
set -eu

if command -v brew >/dev/null 2>&1; then
  echo "Installing packages from Brewfile..."
  # Get the directory where the script is located
  SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
  brew bundle --file="$SCRIPT_DIR/Brewfile"

else
  echo "Homebrew not found. Please install it first from https://brew.sh/"
  exit 1
fi
