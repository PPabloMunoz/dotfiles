#!/bin/sh
set -eu

# =============================================================================
# macOS Installation (uses Homebrew)
# =============================================================================
if command -v brew >/dev/null 2>&1; then
  echo "Installing packages from Brewfile..."
  brew bundle --file="$(dirname "$0")/Brewfile"
else
  echo "Homebrew not found. Please install it first from https://brew.sh/"
  exit 1
fi

# =============================================================================
# Linux Packages (Ubuntu/Debian)
# Install the following packages via your preferred method (apt, snap, etc.):
#
# build-essential
# gpg
# unzip
# wget
# curl
# git
# zsh
# bat
# jq
# htop
# ripgrep
# coreutils
# findutils
# gnupg
# gzip
# libpq-dev
# starship
# fd-find
# fzf
# eza
# zoxide
# carapace-bin
# snapd
# nvim
# chezmoi
# fnm
# pnpm
# node
# tmux
# just
# fastfetch
# lazygit
# glow
# iperf3
# 1password-cli
# ghostty
# aerospace
# orbstack
# raycast
# spotify
# stats
# air
# go-blueprint
# golangci-lint
# gopls
# =============================================================================