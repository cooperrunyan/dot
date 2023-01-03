clear

export ZDOTDIR="${ZDOTDIR:-$HOME}"

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "$HOME/.cache/p10k-instant-prompt-$(whoami).zsh" ]]; then
  source "$HOME/.cache/p10k-instant-prompt-$(whoami).zsh"
fi

for file in $ZDOTDIR/custom/{.*,*}.zsh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

for file in $ZDOTDIR/{brew,path,aliases,functions,.p10k,.fzf,env}.zsh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

ZSH_COMPDUMP="${XDG_CACHE_HOME:-${HOME}/.cache}/zcompdump/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
HISTFILE=$ZDOTDIR/.zsh_history

source $ZSH/oh-my-zsh.sh

alias egrep &>/dev/null && unalias egrep &>/dev/null
alias fgrep &>/dev/null && unalias fgrep &>/dev/null
alias _ &>/dev/null && unalias _ &>/dev/null
alias which-command &>/dev/null && unalias which-command &>/dev/null
alias run-help &>/dev/null && unalias run-help &>/dev/null

[ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh

[[ "$TERM_PROGRAM" == "vscode" ]] && source "$(code --locate-shell-integration-path zsh)"
