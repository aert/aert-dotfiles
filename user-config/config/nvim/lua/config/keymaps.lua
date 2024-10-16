-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

local map = vim.keymap.set
local mapfile = " "
local user_cmd = vim.api.nvim_create_user_command
local wk = require("which-key")

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

map({ "n", "v" }, "<leader>yF", function()
  vim.cmd("MyCopyRelativePath")
end, { desc = mapfile .. "Copy relative path" })

map({ "n", "v" }, "<leader>yf", function()
  vim.cmd("MyCopyNamePath")
end, { desc = mapfile .. "Copy filename" })

map({ "n", "v" }, "<leader>yl", function()
  vim.cmd("MyCopyPathLine")
end, { desc = mapfile .. "Copy path & line" })

wk.add({
  mode = { "n", "v" },
  { "<leader>cr", group = "coercion" },
  { "<leader>cr-", desc = "Kebab Case (not reversible)" },
  { "<leader>cr.", desc = "Dot Case (not reversible)" },
  { "<leader>cr<space>", desc = "Space Case (not reversible)" },
  { "<leader>crU", desc = "Snake Upper Case" },
  { "<leader>cr_", desc = "Snake Case" },
  { "<leader>crc", desc = "Camel Case" },
  { "<leader>crk", desc = "Kebab Case" },
  { "<leader>crm", desc = "Mixed Case" },
  { "<leader>crs", desc = "Snake Case" },
  { "<leader>crt", desc = "Title Case (not reversible)" },
  { "<leader>cru", desc = "Snake Upper Case" },
})
