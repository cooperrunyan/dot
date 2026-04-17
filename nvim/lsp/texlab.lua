--- @type vim.lsp.Config
return {
  settings = {
    texlab = {
      build = {
        onSave = false,
        forwardSearchAfter = true,
        -- useFileList = true,
        auxDirectory = "build",
        logDirectory = "build",
        pdfDirectory = "build",
        executable = "tectonic",
        args = {
          "-X",
          "compile",
          "--keep-intermediates",
          "--keep-logs",
          "--synctex",
          "--outdir=build",
          "%f",
        },
      },
      forwardSearch = {
        executable = "displayline",
        args = { "-background", "-noselect", "-revert", "%l", "%p", "%f" },
      },
      chtex = {
        onOpenAndSave = true,
        onEdit = true,
      },
      latexFormatter = "tex-fmt",
    },
  },
}
