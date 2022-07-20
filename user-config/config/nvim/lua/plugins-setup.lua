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


local cmp = require'cmp'
cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'ultisnips' }, -- For ultisnips users.
                    { name = 'buffer' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'path' },
                })
        })

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lsp_installer.on_server_ready(function(server)
    local opts = {
        capabilities = capabilities,
    }

    server:setup(opts)
end)

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
