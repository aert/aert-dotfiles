syntax enable

set wildignore+=*.swp,*.bak,*.pyc,*.class

" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0 wrapmargin=0

set incsearch
set hlsearch
set noshowmatch
let loaded_matchparen = 1
set ttyfast
set backspace=indent,eol,start
set smartcase
set foldlevel=99
set clipboard=unnamedplus
set modeline
set ignorecase
set pastetoggle=<F3>            " Better copy & paste
set shiftwidth=2                " Expand tabs to 2 spaces
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
set scrolloff=5                 " keep at least 5 lines below the cursor
set mouse=a                     " enable mouse support
set hidden                      " don't close buffer when tab is closed
set cursorline
set nowrap
set nu
set colorcolumn=80
"set nocursorcolumn              " Do not highlight column (speeds up highlighting)
"set nocursorline                " Do not highlight cursor (speeds up highlighting)
"set lazyredraw                  " Wait to redraw

set nobackup
set nowritebackup
set noswapfile

set updatetime=300               " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set signcolumn=number            " Always show the signcolumn, otherwise it would shift the text each time

