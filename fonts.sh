#!/bin/bash

declare -a homebrew_fonts=(
  font-geist-mono
  font-geist-mono-nerd-font
  font-roboto-mono-nerd-font
)

declare -a github_fonts=(
  RobotMono
  GeistMono
)

cmd_exists() {
  command -v "$1" >/dev/null 2>&1 && return 0
  return 1
}

check=0
fonts_dir="$HOME/.local/share/fonts"

while true; do
  case "$1" in
  -c | --check)
    check=1
    ;;
  -d | --dir)
    shift
    fonts_dir="$1"
    ;;
  "")
    break
    ;;
  esac
  shift
done

run_cmd() {
  [ "$check" = 1 ] && exit 1

  echo ""
  echo "$1"
  if ! eval "$1"; then exit 1; fi
}

if cmd_exists "brew"; then

  if ! brew tap | grep 'bramstein/webfonttools' >/dev/null 2>&1; then
    run_cmd "brew tap bramstein/webfonttools"
  fi

  for font in "${homebrew_fonts[@]}"; do
    if brew info "$font" | grep "Not installed" >/dev/null 2>&1; then
      run_cmd "brew install $font"
    fi
  done

else
  changed=0

  for font in "${github_fonts[@]}"; do
    if fc-list | grep "$font" >/dev/null 2>&1; then
      continue
    fi

    [ "$check" = 1 ] && exit 1

    zip="$font.zip"
    url="https://github.com/ryanoasis/nerd-fonts/releases/download/latest/$zip"
    if [[ ! -d "$fonts_dir" ]]; then
      if ! mkdir -p "$fonts_dir"; then exit 1; fi
    fi
    echo "Downloading $url"
    if ! wget "$url"; then exit 1; fi
    echo "Unzipping $font"
    if ! unzip "$zip" -d "$fonts_dir"; then exit 1; fi
    if ! rm "$zip"; then exit 1; fi

    changed=1
  done

  if [ "$changed" = 1 ]; then
    if ! fc-cache -fv; then exit 1; fi
  fi
fi

echo ""
echo "All fonts downloaded successfully"
