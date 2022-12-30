#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install neovim
brew install grep
brew install openssh
brew install screen
brew install php
brew install gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

brew install bfg
brew install binutils
brew install binwalk
brew install john
brew install knock
brew install nmap

brew install git
brew install lua
brew install ssh-copy-id
brew install tree

brew install yarn
brew install heroku
brew install netcat
brew install toilet
brew install go
brew install fzf
brew install gdu
brew install gh
brew install bottom
brew install bat

brew install --cask 1password-cli
brew install --cask font-roboto-mono-nerd-font

# Remove outdated versions from the cellar.
brew cleanup
