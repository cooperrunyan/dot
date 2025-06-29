return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  keys = {
    { "<leader>e", ":NvimTreeFocus<cr>", silent = true, desc = "Open File Tree" },
    { "<leader>E", ":NvimTreeToggle<cr>", silent = true, desc = "Toggle File Tree" },
  },

  opts = {
    disable_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    select_prompts = true,
    view = {
      width = 30,
      signcolumn = "no",
    },
    renderer = {
      -- hidden_display = "simple",
      indent_markers = {
        enable = true,
        icons = { corner = "╰" },
      },
      highlight_git = "name",
      icons = {
        web_devicons = {
          folder = { enable = false },
        },
        git_placement = "right_align",
        diagnostics_placement = "right_align",
        modified_placement = "right_align",
        padding = {
          icon = "  ",
          folder_arrow = " ",
        },
        show = {
          file = true,
          folder = false,
          folder_arrow = true,
          git = true,
          modified = true,
          diagnostics = false,
        },
        glyphs = {
          default = "",
          symlink = "",
          bookmark = "󰆤",
          modified = "●",
          hidden = "󰜌",
          folder = {
            arrow_closed = "",
            arrow_open = "",
            default = "",
            open = "",
            empty = "󰉖",
            empty_open = "",
          },
          git = {
            unstaged = "",
            staged = "✓",
            unmerged = "",
            renamed = "",
            untracked = "",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    diagnostics = { enable = false },
    modified = {
      enable = true,
      -- show_on_dirs = false,
      show_on_open_dirs = false,
    },
    ui = {
      confirm = {
        default_yes = true,
      },
    },
    filesystem_watchers = {
      ignore_dirs = {
        "build",
        "install",
        "node_modules",
        "target",
        "log",
      },
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      api.config.mappings.default_on_attach(bufnr)
      local opts = function(desc) return { desc = desc, buffer = bufnr, noremap = true, silent = true } end
      vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Collapse Node"))
      vim.keymap.set("n", "K", api.node.show_info_popup, opts("Show Info"))
      vim.keymap.set("n", "s", api.node.open.vertical, opts("Open Split"))
      vim.keymap.set("n", ".", api.tree.change_root_to_node, opts("Change Root"))
      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
      vim.keymap.set("n", "P", function() api.node.open.preview(nil, { focus = true }) end, opts("Preview"))
      vim.keymap.set("n", "d", api.fs.trash, opts("Delete"))
      vim.keymap.set("n", "y", api.fs.copy.node, opts("Copy"))
      vim.keymap.set("n", "H", api.tree.toggle_gitignore_filter, opts("Toggle Hidden"))
      vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
      vim.keymap.set("n", "a", api.fs.create, opts("Create File"))
      vim.keymap.set("n", "q", api.tree.close, opts("Quit"))
      vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
    end,
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        local invalid_win = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") ~= nil then table.insert(invalid_win, w) end
        end
        if #invalid_win == #wins - 1 then
          -- Should quit, so we close all invalid windows.
          for _, w in ipairs(invalid_win) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
}
