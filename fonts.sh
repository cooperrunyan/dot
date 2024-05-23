#!/bin/bash

declare -a fonts=(
  RobotMono
  GeistMono
)

version='2.1.0'
fonts_dir=${1:-$HOME/.local/share/fonts}

if [[ ! -d "$fonts_dir" ]]; then
  mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
  zip="$font.zip"
  url="https://github.com/ryanoasis/nerd-fonts/releases/download/v$version/$zip"
  echo "Downloading $url"
  wget "$url"
  unzip "$zip" -d "$fonts_dir"
  rm "$zip"
done

fc-cache -fv
