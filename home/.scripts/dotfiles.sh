#!/bin/bash

DIR=${BASH_SOURCE[0]}

DIR=$(realpath "$DIR")
DIR=$(cd -P "$(dirname "$DIR")" >/dev/null 2>&1 && pwd)

echo Running: "${DOTFILE_SOURCE:-$DIR}/setup.sh $*"

"${DOTFILE_SOURCE:-$DIR}/setup.sh" "$@"
