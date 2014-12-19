" Requirements
" ============
"
" * pip install rst2ctags
"
"

" ### Vundle
" ###########
filetype off

let $PATH=$PATH . ':$(npm bin)'

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
"Bundle 'saltstack/salt-vim'
Bundle 'kien/ctrlp.vim'
"Bundle "hdima/python-syntax"
Bundle 'vim-scripts/Align'
Bundle 'mattn/emmet-vim'
Bundle 'aklt/plantuml-syntax'
Bundle 'tpope/vim-surround.git'
Bundle 'evanmiller/nginx-vim-syntax'
Bundle 'Valloric/YouCompleteMe'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'nathanaelkane/vim-indent-guides'
"Bundle 'Raimondi/delimitMate'
Bundle 'elzr/vim-json'
"Bundle 'maksimr/vim-jsbeautify'
Bundle 'einars/js-beautify'
Bundle 'digitaltoad/vim-jade'
Bundle 'groenewege/vim-less'
"Bundle 'fholgado/minibufexpl.vim'
Bundle 'sjl/gundo.vim'
Bundle 'mileszs/ack.vim'
"Bundle 'bling/vim-airline'
"Bundle 'tpope/vim-rails'
Bundle 'lukaszkorecki/CoffeeTags'
Bundle 'croaker/mustang-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'jnurmine/Zenburn'
Bundle 'chrisbra/NrrwRgn'


" ### Bundle Configs

" Powerline
set laststatus=2 
"set fillchars+=stl:\ ,stlnc:\
set encoding=utf-8

" NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <silent> <F8> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.pyc$', '\.bak$']

" TAGBAR
nmap <F9> :TagbarToggle<CR>
let g:tagbar_sort = 0
let g:tagbar_compact = 1


" CtrlP
let g:ctrlp_working_path_mode = 'r'

" Python.vim
let python_highlight_all = 1 

" Syntastic
let g:syntastic_python_checkers=['flake8']
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

" YCM
" Settings from https://code.djangoproject.com/wiki/UsingVimWithDjango
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
" These are the tweaks I apply to YCM's config, you don't need them but they might help.
" YCM gives you popups and splits by default that some people might not like, so these should tidy it up a bit for you.
"let g:ycm_add_preview_to_completeopt=0
"let g:ycm_confirm_extra_conf=0
"set completeopt-=preview


" Js Beautifier
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" Vim Airline
"let g:airline_powerline_fonts=1

" Indent Guide
let g:indent_guides_guide_size=1

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

" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0 wrapmargin=0

" Foldmethod
set foldmethod=indent
set foldlevel=99

syntax enable
"set gfn=Ubuntu\ Mono\ 10
set gfn=Monaco\ 10
"set gfn=Fira\ Mono\ 10
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
    colorscheme zenburn
    "colorscheme herald
    "colorscheme mustang
    "set lines=43 columns=140
    set lines=999 columns=999
    set mousehide
    set guioptions-=T
else
    "set background=dark
    colorscheme elflord
endif

" RST
let g:tagbar_type_rst = {
    \ 'ctagstype': 'rst',
    \ 'ctagsbin' : '~/bin/rst2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

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
"py << EOF
"import os.path
"import sys
"import vim
"if 'VIRTUAL_ENV' in os.environ:
"    project_base_dir = os.environ['VIRTUAL_ENV']
"    sys.path.insert(0, project_base_dir)
"    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"    execfile(activate_this, dict(__file__=activate_this))
"EOF

filetype plugin indent on
filetype plugin on

" ### MY KEY MAPPINGS
" ###################

nnoremap ,h :tabprevious<CR>
nnoremap ,l :tabnext<CR>
nnoremap ,d :NERDTreeToggle<CR>
nnoremap <F5> :GundoToggle<CR>
nmap <leader>a <Esc>:Ack!

" ,cd to change to current file dir & print pwd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
