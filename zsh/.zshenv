#!/bin/zsh

if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ $(uname) == "Darwin" ]]; then
    export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/Library/Caches"}
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

if [[ "$(uname)" == "Darwin" ]]; then
  export PATH="$PATH:$ZDOTDIR/bin/applescripts"
fi

