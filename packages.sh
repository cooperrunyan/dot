#!/bin/sh

# Check for homebrew
if ! command -v brew &>/dev/null; then
  echo "brew not installed"

  install_brew() {
    echo "installing brew"
    echo " "
    echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)\""
    echo " "

    # (/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)") || (echo "failed to install" && exit 1)

    echo "Done installing brew"
    echo " "
  }

  if [ $(xcode-select -p) ]; then
    # macos, start installing brew
    echo "xcode tools are installed"
    install_brew
  else
    if ! command -v xcode-select &>/dev/null; then
      # On macos, but xcode tools are not installed
      echo "installing xcode tools (running $(sudo xcode-select --install))"
      sudo xcode-select --install || (echo "unable to install xcode tools" && exit 1)

      # brew can be installed
      install_brew

    else # Not on macos
      if command -v apt &>/dev/null; then
        echo "found \`apt\`, running \`sudo apt update && sudo apt install -y build-essential procps curl file git\`"
        sudo apt update && sudo apt install -y build-essential procps curl file git
      elif command -v yum &>/dev/null; then
        echo "found \`yum\`, running \`sudo yum groupinstall 'Development Tools' && sudo yum install procps-ng curl file git && sudo yum install libxcrypt-compat\`"
        sudo yum groupinstall 'Development Tools' && sudo yum install procps-ng curl file git && sudo yum install libxcrypt-compat
      fi

      if ! [ -e $(which make) ]; then
        echo "The required tools for homebrew are not installed. Use your distro's package manager to add them. https://docs.brew.sh/Homebrew-on-Linux#requirements"

      else
        # Tools are installed, can install brew
        install_brew
      fi
    fi
  fi
fi

# Add brew env vars to .../custom/brew.zsh

file="eval \"\$($(brew --prefix)/bin/brew shellenv)\""

if [[ ! -d "${DOTFILE_PATH}" && ! -d "${ZSH_HOME}" ]]; then
  echo "Add this file to your zsh config: "
  echo $file
  echo " "
else
  p=$ZSH_HOME
  [ -d $DOTFILE_PATH ] && p=$DOTFILE_PATH/home/.zsh

  ! [ -d $p/custom ] && mkdir $p/custom
  echo $file >$p/custom/brew.zsh
  source $p/custom/brew.zsh
fi

brew update && brew upgrade

brew install coreutils

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

[ ! -L "${BREW_PREFIX}/bin/sha256sum" ] && ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

COREUTIL_PREFIX=$(brew --prefix coreutils)

export PATH="$COREUTIL_PREFIX/libexec/gnubin:$PATH"

file="export PATH=\"$COREUTIL_PREFIX/libexec/gnubin:\$PATH\""

if [ -r $p/custom/brew.zsh ]; then
  echo $file >>$p/custom/brew.zsh
else
  echo "Add this file to your zsh config: "
  echo $file
  echo " "
fi

packages=(
  wget
  vim
  neovim
  grep
  openssh
  screen
  php
  gmp
  woff2
  nmap
  git
  lua
  tree
  yarn
  heroku
  netcat
  toilet
  go
  fzf
  gdu
  gh
  bottom
  bat
  --cask\\1password-cli
  --cask\\font-roboto-mono-nerd-font
  kubectl
)

for package in ${packages[*]}; do
  package=${package//\\/ }
  echo "Installing: $package"
  brew list ${package//--cask /} || (echo "Installing: $package" && brew install $package)
done

echo " "
echo "More fun packages: "
echo " "
echo "asciiquarium"
echo "cmatrix"
echo " "

brew cleanup
