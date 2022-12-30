# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="true"

source $ZSH/oh-my-zsh.sh

PROMPT='[$(battery_pct)%%] %(?.%F{green}--.%F{red}XX)%f %1~: '

source $HOME/.config/op/plugins.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

clear

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
