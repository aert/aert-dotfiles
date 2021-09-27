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
  -- side = 'right',
  -- ignore = [ '.git', 'node_modules', '.cache', '.idea' ],
  -- hide_dotfiles = 1,
  -- gitignore = 1,
  auto_close = 1,
  quit_on_open = 1,
  -- width = 50,
  -- follow = 1,
  -- git_hl = 1,
  -- special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1, 'Dockerfile': 1, 'Gemfile': 1, 'package.json': 1 },
}
EOF
