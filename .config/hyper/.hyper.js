'use strict';

const black = '#1a1b26';
const brightBlack = '#31364d';
const brightWhite = '#c0caf5';
const white = '#a9b1d6';
const magenta = '#bb9af7';
const blue = '#7aa2f7';
const yellow = '#e0af68';
const green = '#9ece6a';
const red = '#f7758e';
const cyan = '#7dcfff';

function op(opacity) {
  return Math.round(opacity * 255)
    .toString(16)
    .padStart(2, '0');
}

// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.
module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: 'stable',
    // default font size in pixels for all tabs
    fontSize: 14,
    // font family with optional fallbacks
    fontFamily:
      '"RobotoMono Nerd Font", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    verminal: {
      fontFamily: '"RobotoMono Nerd Font"',
      fontSize: 14,
      minimal: true,
      cursorColor: white,
      foregroundColor: white,
      // terminal background color
      // opacity is only supported on macOS
      backgroundColor: black + op(0.5),
      // terminal selection color
      selectionColor: '#33467c' + op(0.6),
      // border color (window, tabs)
      borderColor: '#333',
      colors: {
        black,
        red,
        green,
        yellow,
        blue,
        magenta,
        cyan,
        white,
        lightBlack: brightBlack,
        lightRed: red,
        lightGreen: green,
        lightYellow: yellow,
        lightBlue: blue,
        lightMagenta: magenta,
        lightCyan: cyan,
        lightWhite: brightWhite,
        limeGreen: green,
        lightCoral: red,
      },
    },
    // default font weight: 'normal' or 'bold'
    fontWeight: 'normal',
    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: 'bold',
    // line height as a relative unit
    lineHeight: 1.1,
    // letter spacing as a relative unit
    letterSpacing: 0,
    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: white,
    // terminal text color under BLOCK cursor
    cursorAccentColor: black,
    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: 'BLOCK',
    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: true,
    // color of the text
    foregroundColor: white,
    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: black + op(0.5),
    // terminal selection color
    selectionColor: '#33467c' + op(0.6),
    // border color (window, tabs)
    borderColor: '#333',
    // custom CSS to embed in the main window
    css: '',
    // custom CSS to embed in the terminal window
    termCSS: '',
    // set custom startup directory (must be an absolute path)
    workingDirectory: '',
    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: '',
    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: '',
    // custom padding (CSS format, i.e.: `top right bottom left`)
    // padding: '12px 14px',
    padding: '12px 2px 4px 6px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black,
      red,
      green,
      yellow,
      blue,
      magenta,
      cyan,
      white,
      lightBlack: brightBlack,
      lightRed: red,
      lightGreen: green,
      lightYellow: yellow,
      lightBlue: blue,
      lightMagenta: magenta,
      lightCyan: cyan,
      lightWhite: brightWhite,
      limeGreen: green,
      lightCoral: red,
    },
    shell: 'zsh',
    shellArgs: ['--login'],
    env: {},
    //  1. 'SOUND' -> Enables the bell as a sound
    //  2. false: turns off the bell
    bell: false,
    copyOnSelect: false,
    defaultSSHApp: true,
    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    quickEdit: false,
    // choose either `'vertical'`, if you want the column mode when Option key is hold during selection (Default)
    // or `'force'`, if you want to force selection regardless of whether the terminal is in mouse events mode
    // (inside tmux or vim with mouse mode enabled for example).
    macOptionSelectionMode: 'vertical',
    // Whether to use the WebGL renderer. Set it to false to use canvas-based
    // rendering (slower, but supports transparent backgrounds)
    webGLRenderer: true,
    // keypress required for weblink activation: [ctrl|alt|meta|shift]
    // todo: does not pick up config changes automatically, need to restart terminal :/
    webLinksActivationKey: 'ctrl',
    // if `false` (without backticks and without quotes), Hyper will use ligatures provided by some fonts
    disableLigatures: false,
    // set to true to disable auto updates
    disableAutoUpdates: false,
    // set to true to enable screen reading apps (like NVDA) to read the contents of the terminal
    screenReaderMode: false,
    // set to true to preserve working directory when creating splits or tabs
    preserveCWD: true,
    // for advanced config flags please refer to https://hyper.is/#cfg
  },
  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: ['hypercwd', 'hyper-quit', 'verminal'],
  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],
  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
  },
};
//# sourceMappingURL=config-default.js.map
