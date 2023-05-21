export XDG_CACHE_HOME=$CACHE
export XDG_CONFIG_HOME=$CONFIG

export CURL_HOME=$CONFIG/curl

export ZSH="$CONFIG/zsh/oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"

export ZDOTDIR="$CONFIG/zsh"
export USER_ZDOTDIR="$ZDOTDIR"

export HIST_STAMPS="mm.dd.yyyy"

export EDITOR="code"

export NODE_REPL_HISTORY=""
export NODE_REPL_MODE="sloppy"

export HOMEBREW_NO_ENV_HINTS=1
export HISTCONTROL="ignoreboth" # Omit duplicates and commands that begin with a space from history.
export LANG="en_US.UTF-8"

export GPG_TTY=$(tty)

export GOPATH=$LIB/.go
export GOMODCACHE=$CACHE/go-mod
export GOCACHE=$CACHE/go

export NPM_CONFIG_USERCONFIG=$KEYS/.npmrc

export YARN_CACHE_FOLDER=$CACHE/yarn
export YARN_GLOBAL_FOLDER=$BIN/yarn
export YARN_ENABLE_GLOBAL_CACHE=true

export LESSHISTFILE=$LOG/.lesshst

export CARGO_HOME="$LIB/cargo"
export RUSTUP_HOME="$LIB/rustup"
export QMK_HOME="$LIB/qmk_firmware/"
export DOCKER_CONFIG="$LIB/docker"
