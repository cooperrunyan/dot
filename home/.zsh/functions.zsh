# Create a new directory and enter it
function mkdir_move() {
  mkdir -p "$@" && cd "$@"
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function openx() {
  if [ $# -eq 0 ]; then
    open .
  else
    open "$@"
  fi
}

function run_prettier() {
  if [ $# -eq 0 ]; then
    prettier --config ~/.prettierrc -w .
  else
    prettier --config ~/.prettierrc -w "$@"
  fi
}

function open_git_repo() {
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

function get_external_ip() {
  return dig +short myip.opendns.com @resolver1.opendns.com
}

function get_local_ip() {
  return ipconfig getifaddr en0
}

function execute_script() {
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
