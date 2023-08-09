#!/bin/zsh

[ -r "$CONFIG/zsh/path.sh" ] && source "$CONFIG/zsh/path.sh"
[ -r "$CONFIG/zsh/custom/path.sh" ] && source "$CONFIG/zsh/custom/path.sh"

[ -r "$CONFIG/zsh/env.sh" ] && source "$CONFIG/zsh/env.sh"
[ -r "$CONFIG/zsh/custom/env.sh" ] && source "$CONFIG/zsh/custom/env.sh"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
[ -r "$CACHE/p10k-instant-prompt-$(whoami).zsh" ] && source "$CACHE/p10k-instant-prompt-$(whoami).zsh"
[ -r "$CACHE/p10k-dump-$(whoami).zsh" ] && source "$CACHE/p10k-dump-$(whoami).zsh"

setopt interactivecomments

function source_files() {
  emulate -L zsh
  unsetopt nomatch
  for cfg_file in "$CONFIG/zsh"{"/","/custom/"}{*,.*}.{sh,zsh}; do
    [ "$cfg_file" = "$CONFIG/zsh/env.sh" ] && continue         # Already sourced
    [ "$cfg_file" = "$CONFIG/zsh/custom/env.sh" ] && continue  # Already sourced
    [ "$cfg_file" = "$CONFIG/zsh/path.sh" ] && continue        # Already sourced
    [ "$cfg_file" = "$CONFIG/zsh/custom/path.sh" ] && continue # Already sourced
    [ "$cfg_file" = "$CONFIG/zsh/aliases.sh" ] && continue       
    [ "$cfg_file" = "$CONFIG/zsh/custom/aliases.sh" ] && continue 
    [ -r "$cfg_file" ] && [ -f "$cfg_file" ] && source "$cfg_file"
  done
  unset cfg_file
}
source_files
unset source_files

export ZSH_COMPDUMP="$CACHE/.zcompdump"
export HISTFILE=$LOG/.zsh_history

export plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)

unalias egrep &>/dev/null
unalias fgrep &>/dev/null
unalias which-command &>/dev/null
unalias run-help &>/dev/null

[ -f "$CONFIG/op/plugins.sh" ] && source "$CONFIG/op/plugins.sh"

[[ "$TERM_PROGRAM" == "vscode" ]] && source "$(code --locate-shell-integration-path zsh)"

command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

[ -f "$CONFIG/zsh/oh-my-zsh/oh-my-zsh.sh" ] && source "$CONFIG/zsh/oh-my-zsh/oh-my-zsh.sh"

[ -r "$CONFIG/zsh/aliases.sh" ] && source "$CONFIG/zsh/aliases.sh"
[ -r "$CONFIG/zsh/custom/aliases.sh" ] && source "$CONFIG/zsh/custom/aliases.sh"

