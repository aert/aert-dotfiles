" Requirements
" ============
"
" * https://github.com/iamcco/coc-flutter
" :CocInstall coc-flutter
" :CocInstall coc-tsserver
" :CocInstall coc-solargraph
" :CocInstall coc-json
" :CocInstall coc-sh
" :CocInstall coc-css
" :CocInstall coc-html
" :CocInstall coc-snippets
" :CocInstall coc-yaml
" :CocInstall coc-highlight
" :CocInstall coc-jedi
" * apt-get install ack-grep
"
" :TSInstall
"

set shell=zsh
" let g:python3_host_prog = '/usr/bin/python3'

source ~/.config/nvim/plugins.vim
lua require('plugins-setup') 
source ~/.config/nvim/basic.vim
source ~/.config/nvim/keys.vim

" autocmd .....................................................................

autocmd BufEnter * silent! lcd %:p:h

" disable syntax hl on big files
au BufReadPost * if getfsize(bufname("%")) > 502400 | set syntax= | endif

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

" theme .......................................................................

if (has("termguicolors"))
  set termguicolors
endif

set background=dark
" colorscheme zenburn
" colorscheme PaperColor
colorscheme duskfox
let g:airline_theme = 'solarized'

" let g:airline_theme = 'jellybeans'
" colorscheme catppuccino
" colorscheme calvera
" colorscheme tokyonight
