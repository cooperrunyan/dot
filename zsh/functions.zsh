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

skim_resize() {
osascript -e "$(cat <<EOF
  tell application "Skim"
  	if (count of documents) is 0 then return
  	tell document 1
  		if (auto scales of (get view settings)) then
  			set view settings to {scale factor:1.0, auto scales:false}
  		else
  			set view settings to {auto scales:true}
  		end if
  	end tell
  end tell
EOF
)"
}

skim_show_ui() {
osascript -e "$(cat <<EOF
  -- Set here all the Show/Hide menu items in the View menu you want by default
  property menu_item_titles : {"Hide Overview", "Show Contents Pane"}

  tell application "Skim"
  	set main_window_name to name of first window whose name starts with (name of front document & " (")
  end tell

  tell application "System Events"
  	tell process "Skim"
  		set frontmost to true
  		tell menu "Window" of front menu bar
  			click menu item main_window_name
  		end tell
  		tell menu "View" of front menu bar
  			repeat with menu_item_title in menu_item_titles
  				if menu item menu_item_title exists then
  					click menu item menu_item_title
  				end if
  			end repeat
  		end tell
  		if not (front toolbar of front window exists) then
  			keystroke "t" using {command down, option down}
  		end if
  	end tell
  end tell

  tell application "Skim"
  	set view settings of front document to view settings of (preferences for normal mode)
  	--set background color to {32768, 32768, 32768, 65535}
  end tell
EOF
)"
}

skim_hide_ui() {
osascript -e "$(cat <<EOF
  property menu_item_titles : {"Hide Overview", "Hide Notes Pane", "Hide Split PDF", "Hide Reading Bar", "Hide Status Bar", "Hide Contents Pane"}

  tell application "Skim"
  	set main_window_name to name of first window whose name starts with (name of front document & " (")
  	--set {page_x, page_y, page_width, page_height} to bounds of front page of front document
  end tell

  tell application "System Events"
  	tell process "Skim"
  		set frontmost to true
  		tell menu "Window" of front menu bar
  			click menu item main_window_name
  		end tell
  		--set size of front window to {page_width, page_height + 24}
  		key code 53
  		tell menu "View" of front menu bar
  			repeat with menu_item_title in menu_item_titles
  				if menu item menu_item_title exists then
  					click menu item menu_item_title
  				end if
  			end repeat
  		end tell
  		if front toolbar of front window exists then
  			keystroke "t" using {command down, option down}
  		end if
  	end tell
  end tell

  tell application "Skim"
  	set view settings of front document to {auto scales:true, display mode:single page, display box:crop box, displays page breaks:false}
  	--set background color to black
  end tell
EOF
)"  
}
