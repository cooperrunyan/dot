vim.pack.add({ "https://github.com/akinsho/toggleterm.nvim" })

require("toggleterm").setup({
  open_mapping = "<c-t>",
  direction = "horizontal",
  hide_numbers = true,
})

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  callback = function(ev)
    if vim.bo[ev.buf].ft == "terminal" then vim.cmd(":startinsert") end
  end,
})

vim.api.nvim_create_user_command("ColconBuild", function(a)
  local ok, toggleterm = pcall(require, "toggleterm.terminal")

  if not ok then return end

  local Terminal = toggleterm.Terminal

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
    close_on_exit = false,
    on_open = function(term)
      vim.keymap.set("n", "q", function() term:shutdown() end, { noremap = true, silent = true, buffer = term.bufnr })
    end,
  })

  term:open()
end, { desc = "Run colcon build", nargs = "*" })
