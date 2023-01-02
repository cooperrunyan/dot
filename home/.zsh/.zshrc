clear

export ZSH_HOME="${ZSH_HOME:-$HOME}"

ZSH=$ZSH_HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

ZSH_COMPDUMP="${XDG_CACHE_HOME:-${HOME}/.cache}/zcompdump/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"

HISTSIZE=10000
SAVEHIST=9000
HISTFILE=$ZSH_HOME/.zsh_history

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  brew
  1password
)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "$HOME/.cache/p10k-instant-prompt-$(whoami).zsh" ]]; then
  source "$HOME/.cache/p10k-instant-prompt-$(whoami).zsh"
fi

for file in $ZSH_HOME/custom/{.*,*}.zsh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

for file in $ZSH_HOME/{path,env,aliases,functions,.p10k}.zsh; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

source $ZSH/oh-my-zsh.sh

[ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh
[ -f ~/.zsh/.fzf.zsh ] && source ~/.zsh/.fzf.zsh
