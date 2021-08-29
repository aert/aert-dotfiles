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

" let npm_bin=system('npm bin')
" let $PATH=$PATH . ":" . npm_bin
set shell=zsh
" let g:python3_host_prog = '/usr/bin/python3'

source ~/.config/nvim/plugins.vim
source ~/.config/nvim/plugins-setup.vim
source ~/.config/nvim/keys.vim

"##############################################################################
"### Bundle Configs ###########################################################
"##############################################################################

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99


" ### My Personal Config
" ######################

set clipboard=unnamedplus
set modeline

" Tabs
":set guitablabel=%N\ %f

set ignorecase

" Better copy & paste
set pastetoggle=<F3>
"set clipboard=unnamed

" Ignore some file
set wildignore+=*.swp,*.bak,*.pyc,*.class
set cursorline
set nowrap

" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0 wrapmargin=0

set incsearch
set hlsearch
set noshowmatch
let loaded_matchparen = 1
set ttyfast
set backspace=indent,eol,start
set smartcase

syntax enable
set gfn=Operator\ Mono\ Medium\ 11
set nu
" set nonumber
" set relativenumber

autocmd BufEnter * silent! lcd %:p:h

" disable syntax hl on big files
au BufReadPost * if getfsize(bufname("%")) > 502400 | set syntax= | endif

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

if (has("termguicolors"))
  set termguicolors
endif

let g:airline_theme = 'jellybeans'
colorscheme catppuccino

if has('gui_running')
    set lines=999 columns=999
    set mousehide
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set ghr=0
else
    " let g:solarized_termtrans=1
endif

" set nocursorline
set colorcolumn=80

""""""""""""""""""""""
"      Settings      "
""""""""""""""""""""""

" Expand tabs to 2 spaces
set shiftwidth=2
set tabstop=2
set smarttab
set expandtab
set textwidth=79
set softtabstop=2
set shiftround
set autoread                    " Automatically read changed files
set noerrorbells                " No beeps
set encoding=utf-8              " Set default encoding to UTF-8
set showcmd                     " Show me what I'm typing
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.
"set nocursorcolumn              " Do not highlight column (speeds up highlighting)
"set nocursorline                " Do not highlight cursor (speeds up highlighting)
"set lazyredraw                  " Wait to redraw

set nobackup
set nowritebackup
set noswapfile

" keep at least 5 lines below the cursor
set scrolloff=5

" enable mouse support
set mouse=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" don't close buffer when tab is closed
set hidden

set wrapmargin=0
set textwidth=0
