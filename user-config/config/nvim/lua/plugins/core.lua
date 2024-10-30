-- https://www.lazyvim.org/configuration/recipes#make-tokyonight-transparent
return {
  -- themes
  { "ellisonleao/gruvbox.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "sainnhe/everforest" },
  { "EdenEast/nightfox.nvim" },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    -- "folke/tokyonight.nvim",
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvbox",
      -- colorscheme = "catppuccin-mocha",
      -- colorscheme = "murphy",
      -- colorscheme = "desert",
      -- colorscheme = "tokyonight-moon",
      colorscheme = "kanagawa-lotus",
      -- colorscheme = "vim",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
