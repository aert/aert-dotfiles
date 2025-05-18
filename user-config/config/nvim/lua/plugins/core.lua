-- https://www.lazyvim.org/configuration/recipes#make-tokyonight-transparent
return {
  -- themes
  {
    {
      "tokyonight.nvim",
      opts = {
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      },
    },
    {
      "rebelot/kanagawa.nvim",
      opts = {
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      },
    },
    {
      "sainnhe/everforest",
      config = function()
        vim.g.everforest_transparent_background = 2
        vim.g.everforest_float_style = "dim"
        vim.g.everforest_diagnostic_text_highlight = 1
        vim.g.everforest_diagnostic_line_highlight = 1
        vim.g.everforest_diagnostic_virtual_text = "highlighted"
        vim.g.everforest_dim_inactive_windows = 1
        vim.g.everforest_ui_contrast = "high"
      end,
    },
    { "EdenEast/nightfox.nvim" },
    {
      -- "folke/tokyonight.nvim",
      "LazyVim/LazyVim",
      opts = {
        -- colorscheme = "gruvbox",
        -- colorscheme = "catppuccin-mocha",
        -- colorscheme = "murphy",
        -- colorscheme = "desert",
        -- colorscheme = "tokyonight-moon",
        colorscheme = "kanagawa",
        -- colorscheme = "vim",
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      },
    },
  },
}
