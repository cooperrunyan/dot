if test -e "/Applications/1Password.app"
  set -x SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

  set -x GIT_CONFIG_COUNT 1
  set -x GIT_CONFIG_KEY_0 "gpg.ssh.program"
  set -x GIT_CONFIG_VALUE_0 "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"

end
