vim.pack.add({
  "https://github.com/ErickKramer/nvim-ros2",
})

require("nvim-ros2").setup({
  picker = "snacks",
  autocmds = true,
  treesitter = false,
  tuner = false,
  tuner_match_mode = "smart",
})

vim.treesitter.language.register("ros2", "ros")

local keys = {
  -- Base Pickers
  { "<leader>Rfi", function() require("nvim-ros2").pickers.interfaces() end, "List interfaces" },
  { "<leader>Rfn", function() require("nvim-ros2").pickers.nodes() end, "List nodes" },
  { "<leader>Rfa", function() require("nvim-ros2").pickers.actions() end, "List actions" },
  { "<leader>Rfs", function() require("nvim-ros2").pickers.services() end, "List services" },
  { "<leader>Rti", function() require("nvim-ros2").pickers.topics_info() end, "List topics with info" },
  { "<leader>Rte", function() require("nvim-ros2").pickers.topics_echo() end, "List topics with echo" },

  -- Workspace Navigator
  { "<leader>fRp", function() require("nvim-ros2").pickers.packages() end, "Find package" },
  { "<leader>fRf", function() require("nvim-ros2").pickers.find_files_package() end, "Find in Package" },
  { "<leader>fRg", function() require("nvim-ros2").pickers.grep_package() end, "Grep in Package" },
  { "<leader>fRc", function() require("nvim-ros2").pickers.edit_cmake() end, "Edit CMakeLists.txt" },
  { "<leader>fRP", function() require("nvim-ros2").pickers.edit_package_xml() end, "Edit package.xml" },

  -- Snipers
  { "<leader>fRm", function() require("nvim-ros2").pickers.sniper("msg") end, "Sniper: msg/" },
  { "<leader>fRs", function() require("nvim-ros2").pickers.sniper("srv") end, "Sniper: srv/" },
  { "<leader>fRa", function() require("nvim-ros2").pickers.sniper("action") end, "Sniper: action/" },
  { "<leader>fRi", function() require("nvim-ros2").pickers.sniper("include") end, "Sniper: include/" },

  { "<leader>Rfi", function() require("nvim-ros2").pickers.interfaces() end, "List interfaces" },
  { "<leader>Rfn", function() require("nvim-ros2").pickers.nodes() end, "List nodes" },
  { "<leader>Rfa", function() require("nvim-ros2").pickers.actions() end, "List actions" },
  { "<leader>Rfs", function() require("nvim-ros2").pickers.services() end, "List services" },
  { "<leader>Rti", function() require("nvim-ros2").pickers.topics_info() end, "List topics with info" },
  { "<leader>Rte", function() require("nvim-ros2").pickers.topics_echo() end, "List topics with echo" },
}

for _, row in ipairs(keys) do
  local key, body, desc = row[1], row[2], row[3]
  vim.keymap.set("n", key, body, { desc = "ros2: " .. desc, silent = true })
end

-- RPC Engine Keymaps (Buffer-Local)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "ROS_CALL_*",
  callback = function(args)
    local bufnr = args.buf
    local map_opts = { buffer = bufnr, silent = true }

    -- Execute the payload
    vim.keymap.set("n", "<CR>", "<cmd>RosRpc send<CR>", vim.tbl_extend("force", map_opts, { desc = "Send RPC Call" }))
    -- Gracefully cancel
    vim.keymap.set("n", "s", "<cmd>RosRpc stop<CR>", vim.tbl_extend("force", map_opts, { desc = "Stop RPC Call" }))
    -- Save with metadata
    vim.keymap.set(
      "n",
      "<leader>s",
      "<cmd>RosRpc save<CR>",
      vim.tbl_extend("force", map_opts, { desc = "Save Payload" })
    )
    -- Smart Load compatible payloads
    vim.keymap.set(
      "n",
      "<leader>l",
      function() require("nvim-ros2.pickers").saved_payloads() end,
      vim.tbl_extend("force", map_opts, { desc = "Load Payload" })
    )
    -- Quick exit
    vim.keymap.set("n", "q", "<cmd>q<CR>", vim.tbl_extend("force", map_opts, { desc = "Close RPC Buffer" }))
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "ROS_LISTEN_*",
  callback = function(args)
    local bufnr = args.buf
    local map_opts = { buffer = bufnr, silent = true }

    vim.keymap.set("n", "q", "<cmd>q<CR>", vim.tbl_extend("force", map_opts, { desc = "Stop listening" }))
  end,
})
