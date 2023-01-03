#!/bin/bash

DIR=$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

DIR=${DIR:-$DOTFILE_PATH}

if [ -d "$1" ]; then
  DIR=${DIR:-$1}
fi

echo "Setting up dotfiles pointing to ~/${DIR//$HOME\//}"

! [ -d "$DIR/home/.zsh/custom" ] && mkdir -p "$DIR/home/.zsh/custom"

! [ -d "$DIR/home/.zsh/.oh-my-zsh/custom/lib" ] && mkdir -p "$DIR/home/.zsh/.oh-my-zsh/custom/lib"
! [ -d "$DIR/home/.zsh/.oh-my-zsh/custom/plugins" ] && mkdir -p "$DIR/home/.zsh/.oh-my-zsh/custom/plugins"
! [ -d "$DIR/home/.zsh/.oh-my-zsh/custom/themes" ] && mkdir -p "$DIR/home/.zsh/.oh-my-zsh/custom/themes"

# .oh-my-zsh/custom/lib/directories.zsh to disable default aliases
echo "" >"$DIR/home/.zsh/.oh-my-zsh/custom/lib/directories.zsh"

PULL=1
for arg in "$@"; do
  test "$arg" == "--no-pull" && PULL=0
done

test $PULL == 1 && (echo "Pulling dotfile repository" && git -C "$DIR" pull -q --recurse-submodules)

if ! [ -r "$DIR/home/.zsh/.oh-my-zsh" ]; then
  echo "Cloning OMZ"
  git clone -q https://www.github.com/ohmyzsh/ohmyzsh.git "$DIR/home/.zsh/.oh-my-zsh"
else
  test $PULL == 0 && echo "Pulling OMZ" && git -C "$DIR/home/.zsh/.oh-my-zsh" pull -q
fi

SYM_BASE="$DIR/home"

# Link the contents instead of the whole folder
prefer_children=(
  .config
  .scripts
)

links=()
folders=()
moves=()

echo " "
echo "Creating symlinks:"
echo " "
for prefer_child in "${prefer_children[@]}"; do
  if ! [ -d "$HOME/$prefer_child" ]; then
    mkdir "$HOME/$prefer_child"
    folders+=("$prefer_child")
  fi

  for item in "$SYM_BASE"/"$prefer_child"/*; do
    sym=$HOME/${item//$SYM_BASE\//}
    sym=${sym//\/\///}
    item=${item//\/\///}

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
  for skip_file in "${prefer_children[@]}"; do
    if [ "$item_name" == "$skip_file" ]; then
      skip=1
      continue
    fi
  done

  if [ $skip == 1 ]; then
    continue
  fi

  sym=$HOME/${item//$SYM_BASE\//}

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

# zsh-autosuggestions
if [ -d "$DIR/home/.zsh/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  echo 'Pulling zsh-autosuggestions'
  git -C "$DIR/home/.zsh/.oh-my-zsh/custom/plugins/zsh-autosuggestions" pull -q --recurse-submodules
else
  echo 'Cloning zsh-autosuggestions'
  git clone -q --recurse https://github.com/zsh-users/zsh-autosuggestions.git "$DIR/home/.zsh/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ -d "$DIR/home/.zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  echo 'Pulling zsh-syntax-highlighting'
  git -C "$DIR/home/.zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" pull -q --recurse-submodules
else
  echo 'Cloning zsh-syntax-highlighting'
  git clone -q --recurse https://github.com/zsh-users/zsh-syntax-highlighting.git "$DIR/home/.zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" #
fi

# Powerlevel10k
if [ -d "$DIR/home/.zsh/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo 'Pulling powerlevel10k'
  git -C "$DIR/home/.zsh/.oh-my-zsh/custom/themes/powerlevel10k" pull -q --recurse-submodules
else
  echo 'Cloning powerlevel10k'
  git clone -q --recurse https://github.com/romkatv/powerlevel10k.git "$DIR/home/.zsh/.oh-my-zsh/custom/themes/powerlevel10k"
fi

echo " "
echo "Done setting up dotfiles"

if ! command -v brew &>/dev/null; then
  echo " "
  echo "Homebrew is not installed, run \`$DIR/packages.sh\` to install it and additional packages"
  echo " "
fi

if ! command -v zsh &>/dev/null; then
  echo " "
  echo "Zsh is not installed."
  echo "Install it, then run (location is probably something like /bin/zsh):"
  echo "chsh -s <location>"
  echo " "
  exit 1
fi
