if test -d /opt/homebrew/bin
    set -x HOMEBREW_NO_ENV_HINTS 1

    set -x HOMEBREW_BUNDLE_FILE_GLOBAL $HOME/.config/Brewfile


    eval (/opt/homebrew/bin/brew shellenv)
    fish_add_path -pP /opt/homebrew/bin
    fish_add_path -pP /opt/homebrew/sbin
    set -g fish_complete_path $fish_complete_path /opt/homebrew/share/fish/vendor_completions.d

    set -x OPENSSL_ROOT_DIR (brew --prefix openssl)

    abbr b brew

    if test -d /opt/homebrew/opt/ccache/libexec
        fish_add_path -P /opt/homebrew/opt/ccache/libexec
    end
end
