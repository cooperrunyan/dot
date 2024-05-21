#!/bin/zsh

cache_home=".cache"
[[ -d "$HOME/Library/Caches" ]] && cache_home="Library/Caches"

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/$cache_home"}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
export XDG_STATE_HOME=${XDG_STATE_HOME:-"$HOME/.local/state"}


ZDOTDIR=${ZDOTDIR:-"$XDG_CONFIG_HOME/zsh"}
USER_ZDOTDIR="$ZDOTDIR"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
FPATH="$ZSH_CACHE_DIR/completions:${FPATH}"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"
export ZCOMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"

if_src() {
  [[ -s "$1" ]] && source "$1"
}

cmd_exists() {
  which "$1" &>/dev/null && return 0
  return 1
}

if_src "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
if_src "${XDG_CACHE_HOME}/p10k-dump-${(%):-%n}.zsh"


if [[ -f "/opt/homebrew/bin/brew" ]]; then
  export HOMEBREW_BUNDLE_FILE_GLOBAL="$XDG_CONFIG_HOME/Brewfile"
  export HOMEBREW_NO_ENV_HINTS=1

  eval "$(/opt/homebrew/bin/brew shellenv)"
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  export OPENSSL_ROOT_DIR=$(brew --prefix openssl)

  if [[ -d "/opt/homebrew/opt/ccache/libexec" ]]; then
    PATH="$PATH:/opt/homebrew/opt/ccache/libexec"
  fi
fi



export LANG="en_US.UTF-8"

export CURL_HOME="$XDG_CONFIG_HOME/curl"
export LESSHISTFILE="$XDG_CACHE_HOME/.lesshst"

export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go-mod"
export GOCACHE="$XDG_CACHE_HOME/go"

export DENO_INSTALL="$XDG_DATA_HOME/deno"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/.npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node/repl_history"
export YARN_GLOBAL_FOLDER="$XDG_DATA_HOME/yarn"
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"
export YARN_ENABLE_GLOBAL_CACHE=true

export BUN_INSTALL="$XDG_DATA_HOME/bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$PATH"

export QMK_HOME="$XDG_DATA_HOME/qmk_firmware"


HISTSIZE=10000
HISTFILE="${XDG_CACHE_HOME}/zsh/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

bindkey "^X^_" redo
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

setopt interactivecomments


ZINIT_HOME=${ZINIT_HOME:-"$XDG_DATA_HOME/zinit/zinit.git"}

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi


source "$ZINIT_HOME/zinit.zsh"

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions


zinit snippet OMZP::bun
zinit snippet OMZP::brew
zinit snippet OMZP::dotenv
zinit snippet OMZP::rust
zinit snippet OMZP::colored-man-pages
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::clipboard.zsh
zinit snippet OMZL::compfix.zsh


zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# partial completion suggestions (ex: `cd /u/lo/b{tab}` -> 'usr/local/bin')
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

autoload -Uz compinit && compinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit cdreplay -q


cmd_exists "fzf" && eval "$(fzf --zsh)"
cmd_exists "zoxide" && eval "$(zoxide init --cmd cd zsh)"
cmd_exists "gh" && eval $(gh completion -s zsh)

if_src "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
if_src "$XDG_DATA_HOME/iterm/.iterm2_shell_integration.zsh"

if [ -e "/Applications/Visual Studio Code.app" ]; then
  export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
  export EDITOR="code --wait"
fi

if [ -e "/Applications/1Password.app" ]; then
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

  if_src "$XDG_CONFIG_HOME/op/plugins.sh"

  export GIT_CONFIG_COUNT=1
  export GIT_CONFIG_KEY_0="gpg.ssh.program"
  export GIT_CONFIG_VALUE_0="/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
fi

if_src "$ZDOTDIR/abbr.zsh"

cmd_exists "bat" && abbr cat="bat"

abbr g="git"
abbr v="nvim"
abbr b="brew"
abbr rg="ranger"
alias ls="ls -phFHAtG --color"
alias mkdir="mkdir -p"


if_src "$ZDOTDIR/.p10k.zsh"


if_src /opt/ros/humble/setup.zsh
if_src /usr/share/gazebo/setup.sh
