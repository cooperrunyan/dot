local group = vim.api.nvim_create_augroup("ZMKFormat", { clear = true })

return {
  "codethread/qmk.nvim",
  event = "BufRead *.keymap",
  config = function(_, opts)
    vim.cmd("set ft=dts")

    vim.api.nvim_clear_autocmds({ group = group })

    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "Format ZMK File",
      pattern = "*.keymap",
      command = "QMKFormat",
      group = group,
    })

    require('qmk').setup(opts)
  end,
  opts = function()
    local opts = {
      name = "meh",
      variant = "zmk",
      layout = {
        "x x x x x x _ x x x x x x",
        "x x x x x x _ x x x x x x",
        "x x x x x x _ x x x x x x",
        "_ _ _ x x x _ x x x _ _ _",
      },
      comment_preview = {
        keymap_overrides = {
          ["&kp "] = "",
          ["&none"] = "",
          ["&trans"] = "",
          ["&mo "] = "L",
          ["BSPC"] = "󰭜 ",
          ["&sys_reset"] = "RESET",
          ["&bt BT_SEL"] = "BT",
          ["&bt BT_CLR"] = "BT CLEAR",
          ["C_PREV"] = "BACK",
          ["C_NEXT"] = "SKIP",
          ["C_VOL_DN"] = "VOL -",
          ["C_VOL_UP"] = "VOL +",
          ["C_BRI_DN"] = "BRI -",
          ["C_BRI_UP"] = "BRI +",
          ["EXCL"] = "!",
          ["AT"] = "@",
          ["HASH"] = "#",
          ["DLLR"] = "$",
          ["CARET"] = "^",
          ["AMPS"] = "&",
          ["ASTRK"] = "*",
          ["LPAR"] = "(",
          ["RPAR"] = ")",
          ["PIPE"] = "|",
          ["LBRC"] = "{",
          ["RBRC"] = "}",
          ["LBKT"] = "[",
          ["RBKT"] = "]",
          ["EQUAL"] = "=",
          ["UNDER"] = "_",
          ["MINUS"] = "-",
          ["PLUS"] = "+",
          ["BSLH"] = "\\",
          ["SEMI"] = ";",
          ["SQT"] = "'",
          ["COMMA"] = ",",
          ["DOT"] = ".",
          ["FSLH"] = "/",
          ["C_PP"] = "PAUSE",
          ["GRAVE"] = "~",
        }
      }
    }

    for i = 0, 9 do
      opts.comment_preview.keymap_overrides[string.format("&kp N%d", i)] = string.format("%d", i)
    end

    return opts
  end,
}
