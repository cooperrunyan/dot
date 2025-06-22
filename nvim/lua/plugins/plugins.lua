return {
  { import = "plugins.themes" },
  {
    "andrewferrier/wrapping.nvim",
    cmd = {
      "HardWrapMode",
      "SoftWrapMode",
      "ToggleWrapMode",
    },
    keys = {
      { "<leader>tw", ":ToggleWrapMode<cr>", mode = "n", desc = "Toggle wrap mode" },
    },
    opts = {
      notify_on_switch = false,
    },
  },
  { "j-hui/fidget.nvim", event = { "VeryLazy" } },
  -- {
  -- 	"f-person/auto-dark-mode.nvim",
  -- 	opts = {},
  -- },
  { "yorickpeterse/nvim-pqf", event = { "VeryLazy" } },
  {
    "echasnovski/mini.ai",
    opts = {
      custom_textobjects = {
        ["'"] = { { "%b''", '%b""', "%b``" }, "^.().*().$" },
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    keys = {
      { "<c-t>", desc = "Open terminal" },
    },
    cmd = { "ColconBuild", "ToggleTerm" },
    opts = {
      open_mapping = "<c-t>",
      direction = "horizontal",
      hide_numbers = true,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      vim.api.nvim_create_user_command("ColconBuild", function(a)
        local ok, toggleterm = pcall(require, "toggleterm.terminal")

        if not ok then return end

        local Terminal = toggleterm.Terminal

        -- local packages = table.concat(args.args, " ")
        local cmd = "source /opt/ros/jazzy/setup.sh && colcon build --symlink-install"
        if a.args ~= "" then cmd = cmd .. " --packages-select " .. a.args end

        local term = Terminal:new({
          cmd = cmd,
          direction = "float",
          env = {
            AMENT_PREFIX_PATH = "",
            COLCON_PREFIX_PATH = "",
            CMAKE_PREFIX_PATH = "",
            GZ_VERSION = "harmonic",
          },
          on_open = function(term)
            vim.keymap.set(
              "n",
              "q",
              function() term:shutdown() end,
              { noremap = true, silent = true, buffer = term.bufnr }
            )
          end,
        })

        term:open()
      end, { desc = "Run colcon build", nargs = "*" })
    end,
  },
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>gg", ":Neogit<cr>", mode = "n", remap = false, silent = true, desc = "Git" },
    },
    opts = {
      graph_style = "unicode",
      highlight = { italic = false },
      mappings = {
        commit_editor = {
          ["<cr>"] = "Submit",
          ["<esc>"] = "Abort",
        },
        status = {
          ["l"] = "Toggle",
          ["S"] = "StageAll",
        },
      },
      integrations = {
        telescope = false,
      },
    },
    config = function(_, opts)
      require("neogit").setup(opts)

      vim.api.nvim_create_autocmd("BufLeave", {
        pattern = { "NeogitStatus" },
        callback = function()
          local ok, events = pcall(require, "neo-tree.events")
          if ok then events.fire_event(events.GIT_EVENT) end
        end,
      })
    end,
  },
  -- {
  -- 	"echasnovski/mini.comment",
  -- 	event = "BufRead",
  -- 	keys = {
  -- 		{ "<leader>C" },
  -- 		{ "<leader>c" },
  -- 		{ "<leader>c", mode = "v" },
  -- 	},
  -- 	opts = {
  -- 		options = {},
  -- 		mappings = {
  -- 			comment = "<leader>C",
  -- 			comment_line = "<leader>c",
  -- 			comment_visual = "<leader>c",
  -- 		},
  -- 	},
  -- },
  {
    "folke/flash.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function() require("flash").jump() end,
        desc = "Flash",
      },
      {
        "r",
        mode = "o",
        function() require("flash").remote() end,
        desc = "Remote Flash",
      },
    },
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
          preview = {
            type = "split",
            position = "right",
            size = 0.3,
          },
        },
      },
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Open Diagnostics",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List",
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_in_macro = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      -- check_ts = true,
      break_undo = true,
      enable_check_bracket_line = true,
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle git blame" },
      {
        "<leader>gd",
        ":Gitsigns toggle_numhl<CR>:Gitsigns toggle_linehl<CR>",
        desc = "Toggle git diff highlights",
      },
    },
    opts = {
      attach_to_untracked = true,
      current_line_blame_opts = {
        virt_text_pos = "right_align",
        delay = 0,
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end

        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
}
