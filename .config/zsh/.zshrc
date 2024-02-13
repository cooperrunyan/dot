#!/bin/zsh

trysource() {
  [[ -s "$1" ]] && source "$1"
}

trysource "$XDG_CACHE_HOME/p10k-instant-prompt-$USER.zsh"
trysource "$XDG_CACHE_HOME/p10k-dump-$USER.zsh"
trysource "$ZDOTDIR/p10k.zsh"

ZSH="$ZDOTDIR/omz"
ZSH_CUSTOM="$ZDOTDIR/lib"
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
export ZCOMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
CASE_SENSITIVE=false
HYPHEN_INSENSITIVE=true
ENABLE_CORRECTION=false
SHELL_SESSIONS_DISABLE=1

HISTFILE="$XDG_DATA_HOME/.zsh_history"
HIST_STAMPS="mm/dd/yyyy"
HISTCONTROL="ignoreboth"
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt append_history
setopt extended_history

setopt interactivecomments
setopt autocd
setopt auto_param_slash
setopt auto_menu
setopt always_to_end
setopt always_last_prompt
setopt menu_complete

export plugins=(
  bun
  brew
  deno
  docker
  dotenv
  gh
  iterm2
  zsh-autosuggestions
  fast-syntax-highlighting
  colored-man-pages
  rust
  fzf
  nmap
  npm
  calc
)

zstyle ':omz:update' mode auto
zstyle :omz:plugins:iterm2 shell-integration yes

fpath+="$ZSH_CUSTOM/plugins/zsh-completions/src"
fpath+=/opt/homebrew/share/zsh/site-functions

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE_DIR/.zcompcache"
zstyle ':completion:*' complete-options true
zstyle ':completion:*' menu select=

# partial completion suggestions (ex: `cd /u/lo/b{tab}` -> 'usr/local/bin')
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

trysource "$ZDOTDIR/omz/oh-my-zsh.sh"

trysource "$ZDOTDIR/local.zshrc"

trysource "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"

if which gh &>/dev/null; then
  eval $(gh completion -s zsh)
fi

trysource "$XDG_CONFIG_HOME/op/plugins.sh"
trysource "$XDG_DATA_HOME/iterm/.iterm2_shell_integration.zsh"

bindkey "^X^_" redo

alias g="git"
alias v="nvim"
alias rg="ranger"
alias ls="ls -phFHAtG --color"
alias mkdir="mkdir -p"

if which bat &>/dev/null; then
  alias cat="bat"
fi
