-- https://www.lazyvim.org/configuration/recipes#make-tokyonight-transparent
return {  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  {
    -- "folke/tokyonight.nvim",
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
