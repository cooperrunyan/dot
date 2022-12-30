#!/usr/bin/env bash

clear

export ZSH_HOME="${ZSH_HOME:-$HOME}"

ZSH=$ZSH_HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

HISTSIZE=10000
SAVEHIST=9000
HISTFILE=$ZSH_HOME/.zsh_history

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
if [[ -r "$HOME/.cache/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$HOME/.cache/p10k-instant-prompt-${(%):-%n}.zsh"
fi

for file in $ZSH_HOME/{path,env,aliases,functions,.p10k}.zsh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.config/op/plugins.sh ]] || source ~/.config/op/plugins.sh

test -e "${ZSH_HOME}/.iterm2_shell_integration.zsh" && source "${ZSH_HOME}/.iterm2_shell_integration.zsh"


