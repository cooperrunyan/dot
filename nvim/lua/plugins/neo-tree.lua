return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>e",
      function() require("neo-tree.command").execute({ action = "focus" }) end,
      desc = "Focus File Tree",
    },
    {
      "<leader>E",
      function() require("neo-tree.command").execute({ toggle = true }) end,
      desc = "Toggle File Tree",
    },
  },
  deactivate = function() vim.cmd([[Neotree close]]) end,
  opts = function()
    local opts = {
      enable_diagnostics = false,
      -- sources = { "filesystem", "buffers", "git_status" },
      sources = { "filesystem" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      close_if_last_window = true,
      -- enable_cursor_hijack = true,
      use_popups_for_input = true,
      filesystem = {
        bind_to_cwd = true,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
          never_show = {
            ".DS_Store",
            ".git",
            "yarn.lock",
            "bun.lockb",
            "package-lock.json",
            ".mypy_cache",
            ".pytest_cache",
            "__pycache__",
            "node_modules",
          },
        },
      },
      window = {
        width = 35,
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<leader>h"] = "toggle_hidden",
          ["<leader>l"] = {
            function() vim.cmd("wincmd p") end,
            desc = "Return to previous window",
          },
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state) require("lazy.util").open(state.tree:get_node().path, { system = true }) end,
            desc = "Open with System Application",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = false,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
          last_indent_marker = "╰",
        },
        diagnostics = {
          error = " ",
          warn = " ",
          hint = " ",
          info = " ",
        },
        icon = {
          folder_closed = " ",
          folder_open = " ",
          folder_empty = "󰉖 ",
          folder_empty_open = " ",
          provider = function(icon, node, _)
            if node.type == "file" or node.type == "terminal" then
              local success, web_devicons = pcall(require, "nvim-web-devicons")
              local name = node.type == "terminal" and "terminal" or node.name
              if success then
                local devicon, hl = web_devicons.get_icon(name)
                icon.text = devicon or icon.text
                if icon.text ~= "" then icon.text = icon.text .. " " end
                icon.highlight = hl or icon.highlight
              end
            end
          end,
        },
        git_status = {
          symbols = {
            -- Change type
            added = "✚",
            deleted = "✖",
            modified = "",
            renamed = "󰁕",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
    }

    local ok, snacks = pcall(require, "snacks")
    if ok then
      local function on_move(data) snacks.rename.on_rename_file(data.source, data.destination) end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
    end

    return opts
  end,
}
