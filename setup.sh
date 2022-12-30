#!/usr/bin/env bash

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)

git -C $DIR submodule update --init --recursive

for file in $DIR/{*,.*}; do
  test "$file" = $DIR/.git && continue
  test "$file" = $DIR/. && continue
  test "$file" = $DIR/.. && continue
  test "$file" = $DIR/README.md && continue
  test "$file" = $DIR/setup.sh && continue

  # Initialization scripts
  test "$file" = $DIR/brew.sh && continue
  test "$file" = $DIR/.macos && continue

  sym=$HOME/${file//$DIR\//}

  echo $sym $file
  ln -sf $file $sym
done
unset file

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
