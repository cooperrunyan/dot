#!/bin/bash
DIR=$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

! [ -d "$DIR/.config/zsh/custom" ] && mkdir -p "$DIR/.config/zsh/custom"

links=()
folders=()
moves=()

echo " "
echo "Creating symlinks:"
echo " "

SYM_BASE="$DIR/.config"

mv "$HOME/.zshrc" "$HOME/.zshrc.old"
ln -sf "$DIR/.zshrc" "$HOME/.zshrc"

for item in $SYM_BASE/{*,.*}; do
  item_name=${item//$SYM_BASE\//}

  test "$item_name" = '*' && continue
  test "$item_name" = '.' && continue
  test "$item_name" = '..' && continue
  test "$item_name" = '.DS_Store' && continue

  sym=$HOME/.config/${item//$SYM_BASE\//}

  item=${item//\/\///}
  sym=${sym//\/\///}

  if [ -L "$sym" ]; then
    rm -rf "$sym"
  else
    if [ -r "$sym" ]; then
      moves+=("$sym")
      mv "$sym" "$sym.old"
    fi
  fi
  ln -sf "$item" "$sym"
  links+=("~/${sym//$HOME\//}\\\\-->\\\\~/${item//$HOME\//}")
done

FOLDER_SPACE=0
for folder in "${folders[@]}"; do
  FOLDER_SPACE=1
  echo "Made directory: ~/$folder/"
done

if [ $FOLDER_SPACE -eq 1 ]; then
  echo " "
fi

MOVES_SPACE=0
for sym in "${moves[@]}"; do
  MOVES_SPACE=1
  echo "~/${sym//$HOME\//} already existed (moved to ~/${sym//$HOME\//}.old)"
done

if [ $MOVES_SPACE -eq 1 ]; then
  echo " "
fi

for link in "${links[@]}"; do
  echo "Linked: ${link//\\/ }"
done

echo " "
echo "Done setting up dotfiles"
echo " "
