# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@" || exit
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
  if [ $# -eq 0 ]; then
    open .
  else
    open "$@"
  fi
}

function pretty() {
  if [ $# -eq 0 ]; then
    prettier --config ~/.config/prettier/.prettierrc -w .
  else
    prettier --config ~/.config/prettier/.prettierrc -w "$@"
  fi
}

function repo() {
  open "$(g remote get-url origin)"
}

function update() {
  sudo softwareupdate -i -a
  brew update
  brew upgrade
  brew cleanup
  sudo npm install npm -g
  sudo npm update -g
  [ "$1" ] || sudo reboot
}

function ip() {
  dig +short myip.opendns.com @resolver1.opendns.com || return 1
  return 0
}

function localip() {
  ipconfig getifaddr en0 || return 1
  return 0
}

function zscript() {
  script="$HOME/.scripts/$1.zsh"
  [ -x script ] && return "$script"
  zsh -e "$script"
}

function brewclean() {
  brew update
  brew upgrade
  brew prune
  brew cleanup
  brew doctor
}

function google() {
  string="$*"
  strlen=${#string}
  encoded=""

  for ((pos = 0; pos < strlen; pos++)); do
    c=${string:$pos:1}
    case "$c" in
    [-_.~a-zA-Z0-9]) o="${c}" ;;
    *) printf -v o '%%%02x' "'$c" ;;
    esac
    encoded+="${o}"
  done

  if [[ $# -gt 1 ]]; then
    b="https://www.google.com/search?q="
    url="$b$encoded"
  else
    url="https://www.google.com"
  fi

  open "$url"
}
