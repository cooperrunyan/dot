#!/usr/bin/env bash

SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)

echo "$DIR" >$DIR/home/.zsh/dotfiles

git -C $DIR pull --recurse-submodules

SYM_BASE=$DIR/home

# Link the contents instead of the whole folder
prefer_children=(
  .config
  .scripts
)

links=()
folders=()

for prefer_child in ${prefer_children[@]}; do
  if ! [ -d $HOME/$prefer_child ]; then
    mkdir $HOME/$prefer_child
    folders+="$prefer_child"
  fi

  for item in $SYM_BASE/$prefer_child/*; do
    sym=$HOME/${item//$SYM_BASE/}
    ln -sf "$item" "$sym"
    links+="~${sym//$HOME/}\\\\-->\\\\~${item//$HOME/} "
  done
  unset item
done
unset prefer_child

# Regular

for item in $SYM_BASE/{*,.*}; do
  item_name=${item//$SYM_BASE\//}

  test "$item_name" = '*' && continue
  test "$item_name" = '.' && continue
  test "$item_name" = '..' && continue
  test "$item_name" = '.DS_Store' && continue

  skip=0
  for skip_file in ${prefer_children[@]}; do
    if [ $item_name == $skip_file ]; then
      skip=1
      continue
    fi
  done

  if [ $skip == 1 ]; then
    continue
  fi

  sym=$HOME/${item//$SYM_BASE\//}

  ln -sf "$item" "$sym"
  links+=("~/${sym//$HOME/}\\\\-->\\\\~/${item//$HOME/}")
done

for folder in ${folders[@]}; do
  echo "Made directory: ~/$folder/"
done

for link in ${links[@]}; do
  link="${link//\/\///}"
  echo "Linked file: ${link//\\/ }"
done
