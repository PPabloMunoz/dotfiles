#!/bin/sh
set -eu

if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [ "$ID" = "ubuntu" ] || [ "$ID_LIKE" = "debian" ]; then
    echo "Installing packages with apt..."
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y \
      build-essential \
      gpg \
      unzip \
      wget \
      curl \
      git \
      zsh \
      starship \
      bat \
      fd-find \
      fzf \
      jq \
      htop \
      ripgrep

    echo "Installing carapace..."
    sudo touch /etc/apt/sources.list.d/fury.list
    echo "deb [trusted=yes] https://apt.fury.io/rsteube/ /" | sudo tee -a /etc/apt/sources.list.d/fury.list
    sudo apt-get update 
    sudo apt-get install -y carapace-bin

    echo "Installing snapd..."
    sudo apt install -y snapd

    echo "Installing nvim..."
    sudo snap install nvim --classic

    echo "Installing eza..."
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
    sudo apt install -y eza

    echo "Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

    echo "Installing chezmoi..."
    sudo snap install chezmoi --classic
  else
    echo "This script only supports Ubuntu/Debian based distributions."
    exit 1
  fi
else
  echo "/etc/os-release not found."
  exit 1
fi
