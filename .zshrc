#!/usr/bin/env bash

[ -n "$PS1" ] && source ~/.zprofile

ZSH=~/.oh-my-zsh

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  web-search
  macos
  dotenv
  1password
  alias-finder
  battery
  catimg
)

ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"

source $ZSH/oh-my-zsh.sh

PROMPT='[$(battery_pct)%%] %(?.%F{green}--.%F{red}XX)%f %1~: '

source $HOME/.config/op/plugins.sh
