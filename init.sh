#!/usr/bin/env bash

export DOTFILES_INSTALLER="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Install oh-my-zsh
if [[ ! -d $HOME/.oh-my-zsh ]]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # This ensures that if `~/.zshrc` already exists, to delete & rerun install to create symlinks
  # Will require on first run to `exit` out of zsh for install script to keep running (not within a dev-container though!)
  if [[ ! -L $HOME/.zshrc ]]; then
    rm ~/.zshrc &&\
    ./install
  fi
fi

# Install zsh-autosuggestions plugin: https://github.com/zsh-users/zsh-autosuggestions
if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting plugin: https://github.com/zsh-users/zsh-syntax-highlighting
if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install Pure: https://github.com/sindresorhus/pure
if [[ ! -d "$HOME/.zsh" ]]; then
  mkdir -p "$HOME/.zsh"
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

# Mac-specific dependencies
if [[ $(uname) = Darwin ]]; then
  # Install FZF: https://github.com/junegunn/fzf
  if [[ ! -d "$HOME/.fzf" ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install --all --no-zsh
  fi

  source ./mac/mac-setup.sh
fi

unset DOTFILES_INSTALLER