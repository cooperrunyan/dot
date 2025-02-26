return {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function(_, opts)
      require('github-theme').setup(opts)

      vim.cmd('colorscheme github_dark_default')
    end,
    opts = {
      options = {
        darken = {
          floats = false,
          sidebars = {
            enable = false
          }
        },
        hide_end_of_buffer = true,
        modules = {
          cmp = { enable = true },
          diagnostic = { enable = true },
          fzf = { enable = true },
          gitsigns = { enable = true },
          whichkey = { enable = true },
          neotree = { enable = true },
        }
      },
      groups = {
        all = {
          CursorLine = { bg = "bg2" },
          NeoTreeDirectoryIcon = { fg = "bg4" },
          NeoTreeIndentMarker = { fg = "bg3" },
          NeoTreeGitAdded = { link = "Normal" },
          NeoTreeGitIgnored = { link = "Comment" },
          NeoTreeGitUntracked = { fg = "palette.green" },
          NeoTreeGitModified = { fg = "palette.yellow" },
          NeoTreeGitConflict = { fg = "palette.red" },
          NeoTreeGitDeleted = { fg = "palette.red" },
        }
      }
    }
  }
