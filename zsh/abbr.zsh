#!/bin/zsh

typeset -a abbrs
abbrs=()

typeset -A nested_abbrs
nested_abbrs=()

function abbr() {
  alias $1
  abbrs+=(${1%%\=*})
}

# abbr2 "brew" "i" "nstall"
function abbr2() {
  delim='='
  param="$2"
  sub=${param%%"$delim"*}
  exp=${param#*"$delim"}

  nested_abbrs[$1:::::$sub]="$exp"
}

# expand any aliases in the current line buffer
function expand_abbr() {
  if [[ $LBUFFER =~ ".*(^|;|\\||&&|>|>>)( )*(${(j:|:)abbrs})\$" ]]; then
    zle _expand_alias
    zle expand-word
  else
    for key val in "${(@kv)nested_abbrs}"; do
      delim=':::::'
      cmd=${key%%"$delim"*}
      prefix=${key#*"$delim"}

      if [[ $LBUFFER =~ ".*(^|;|\\||&&|>|>>)( )*$cmd( )*$prefix\$" ]]; then
        LBUFFER="${LBUFFER%"$prefix"}$val"
        break
      fi
    done
  fi
  zle self-insert
}
zle -N expand_abbr

# Bind the space key to the expand_abbr function above, so that space will expand any expandable aliases
bindkey ' ' expand_abbr
bindkey '^ ' magic-space # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches

# A function for expanding any aliases before accepting the line as is and executing the entered command
# function expand-abbr-and-accept-line {
#   expand_abbr
#   zle .backward-delete-char
#   zle .accept-line
# }
# zle -N accept-line expand-abbr-and-accept-line
