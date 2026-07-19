# dotfiles

Personal dotfiles managed with [GNU stow](https://www.gnu.org/software/stow/).

## Layout

Each config has its own package directory at the repo root. Stow creates symlinks from `$HOME` into these directories.

```
.
├── zsh/                          → ~/.zshrc
├── git/                          → ~/.gitconfig
├── nvim/                         → ~/.config/nvim/
├── ghostty/                      → ~/.config/ghostty/
├── aerospace/                    → ~/.config/aerospace/ (macOS only)
├── lazygit/                      → ~/.config/lazygit/
├── tmux/                         → ~/.config/tmux/
├── starship/                     → ~/.config/starship.toml
├── Brewfile                      → Homebrew packages (not stowed)
├── install-treesitter-parsers.sh → Utility (not stowed)
└── README.md                     → Docs (not stowed)
```

## Getting started

### 1. Clone

```sh
git clone https://github.com/pablomunoz/dotfiles ~/.local/share/dotfiles
```

### 2. Install packages (macOS)

```sh
cd ~/.local/share/dotfiles
brew bundle
```

### 3. Back up existing dotfiles

Stow won't overwrite existing files. Back them up first:

```sh
mkdir -p ~/.dotfiles-backup
for f in ~/.zshrc ~/.gitconfig ~/.config/nvim ~/.config/ghostty \
         ~/.config/lazygit ~/.config/tmux ~/.config/starship.tom; do
  [ -e "$f" ] && mv "$f" ~/.dotfiles-backup/
done
[ -e ~/.config/aerospace ] && mv ~/.config/aerospace ~/.dotfiles-backup/
```

### 4. Deploy

```sh
cd ~/.local/share/dotfiles
stow -t ~ zsh git nvim ghostty lazygit tmux starship

# macOS only
stow -t ~ aerospace
```

## Cheatsheet

```sh
# Deploy all
cd ~/.local/share/dotfiles
stow -t ~ zsh git nvim ghostty lazygit tmux starship
stow -t ~ aerospace                        # macOS only

# Deploy a single package
stow -t ~ git                              # ~/.gitconfig only
stow -t ~ nvim                             # ~/.config/nvim/ only

# Remove symlinks (unstow)
stow -D -t ~ zsh git nvim ghostty lazygit tmux starship

# Unstow a single package
stow -D -t ~ nvim

# Re-stow (remove + re-create)
stow -R -t ~ <package>

# See what stow would do
stow -n -t ~ <package>
```

## Adding a new config

```sh
mkdir -p <name>/<path-under-home>
# place files in <name>/<path-under-home>
stow -t ~ <name>
```

Example:

```sh
mkdir -p kitty/.config/kitty
cp ~/.config/kitty/kitty.conf kitty/.config/kitty/
stow -t ~ kitty
```

## Acknowledgements

Previously managed with [chezmoi](https://www.chezmoi.io/). Migrated to stow for simplicity and reduced dependencies.
