export ZSH="$ZSH_HOME/.oh-my-zsh"

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}

export EDITOR="code"

export NODE_REPL_HISTORY_SIZE='0'
export NODE_REPL_MODE='sloppy'

export HOMEBREW_NO_ENV_HINTS=1

export HISTCONTROL='ignoreboth' # Omit duplicates and commands that begin with a space from history.

export LANG='en_US.UTF-8'

export GPG_TTY=$(tty)

export WAKATIME_HOME=$HOME/.wakatime

export GOPATH=$HOME/.go
export GOMODCACHE=$XDG_CACHE_HOME/go-mod
export GOCACHE=$XDG_CACHE_HOME/go
