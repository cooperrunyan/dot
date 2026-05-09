local M = {}

local refresh_lualine = function()
  local ok, lualine = pcall(require, "lualine")
  if ok then lualine.refresh({
    scope = "all",
    place = { "statusline" },
    trigger = "unknown",
  }) end
end

M.toggle_local = function()
  vim.b.disable_autoformat = not vim.b.disable_autoformat
  refresh_lualine()
end

M.toggle_global = function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  refresh_lualine()
end

M.toggle = function(global)
  if global then
    M.toggle_global()
  else
    M.toggle_local()
  end
end

return M
