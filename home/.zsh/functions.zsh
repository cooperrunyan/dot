# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@"
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
  open $(g remote get-url origin)
}

function update() {
  sudo softwareupdate -i -a
  brew update
  brew upgrade
  brew cleanup
  sudo npm install npm -g
  sudo npm update -g
  [ $1 ] || sudo reboot
}

function ip() {
  return dig +short myip.opendns.com @resolver1.opendns.com
}

function localip() {
  return ipconfig getifaddr en0
}

function zscript() {
  script="$HOME/.scripts/$1.zsh"
  [ -x script ] && return $script
  zsh -e $script
}

function google () {
  if [[ $# -gt 1 ]]; then
    b="https://www.google.com/search?q="
    url="${b}$(omz_urlencode ${@[2,-1]})"
  else
    url="https://www.google.com"
  fi

  open $url
}

function brewclean() {
  brew update
  brew upgrade
  brew prune
  brew cleanup
  brew doctor
}
