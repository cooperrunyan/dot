#!/bin/zsh

clear

export ZDOTDIR="${ZDOTDIR:-$HOME}"

[ -r "$ZDOTDIR/env.sh" ] && source "$ZDOTDIR/env.sh"
[ -r "$ZDOTDIR/custom/env.sh" ] && source "$ZDOTDIR/custom/env.sh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
[[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-$(whoami).zsh" ]] && source "$XDG_CACHE_HOME/p10k-instant-prompt-$(whoami).zsh"
[[ -r "$XDG_CACHE_HOME/p10k-dump-$(whoami).zsh" ]] && source "$XDG_CACHE_HOME/p10k-dump-$(whoami).zsh"

setopt interactivecomments

function source_files() {
  emulate -L zsh
  unsetopt nomatch
  for cfg_file in "$ZDOTDIR"{"/","/custom/"}{*,.*}.{sh,zsh}; do
    [ "$cfg_file" = "$ZDOTDIR/env.sh" ] && continue        # Already sourced
    [ "$cfg_file" = "$ZDOTDIR/custom/env.sh" ] && continue # Already sourced
    [ -r "$cfg_file" ] && [ -f "$cfg_file" ] && source "$cfg_file"
  done
  unset cfg_file
}
source_files
unset source_files

export ZSH_COMPDUMP="$XDG_CACHE_HOME/.zcompdump"
export HISTFILE=$ZDOTDIR/.zsh_history

export plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)

unalias egrep &>/dev/null
unalias fgrep &>/dev/null
unalias which-command &>/dev/null
unalias run-help &>/dev/null

[ -f "$XDG_CONFIG_HOME/op/plugins.sh" ] && source "$XDG_CONFIG_HOME/op/plugins.sh"

[[ "$TERM_PROGRAM" == "vscode" ]] && source "$(code --locate-shell-integration-path zsh)"

if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"
