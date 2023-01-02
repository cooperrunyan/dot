clear

export ZSH_HOME="${ZSH_HOME:-$HOME}"

export DOTFILE_PATH=$(readlink $ZSH_HOME)
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}

ZSH=$ZSH_HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
HIST_STAMPS="dd.mm.yyyy"

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
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

ZSH_COMPDUMP="${XDG_CACHE_HOME:-${HOME}/.cache}/zcompdump/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
HISTFILE=$ZSH_HOME/.zsh_history

source $ZSH/oh-my-zsh.sh

[ -f ~/.config/op/plugins.sh ] && source ~/.config/op/plugins.sh
[ -f $ZSH_HOME/.fzf.zsh ] && source $ZSH_HOME/.fzf.zsh
