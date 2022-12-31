#!/usr/bin/env bash

export ZSH="$ZSH_HOME/.oh-my-zsh"

export EDITOR="code --wait"

export NODE_REPL_HISTORY_SIZE='0'
export NODE_REPL_MODE='sloppy'

# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth'

export LANG='en_US.UTF-8'

export GPG_TTY=$(tty)

export WAKATIME_HOME=$HOME/.wakatime
