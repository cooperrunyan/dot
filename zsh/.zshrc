#!/usr/bin/env zsh

if [[ -n "$ZSH_PROF_DEBUG" ]]; then
  zmodload zsh/zprof
fi

if [[ $(uname) == "Darwin" ]]; then
    export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/Library/Caches"}
else
    export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}
fi

[[ -s "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]] && source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
# [[ -s "${XDG_CACHE_HOME}/p10k-dump-${(%):-%n}.zsh" ]] && source "${XDG_CACHE_HOME}/p10k-dump-${(%):-%n}.zsh"


POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true


autoload -Uz undo redo run-help push-input accept-and-hold yank yank-pop quote-region kill-buffer backward-kill-word set-mark-command
bindkey '^u' undo
bindkey '^r' redo
# bindkey '^h' run-help
bindkey '^[p' push-input
# bindkey '^p' yank
# bindkey '^g' yank-pop
bindkey "^\'" quote-region
bindkey '^k' kill-buffer
bindkey '\Es' set-mark-command
bindkey '^n' forward-word
bindkey '^b' backward-word

delregion() {
  if ((REGION_ACTIVE)) then
     zle kill-region
  else
    zle backward-delete-char
  fi
}
zle -N delregion
bindkey '^?' delregion

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

HISTSIZE=100000
HISTFILE="$XDG_DATA_HOME/zsh/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

setopt interactivecomments
setopt globdots


ZINIT_HOME=${ZINIT_HOME:-"$XDG_DATA_HOME/zinit/zinit.git"}

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

if [ -d "$ZSH_CACHE_DIR" ] && [ ! -d "$ZSH_CACHE_DIR/completions" ]; then
  mkdir "$ZSH_CACHE_DIR/completions"
fi

[[ -d "$ZSH_CACHE_DIR/completions" ]] && zinit add-fpath "$ZSH_CACHE_DIR/completions"

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  zinit add-fpath "$HOMEBREW_PREFIX/share/zsh/site-functions"
  export OPENSSL_ROOT_DIR=$(brew --prefix openssl)

  if [[ -d "/opt/homebrew/opt/ccache/libexec" ]]; then
    PATH="$PATH:/opt/homebrew/opt/ccache/libexec"
  fi
fi

zinit ice depth=1 lucid nocd
zinit load romkatv/powerlevel10k

zinit light zsh-users/zsh-syntax-highlighting

zinit ice blockf
zinit light zsh-users/zsh-completions

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets pattern regexp)

zmodload zsh/complist 

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey -M vicmd 'k' history-search-backward
bindkey -M vicmd 'j' history-search-forward
bindkey -M menuselect '^[[Z' reverse-menu-complete


# zinit snippet OMZP::bun
# zinit snippet OMZP::brew
# zinit snippet OMZP::rust
# zinit snippet OMZP::fzf

# zinit ice wait lucid
zinit snippet OMZP::ssh-agent

zinit ice wait lucid
zinit snippet OMZP::colored-man-pages

if [[ "$(uname)" == "Darwin" ]]; then
  zstyle :omz:plugins:ssh-agent ssh-add-args --apple-use-keychain --apple-load-keychain
fi

zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# partial completion suggestions (ex: `cd /u/lo/b{tab}` -> 'usr/local/bin')
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors '=(#b)*(│ *)==90' "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu yes=long select
zstyle ':completion:*' verbose true
zstyle ':completion:*' force-list always
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort time
zstyle ':completion:*' list-separator "│"
zstyle ':completion:*' special-dirs false

zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu select

compdump="$XDG_CACHE_HOME/zsh/.zcompdump"
autoload -Uz compinit
if ! [[ -f "$compdump" ]] || [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' "$compdump" 2>/dev/null)" ]; then
  compinit -d "$compdump"
else
  compinit -C -d "$compdump"
fi

# (( ${+_comps} )) && _comps[zinit]=_zinit

zinit cdreplay -q


which fzf &>/dev/null && fzf --zsh &>/dev/null && eval "$(fzf --zsh)"
which gh &>/dev/null && eval $(gh completion -s zsh)

# [[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]] && source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
# [ "$LC_TERMINAL" = "iTerm2" ] && [[ -s "$XDG_DATA_HOME/iterm/.iterm2_shell_integration.zsh" ]] && source "$XDG_DATA_HOME/iterm/.iterm2_shell_integration.zsh"

if [ -e "/Applications/Visual Studio Code.app" ]; then
  export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
fi

# if which code &>/dev/null; then
#   export EDITOR="code --wait -n"
#   alias edit="$EDITOR"
# fi
export EDITOR="hx"

# if [ -e "/Applications/1Password.app" ]; then
#   export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

#   [[ -s "$XDG_CONFIG_HOME/op/plugins.sh" ]] && source "$XDG_CONFIG_HOME/op/plugins.sh"

#   export GIT_CONFIG_COUNT=1
#   export GIT_CONFIG_KEY_0="gpg.ssh.program"
#   export GIT_CONFIG_VALUE_0="/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
# fi

source "$ZDOTDIR/abbr.zsh"

which bat &>/dev/null && abbr cat="bat"

_calc() python3 -c "from math import *; import numpy as np; print($*);"
alias calc='noglob _calc'

alias gr="noglob grep -iE"

abbr g="git"
abbr v="nvim"
abbr b="brew"
abbr rg="ranger"
abbr chx="chmod +x"
alias ls="ls -phAFHtG --color"
alias sudo="sudo -E"
alias mkdir="mkdir -p"
alias bat="bat --style=plain --theme=GitHub"
alias fzf="fzf --preview='bat --color=always --style=plain --theme=GitHub {}'"
alias du="du -h"

function rename() {
  match="$1"
  match="${match//\\d/[0-9]}"
  match="${match//\\D/[^0-9]}"

  e="s:$match:$2:g"

  start=3
  dry=-1

  for (( i=0; i <= "$#"; i++ )); do
    if [[ "${@[$i]}" == "--dry" ]]; then
      ((start++));
      dry=$i
      break
    fi
  done

  for (( i=3; i <= "$#"; i++ )); do
    if [[ "$dry" == "$i" ]]; then
      continue
    fi

    f="${@[$i]}"

    name="$(echo "$f" | sed -re "$e")"

    if [[ "$name" != "$f" ]]; then
      if [[ "$dry" != "-1" ]]; then
        echo "(not actually)" Rename \"$f\" to \"$name\"
      else
        # mkdir -p "$(sed -re "s:/[^/]+\$::g" <<< "$name")"
        mv "$f" "$name"
        echo Rename \"$f\" to \"$name\"
      fi
    fi
  done
}

zshrc_benchmark() {
  for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
}

zshrc_prof() {
  ZSH_PROF_DEBUG=1 zsh -i -c exit
}


 [[ -s "$ZDOTDIR/.p10k.zsh" ]] && source "$ZDOTDIR/.p10k.zsh";

if [[ -n "$ZSH_PROF_DEBUG" ]]; then
  zprof
fi
