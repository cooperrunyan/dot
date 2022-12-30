#!/usr/bin/env bash

# Dotfiles
git -C $(cat $ZSH_HOME/dotfiles) pull --recurse-submodules

sh "$(cat $ZSH_HOME/dotfiles)/setup.sh"

# Plugins
git -C $ZSH_HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions pull
git -C $ZSH_HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting pull
git -C $ZSH_HOME/.oh-my-zsh/custom/themes/powerlevel10k pull
