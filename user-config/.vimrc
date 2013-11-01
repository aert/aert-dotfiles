" ### Vundle
" ###########
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

" My Bundles
Bundle 'tpope/vim-fugitive'
Bundle 'aert/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'davidhalter/jedi-vim'
Bundle 'scrooloose/syntastic'
Bundle 'saltstack/salt-vim'
Bundle 'kien/ctrlp.vim'
Bundle "hdima/python-syntax"
Bundle 'vim-scripts/Align'
Bundle 'mattn/emmet-vim'
Bundle 'aklt/plantuml-syntax'
Bundle 'tpope/vim-surround.git'

" ### Bundle Configs

" Powerline
set laststatus=2 
set fillchars+=stl:\ ,stlnc:\
set encoding=utf-8

" NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <silent> <F8> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.pyc$', '\.bak$']

" TAGBAR
nmap <F9> :TagbarToggle<CR>

" CtrlP
let g:ctrlp_working_path_mode = 'ra'

" Python.vim
let python_highlight_all = 1 

" Syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5

" Surround - Django
let b:surround_{char2nr("v")} = "{{ \r }}"
let b:surround_{char2nr("{")} = "{{ \r }}"
let b:surround_{char2nr("%")} = "{% \r %}"
let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"

" ### My Personal Config
" ######################

" Django
autocmd BufEnter *html map <F10> :setfiletype htmldjango<CR>
autocmd BufEnter *html map <S-F10> :setfiletype django<CR>

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %
set ignorecase

" Better copy & paste
set pastetoggle=<F3>
set clipboard=unnamed

" MACROS
let @t='i( ) TASK ``+categ @=system(''date -u -Iseconds'')kJi``hhvhhhhxhhhxhhhxhhhr-hhhxhhhx'

" Ignore some file
set wildignore=*.swp,*.bak,*.pyc,*.class
set cursorline
set colorcolumn=80 
set nowrap

syntax enable
set gfn=Ubuntu\ Mono\ 10
set nu
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown,ctp set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php,ctp set omnifunc=phpcomplete#CompletePHP
autocmd FileType vim set omnifunc=syntaxcomplete#Complete

autocmd BufEnter * silent! lcd %:p:h

if has('gui_running')
    "colorscheme solarized
    "set background=dark
    "colorscheme herald
    colorscheme Mustang
    "set lines=43 columns=140
    set lines=999 columns=999
    set nomousehide
else
    "set background=dark
    colorscheme elflord
endif

" ### Settings from https://github.com/tmacwill/vimrc/blob/master/.vimrc

" Expand tabs to 4 spaces
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set textwidth=79
set softtabstop=4
set shiftround

" disable backups
set nobackup
set nowritebackup
set noswapfile

" disable annoying beep on errors
set noerrorbells
if has('autocmd')
  autocmd GUIEnter * set vb t_vb=
endif

" keep at least 5 lines below the cursor
set scrolloff=5

" enable mouse support
set mouse=a

" close buffer when tab is closed
set nohidden

" better moving between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Useful when moving accross long lines
map j gj
map k gk

" shortcuts to common commands
let mapleader = ","

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

filetype plugin indent on
filetype plugin on

" ### MY KEY MAPPINGS
" ###################

nnoremap ,p :tabprevious<CR>
nnoremap ,n :tabnext<CR>

" ,cd to change to current file dir & print pwd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
