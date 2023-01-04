#!/bin/bash

DIR=${BASH_SOURCE[0]}

function track() {
  [ "$(readlink "$DIR")" ] && DIR=$(readlink "$DIR") || return 0
  track
}
track

DIR=$(cd -P "$(dirname "$DIR")" >/dev/null 2>&1 && pwd)
DIR=$(cd -P "$(dirname "$DIR")" >/dev/null 2>&1 && pwd)
DIR=$(cd -P "$(dirname "$DIR")" >/dev/null 2>&1 && pwd)

echo Running: "${DOTFILE_PATH:-$DIR}/setup.sh $*"

"${DOTFILE_PATH:-$DIR}/setup.sh" "$@"
