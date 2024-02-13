#!/usr/bin/env fish

set -U fish_greeting

set -gx LANG "en_US.UTF-8"
set -gx EDITOR "code --wait"

set -x STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/config.toml"
set -x STARSHIP_CACHE "$XDG_CACHE_HOME/starship"

set -x CURL_HOME "$XDG_CONFIG_HOME/curl"
set -x LESSHISTFILE "$XDG_DATA_HOME/.lesshst"

set -x GOPATH "$XDG_DATA_HOME/go"
set -x GOMODCACHE "$XDG_CACHE_HOME/go-mod"
set -x GOCACHE "$XDG_CACHE_HOME/go"

set -x DENO_INSTALL "$XDG_DATA_HOME/deno"
set -x NVM_DIR "$XDG_DATA_HOME/nvm"
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/.npmrc"
set -x NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -x NODE_REPL_HISTORY "$XDG_DATA_HOME/node/repl_history"
set -x YARN_GLOBAL_FOLDER "$XDG_DATA_HOME/yarn"
set -x YARN_CACHE_FOLDER "$XDG_CACHE_HOME/yarn"
set -x YARN_ENABLE_GLOBAL_CACHE true

set -x BUN_INSTALL "$XDG_DATA_HOME/bun"
if test -d "$BUN_INSTALL/bin"
    fish_add_path -P "$BUN_INSTALL/bin"
end

set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
set -x RUSTUP_HOME "$XDG_DATA_HOME/rustup"
if test -d "$CARGO_HOME/bin"
    fish_add_path -P "$CARGO_HOME/bin"
end

set -x QMK_HOME "$XDG_DATA_HOME/qmk_firmware"

if status is-interactive
    if command -sq starship
        function starship_transient_prompt_func
            starship module character
        end

        starship init fish | source
        enable_transience
    end

    function echo_prompt --on-event fish_postexec
        if test $argv[1] != "clear"
		    echo ""
        end
	end
end

