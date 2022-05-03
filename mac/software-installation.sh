#!/bin/zsh

# ╔════════════════════╗
# ║   Install macOS    ║
# ║      Software      ║
# ╚════════════════════╝

# Install Homebrew
if [[ ! $(which brew) ]]; then
  echo -e "Homebrew not installed, installing now..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Homebrew packages
if [[ ! "$(brew bundle check --file=${DOTFILES_INSTALLER}/homebrew/Brewfile)" ]]; then
  echo -e "Installing Homebrew packages... \n\n"
  brew bundle --file=${DOTFILES_INSTALLER}/homebrew/Brewfile &&\
  brew cleanup
fi