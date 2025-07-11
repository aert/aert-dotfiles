-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

local opt = vim.opt
opt.relativenumber = false

vim.g.snacks_animate = false

-- Use :LazyFormat to format
vim.g.autoformat = false

-- vim.go.background = "light"

vim.g.mapleader = ","

-- support jbuilder files
vim.filetype.add({
  extension = {
    jbuilder = "ruby",
    axlsx = "ruby",
  },
})
