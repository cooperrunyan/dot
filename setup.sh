#!/bin/bash

self="$(dirname "$(realpath "$0")")"

perfect=1

cmd_exists() {
  command -v "$1" >/dev/null 2>&1 && return 0
  return 1
}

verbose=
if grep -iE '( |^)(\-v|\-\-verbose)( |$)' <<<"$*" >/dev/null 2>&1; then
  verbose=1
fi

verbose=0
target_dir=$(dirname "$self")

while true; do
  case "$1" in
  -v | --verbose)
    verbose=1
    ;;
  -c | --config)
    shift
    target_dir="$1"
    ;;
  "")
    break
    ;;
  esac
  shift
done

ftarget_dir="${target_dir/$HOME/\$HOME}"
fself="${self/$HOME/\$HOME}"

log_cmd() {
  perfect=0
  if [ "$verbose" = "1" ]; then
    echo ""
    echo "$2:"
    echo "  - $1"
  else
    echo "$1"
  fi
}

pkg_manager_name=
pkg_manager_command=
pkg_manager_executable=

if [[ $(uname) == "Darwin" ]]; then
  pkg_manager_executable="brew"
  pkg_manager_name="Homebrew"
  pkg_manager_command="brew install"

  if ! cmd_exists $pkg_manager_executable; then
    log_cmd "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"" "Install homebrew"
  fi

elif cmd_exists apt; then
  pkg_manager_executable="apt"
  pkg_manager_name="apt"
  pkg_manager_command="sudo apt update && sudo apt install -y"
fi

log_install() {
  if [ "$pkg_manager_name" = "" ]; then
    echo ""
    echo "# Install $2"
    echo ""
  else
    log_cmd "$pkg_manager_command $1" "Install ($pkg_manager_name) $2"
  fi
}

conditional_log_install() {
  chk_exec="$1"
  pkg_name="$1"
  descr="$2"
  if [ $# = 3 ]; then
    pkg_name="$2"
    descr="$3"
  fi

  if ! cmd_exists "$chk_exec"; then
    log_install "$pkg_name" "$descr"
  fi
}

conditional_log_install "stow" "GNU Stow"
conditional_log_install "zsh" "zsh"

if ! [ "$(realpath "$target_dir/zsh")" = "$self/zsh" ]; then
  log_cmd "stow \"$self\" -t \"$target_dir\"" "Symlink dotfiles $fself to $ftarget_dir"
fi

if ! finger "$(whoami)" | grep -E "Shell: /.*/zsh" >/dev/null 2>&1; then
  log_cmd "chsh -s \"\$(which zsh)\"" "Switch user login shell to ZSH"
fi

if ! [[ -f "$HOME/.zshrc" ]] && grep -E '(.|source) (\"|$'"'"').*/\.zshrc\2' <"$HOME/.zshrc" >/dev/null 2>&1; then
  log_cmd "echo \"[[ -f \\\"$ftarget_dir/zsh/.zshrc\\\" ]] && source \\\"$ftarget_dir/zsh/.zshrc\\\" >> \"\$HOME/.zshrc\"" "Source .zshrc"
fi

if ! [[ -f "$HOME/.zshenv" ]] && grep -E '(.|source) (\"|$'"'"').*/\.zshenv\2' <"$HOME/.zshenv" >/dev/null 2>&1; then
  log_cmd "echo \"[[ -f \\\"$ftarget_dir/zsh/.zshenv\\\" ]] && source \\\"$ftarget_dir/zsh/.zshenv\\\" >> \"\$HOME/.zshenv\"" "Source .zshenv"
fi

if ! bash "$self/fonts.sh" --check >/dev/null 2>&1; then
  pr="${self/$HOME/~}"
  [ "$self" = "$(pwd)" ] && pr="."
  log_cmd "bash $pr/fonts.sh" "Install fonts"
fi

if [ "$perfect" = 1 ] && [ "$verbose" = 1 ]; then echo "Already set up"; fi
