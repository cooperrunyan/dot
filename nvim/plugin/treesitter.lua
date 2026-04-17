vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

-- "windwp/nvim-ts-autotag", -- html auto tags

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})

local langs = {
  "bash",
  "c",
  "cpp",
  "cmake",
  "devicetree",
  "dockerfile",
  "diff",
  "disassembly",
  "git_config",
  "gitcommit",
  "git_rebase",
  "gitignore",
  "gitattributes",
  "glsl",
  "html",
  "javascript",
  "json",
  "latex",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "make",
  "matlab",
  "mermaid",
  "python",
  "regex",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "vhdl",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
  "zsh",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = langs,
  callback = function()
    vim.treesitter.start()
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.bo.indentexpr = "v:lua:require'nvim-treesitter'.indentexpr()"
  end,
})

require("nvim-treesitter").install(langs)
