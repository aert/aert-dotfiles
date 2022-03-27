require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { "html" }
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
        },
    },
}

require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

require('nvim-tree').setup {
    hijack_cursor = true,
    update_focused_file = {
        enable = true,
        update_cwd = false,
    },
    view = {
        width = 50,
        side = 'right',
        auto_resize = true,
    },
    filters = {
        dotfiles = true,
        custom = {'.git', 'node_modules', '.cache', '.idea'}
    },
    git = {
        ignore = true
    },
    actions = {
        open_file  = {
            quit_on_open = true,
        },
    },
}

require('gitsigns').setup()

-- symbols_outline
vim.g.symbols_outline = {
    position = 'left',
    width = 50,
}

require('telescope').setup()
require('telescope').load_extension('ultisnips')

require('nightfox').setup({
  options = {
    transparent = true,    -- Disable setting background
    dim_inactive = true,   -- Non focused panes set to alternative background
  }
})
