#!/bin/zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
WHO=$(whoami)
[ -r "$CACHE/p10k-instant-prompt-$WHO.zsh" ] && source "$CACHE/p10k-instant-prompt-$WHO.zsh"
[ -r "$CACHE/p10k-dump-$WHO.zsh" ] && source "$CACHE/p10k-dump-$WHO.zsh"

setopt interactivecomments
setopt HIST_SAVE_NO_DUPS
_comp_options+=(globdots)
autoload -U compinit
compinit
bindkey "^X^_" redo
bindkey -v
autoload -Uz edit-command-line
zle -N edit-command-line

. "$CONFIG/zsh/.zshenv"
. "$CONFIG/zsh/functions.zsh"
. "$CONFIG/zsh/p10k.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "$CONFIG/op/plugins.sh" ] && source "$CONFIG/op/plugins.sh"

command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

export plugins=(
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

fpath+=$ZSH_CUSTOM/plugins/zsh-completions/src

. "$CONFIG/zsh/omz/oh-my-zsh.sh"
