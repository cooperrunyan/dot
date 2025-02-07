#!/usr/bin/env zsh

minimize_app() {
  osascript -e "tell application \"$1\" to set miniaturized of every window to true"
}

unminimize_app() {
  osascript -e "tell application \"$1\" to set miniaturized of every window to false"
}

skim_toggle_continuous() {
osascript -e "$(cat <<EOF
  tell application "Skim"
    if (count of documents) is 0 then return 
    tell document 1 
      set viewSettings to get view settings 
      set displayMode to display mode of viewSettings
      if displayMode is single page then
        set view settings to {display mode:single page continuous}
      end if
      if displayMode is single page continuous then
        set view settings to {display mode:single page}
      end if
      if displayMode is two up then
        set view settings to {display mode:two up continuous}
      end if
      if displayMode is two up continuous then
        set view settings to {display mode:two up}
      end if
    end tell 
  end tell
EOF
)"
}

skim_toggle_split() {
osascript -e "$(cat <<EOF
  tell application "Skim"
    if (count of documents) is 0 then return 
    tell document 1 
      set viewSettings to get view settings 
      set displayMode to display mode of viewSettings
      if displayMode is single page then
        set view settings to {display mode:two up}
      end if 
      if displayMode is single page continuous then
        set view settings to {display mode:two up continuous}
      end if 
      if displayMode is two up then
        set view settings to {display mode:single page}
      end if 
      if displayMode is two up continuous then
        set view settings to {display mode:single page continuous}
      end if 
    end tell 
  end tell
EOF
)"
}
