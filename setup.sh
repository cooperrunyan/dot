#!/bin/bash
DIR=$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

! [ -d "$DIR/.config/zsh/custom" ] && mkdir -p "$DIR/.config/zsh/custom"

OMZ_CUSTOM=$DIR/.config/zsh/oh-my-zsh/custom

! [ -d "$OMZ_CUSTOM/lib" ] && mkdir -p "$OMZ_CUSTOM/lib"
! [ -d "$OMZ_CUSTOM/plugins" ] && mkdir -p "$OMZ_CUSTOM/plugins"
! [ -d "$OMZ_CUSTOM/themes" ] && mkdir -p "$OMZ_CUSTOM/themes"

# .oh-my-zsh/custom/lib/directories.zsh to disable default aliases
echo "" >"$OMZ_CUSTOM/lib/directories.zsh"

mkdir -p "$OMZ_CUSTOM/plugins/zsh-syntax-highlighting"
mkdir -p "$OMZ_CUSTOM/plugins/zsh-autosuggestions"
mkdir -p "$OMZ_CUSTOM/themes/powerlevel10k"

echo "Pulling OMZ..."
git -C "$DIR" submodule sync --recursive && git submodule update --recursive

submodules=(
  "$OMZ_CUSTOM/plugins/zsh-syntax-highlighting ::: https://github.com/zsh-users/zsh-syntax-highlighting.git"
  "$OMZ_CUSTOM/plugins/zsh-autosuggestions ::: https://github.com/zsh-users/zsh-autosuggestions.git"
  "$OMZ_CUSTOM/themes/powerlevel10k ::: https://github.com/romkatv/powerlevel10k.git"
)

for _submodule in "${submodules[@]}"; do
  _submodule_path=${_submodule%% ::: *}
  _submodule_url=${_submodule#* ::: }
  _submodule_name=$(echo "$_submodule_url" | sed 's/.*\///')

  echo "Pulling ${_submodule_name//.git/}..."

  if [ -d "$_submodule_path" ] && [ "$(ls -A "$_submodule_path")" = "" ]; then
    git -C "$DIR" clone "$_submodule_url" "$_submodule_path"
  else
    git -C "$_submodule_path" pull
  fi
done
echo ""

unset _submodule_path
unset _submodule_url
unset _submodule_name
unset _submodule

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
