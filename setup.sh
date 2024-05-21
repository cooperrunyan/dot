#!/bin/bash

self="$(dirname "$(realpath "$0")")"

cmd_exists() {
  command -v "$1" >/dev/null 2>&1 && return 0
  return 1
}

if ! cmd_exists stow; then
  if cmd_exists brew; then
    echo "Installing GNU Stow via homebrew (brew install stow)"
    ! brew install stow && exit 1
  elif cmd_exists apt; then
    echo "Installing GNU Stow via apt (sudo apt install stow)"
    ! sudo apt install stow && exit 1
  else
    echo "Install GNU Stow" && exit 1
  fi
fi

dot=$(dirname "$self")

# shellcheck disable=SC3037
printf '%s' "Install dotfiles in $dot? [Y/n] "
read -r a
if [ "$a" = "n" ]; then
  read -r a
  dot=$(realpath "$a")
fi

echo "Setting up dotfiles in $dot"
stow "$self" -t "$dot"

if cmd_exists zsh; then
  echo "Changing shell to zsh"
  chsh -s "$(which zsh)"
fi

if [ -f "$HOME/.zshrc" ]; then
  zshrc_content="source \"${dot/$HOME/\$HOME}/zsh/.zshrc\""

  # shellcheck disable=SC2088
  echo "~/.zshrc already exists. Do you want to:"
  echo "    0 - Append 'source \"$dot/zsh/.zshrc\"' to the existing file. (default)"
  echo "    1 - Rename existing file and create a new one that sources $dot/zsh/.zshrc"
  echo "    2 - Replace the existing .zshrc"

  read -r a

  if [ "$a" = 2 ]; then
    echo "$zshrc_content" >"$HOME/.zshrc"

  elif [ "$a" = 1 ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.old"
    echo "$zshrc_content" >"$HOME/.zshrc"
  else
    echo "$zshrc_content" >>"$HOME/.zshrc"
  fi
else
  echo "$zshrc_content" >"$HOME/.zshrc"
fi
