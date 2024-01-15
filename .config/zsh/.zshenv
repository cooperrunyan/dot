export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/Library/Caches"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export USER_ZDOTDIR="$ZDOTDIR"

export LANG="en_US.UTF-8"
export EDITOR="code --wait"

export HOMEBREW_NO_ENV_HINTS=1
export CURL_HOME="$XDG_CONFIG_HOME/curl"
export LESSHISTFILE="$XDG_DATA_HOME/.lesshst"

export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go-mod"
export GOCACHE="$XDG_CACHE_HOME/go"

export DENO_INSTALL="$XDG_DATA_HOME/deno"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/.npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export YARN_GLOBAL_FOLDER="$XDG_DATA_HOME/yarn"
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"
export YARN_ENABLE_GLOBAL_CACHE=true

export BUN_INSTALL="$XDG_DATA_HOME/bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export QMK_HOME="$XDG_DATA_HOME/qmk_firmware"

export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

[[ -f "$ZDOTDIR/local.zshenv" ]] && source "$ZDOTDIR/local.zshenv"
