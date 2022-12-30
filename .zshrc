#!/usr/bin/env bash

clear

ZSH=~/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  web-search
  macos
  dotenv
  1password
)


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[ -n "$PS1" ] && source ~/.zprofile


source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.config/op/plugins.sh ]] || source ~/.config/op/plugins.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


