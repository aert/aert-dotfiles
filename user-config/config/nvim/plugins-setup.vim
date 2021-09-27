lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "html" }
  },
}

require("which-key").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

require('nvim-tree').setup {
    -- ignore = [ '.git', 'node_modules', '.cache', '.idea' ],
    -- hide_dotfiles = 1,
    -- gitignore = 1,
    auto_close = 1,
    quit_on_open = 1,
    -- follow = 1,
    -- git_hl = 1,
    -- special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1, 'Dockerfile': 1, 'Gemfile': 1, 'package.json': 1 },
    view = {
        -- width of the window, can be either a number (columns) or a string in `%`
        width = 50,
        -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
        side = 'right',
        -- if true the tree will resize itself after opening a file
        auto_resize = true,
        }
}
EOF
