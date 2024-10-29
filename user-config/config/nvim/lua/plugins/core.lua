-- https://www.lazyvim.org/configuration/recipes#make-tokyonight-transparent
return {  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  {
    -- "folke/tokyonight.nvim",
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvbox",
      -- colorscheme = "catppuccin-mocha",
      -- colorscheme = "murphy",
      -- colorscheme = "desert",
      colorscheme = "tokyonight-moon",
      -- colorscheme = "vim",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
