-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set
local mapfile = " "
local user_cmd = vim.api.nvim_create_user_command

-- utils ......................................................................

user_cmd("MyCopyRelativePath", function()
  local path = vim.fn.expand("%:f")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

user_cmd("MyCopyNamePath", function()
  local path = vim.fn.expand("%:t")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

user_cmd("MyCopyPathLine", function()
  local path = vim.fn.expand("%:p") .. ":" .. vim.fn.line(".")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- mappings ...................................................................

map({ "n", "v" }, "<leader>yf", function()
  vim.cmd("MyCopyRelativePath")
end, { desc = mapfile .. "Copy relative path" })

map({ "n", "v" }, "<leader>yF", function()
  vim.cmd("MyCopyNamePath")
end, { desc = mapfile .. "Copy filename" })

map({ "n", "v" }, "<leader>yl", function()
  vim.cmd("MyCopyPathLine")
end, { desc = mapfile .. "Copy path & line" })
