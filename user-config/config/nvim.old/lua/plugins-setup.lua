local lsp_installer = require("nvim-lsp-installer")
lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
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
            resize_window = true,
        },
    },
    renderer = {
        highlight_git = true,
        special_files = { 'README.md', 'Makefile', 'MAKEFILE', 'Dockerfile', 'Gemfile', 'package.json' }
    },
}

require('gitsigns').setup{
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
        end, {expr=true})

        map('n', '[c', function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
        end, {expr=true})
    end
}

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
