#!/bin/zsh

clear

export ZDOTDIR="${ZDOTDIR:-$HOME}"

export ZSH_COMPDUMP="${XDG_CACHE_HOME:-${HOME}/.cache}/zcompdump/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
export HISTFILE=$ZDOTDIR/.zsh_history

export plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
[[ -r "$HOME/.cache/p10k/instant-prompt.zsh" ]] && source "$HOME/.cache/p10k/instant-prompt.zsh"

for cfg_file in $ZDOTDIR/custom/{.*,*}.zsh; do
  [ -r "$cfg_file" ] && [ -f "$cfg_file" ] && source "$cfg_file"
done
unset cfg_file

for cfg_file in $ZDOTDIR/{brew,path,aliases,functions,.p10k,.fzf,env}.zsh; do
  #shellcheck source="./path.zsh"
  [ -r "$cfg_file" ] && [ -f "$cfg_file" ] && source "$cfg_file"
done
unset cfg_file

#shellcheck source="./.oh-my-zsh/oh-my-zsh.sh"
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

alias egrep &>/dev/null && unalias egrep &>/dev/null
alias fgrep &>/dev/null && unalias fgrep &>/dev/null
alias _ &>/dev/null && unalias _ &>/dev/null
alias which-command &>/dev/null && unalias which-command &>/dev/null
alias run-help &>/dev/null && unalias run-help &>/dev/null

[ -f "$HOME/.config/op/plugins.sh" ] && source "$HOME/.config/op/plugins.sh"

[[ "$TERM_PROGRAM" == "vscode" ]] && source "$(code --locate-shell-integration-path zsh)"
