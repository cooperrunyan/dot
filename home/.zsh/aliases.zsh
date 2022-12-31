alias pretty="prettier --config ~/.prettierrc -w ."
alias repo="open \$(g remote get-url origin)"

alias dev="cd ~/dev"

alias cat="bat"
alias g="git"
alias v="vim"
alias vim="nvim"
alias sp="spotify"

# Allows aliases to be run w sudo
alias sudo='sudo '

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; reboot'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

alias clean="~/.scripts/clean.sh"

alias reload="exec ${SHELL} -l"
