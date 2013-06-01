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
let g:ctrlp_working_path_mode = ''

" ### My Personal Config
" ######################

syntax enable
set gfn=Ubuntu\ Mono\ 10
set nu
autocmd FileType python set omnifunc=pythoncomplete#Complete

autocmd BufEnter * silent! lcd %:p:h

if has('gui_running')
    "colorscheme solarized
    "set background=dark
    colorscheme smyck
    set lines=45 columns=150
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

" shortcuts to common commands
let mapleader = ","


filetype plugin indent on
filetype plugin on

" ### MY KEY MAPPINGS
" ###################

" ,cd to change to current file dir & print pwd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
