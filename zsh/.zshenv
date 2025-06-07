#!/bin/zsh

export EDITOR="nvim"
export LESS="FR"

if [[ $(uname) == "Darwin" ]]; then
    export XDG_CACHE_HOME="$HOME/Library/Caches"
else
    export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}
fi

export XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
export XDG_STATE_HOME=${XDG_STATE_HOME:-"$HOME/.local/state"}

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export USER_ZDOTDIR="$ZDOTDIR"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
[[ -d "$ZSH_CACHE_DIR/completions" ]] && FPATH="$ZSH_CACHE_DIR/completions:${FPATH}"

# ! [[ -d "$ZSH_CACHE_DIR/completions" ]] && mkdir "$ZSH_CACHE_DIR/completions"
# FPATH="$ZSH_CACHE_DIR/completions:${FPATH}"

# export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"
# export ZCOMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"
 
export PATH="$PATH:$ZDOTDIR/bin"

export LANG="en_US.UTF-8"

export CURL_HOME="$XDG_CONFIG_HOME/curl"
export LESSHISTFILE="$XDG_CACHE_HOME/.lesshst"

export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go-mod"
export GOCACHE="$XDG_CACHE_HOME/go"

export DENO_INSTALL="$XDG_DATA_HOME/deno"
export DENO_INSTALL_ROOT="$XDG_DATA_HOME/deno"
export PATH="$PATH:$DENO_INSTALL_ROOT/bin"

export TAPLO_CONFIG="$XDG_CONFIG_HOME/taplo.toml"

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

export HOMEBREW_BUNDLE_FILE_GLOBAL="$XDG_CONFIG_HOME/Brewfile"
export HOMEBREW_NO_ENV_HINTS=1

export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat.conf"

if [[ "$(uname)" == "Darwin" ]]; then
  export PATH="$PATH:$ZDOTDIR/bin/applescripts"
fi

if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
