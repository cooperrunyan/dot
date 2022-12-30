#!/usr/bin/env bash

DOTFILES=$(cat $ZSH_HOME/dotfiles)

$DOTFILES/setup.sh $@
