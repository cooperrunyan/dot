export DOTFILE_PATH=$(readlink $ZDOTDIR)

XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}
ZSH=$ZDOTDIR/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

HIST_STAMPS="dd.mm.yyyy"

EDITOR="code"

NODE_REPL_HISTORY_SIZE='0'
NODE_REPL_MODE='sloppy'

HOMEBREW_NO_ENV_HINTS=1
HISTCONTROL='ignoreboth' # Omit duplicates and commands that begin with a space from history.
LANG='en_US.UTF-8'

GPG_TTY=$(tty)

GOPATH=$HOME/.go
GOMODCACHE=$XDG_CACHE_HOME/go-mod
GOCACHE=$XDG_CACHE_HOME/go

export WAKATIME_HOME=$HOME/.wakatime
