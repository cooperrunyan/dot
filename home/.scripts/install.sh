#!/usr/bin/env bash

git -C $(cat $ZSH_HOME/dotfiles) pull --recurse-submodules

git clone --recurse https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_HOME/custom/plugins/zsh-autosuggestions # zsh-autosuggestions

# zsh-syntax-highlighting
git clone --recurse https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_HOME/custom/plugins/zsh-syntax-highlighting

# Powerlevel10k
git clone --recurse https://github.com/romkatv/powerlevel10k.git $ZSH_HOME/custom/themes/powerlevel10k
