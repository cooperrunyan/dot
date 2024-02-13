if test -d /opt/homebrew/bin
    set -x HOMEBREW_NO_ENV_HINTS 1
    eval (/opt/homebrew/bin/brew shellenv)
    fish_add_path -pP /opt/homebrew/bin
    fish_add_path -pP /opt/homebrew/sbin
    set -g fish_complete_path $fish_complete_path /opt/homebrew/share/fish/vendor_completions.d
end
