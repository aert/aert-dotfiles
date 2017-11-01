" Requirements
" ============
"
" * pip install rst2ctags
" * apt-get install ack-grep
"

" ### Vundle
" ###########
filetype off

let npm_bin=system('npm bin')
"let yarn_bin="/home/ari/.nvm/versions/node/v7.8.0/bin"

"let $PATH=$PATH . ":" . yarn_bin . ":" . npm_bin
let $PATH=$PATH . ":" . npm_bin
set shell=zsh

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

"### system ###################################################################
" code analysis
Bundle 'scrooloose/syntastic'
Bundle 'davidhalter/jedi-vim'
" completion
Bundle 'Valloric/YouCompleteMe'
Bundle 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Bundle 'mattn/emmet-vim'
" format
Plugin 'sbdchd/neoformat'
" git
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
" motion
Bundle 'easymotion/vim-easymotion'
Bundle 'gcmt/taboo.vim'
" navigation
"Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'junegunn/fzf'
Bundle 'junegunn/fzf.vim'
Bundle 'dyng/ctrlsf.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
" themes
Bundle 'croaker/mustang-vim'
Bundle 'sickill/vim-monokai'
Bundle 'junegunn/seoul256.vim'
Bundle 'itchyny/lightline.vim'
"### languages ################################################################
" go
Plugin 'fatih/vim-go'
" javascript
Plugin 'galooshi/vim-import-js'
Plugin 'mtscout6/syntastic-local-eslint.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'mxw/vim-jsx'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'einars/js-beautify'
" rails
Bundle 'tpope/vim-rails'
Bundle 'ngmy/vim-rubocop'
Plugin 'tpope/vim-endwise.git'
" rust
Bundle 'rust-lang/rust.vim'

"##############################################################################
"### Bundle Configs ###########################################################
"##############################################################################

" Go Vim
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" Emmet
autocmd FileType html,css,javascript.jsx EmmetInstall
let g:user_emmet_leader_key='<C-X>'

" Taboo
set guioptions-=e
let g:taboo_tab_format = ' %N-%f%m '

" LightLine
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }
set laststatus=2 

" javascript-libraries-syntax
let g:used_javascript_libs = 'jquery,underscore,react,requirejs'

" "vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size=1

" NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <silent> <F8> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.pyc$', '\.bak$', 'node_modules']

" TAGBAR
nmap <F9> :TagbarToggle<CR>
let g:tagbar_sort = 0
let g:tagbar_compact = 1

" Python.vim
let python_highlight_all = 1 

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

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
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" CtrlP
"let g:ctrlp_working_path_mode = 'r'
"let g:ctrlp_custom_ignore = '\v[\/](node_modules|vendor|target|dist|coverage|build)|(\.(swp|ico|git|svn))$'
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"if executable('ag')
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"endif

" Fzf

" CtrlSF
let g:ctrlsf_default_root='project'
let g:ctrlsf_auto_close = 1
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_mapping = {
    \ "split"   : "i",
    \ "vsplit"  : "s",
    \ "tab"     : "t",
    \ }
let g:ctrlsf_ignore_dir = ["node_modules", "coverage", "dist", "vendor", "target", "build"]

" Taboo
set ssop-=folds      " do not store folds
set ssop+=tabpages,globals

" vim-go
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" NeoFormat
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_ruby = ['rubocop']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_sass = ['prettier']
let g:neoformat_enabled_scss = ['prettier']
let g:neoformat_enabled_less = ['prettier']
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

" ### My Personal Config
" ######################

set clipboard=unnamedplus

" Tabs
:set guitablabel=%N\ %f

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

" Foldmethod
set foldmethod=indent
set foldlevel=99

set incsearch
set hlsearch
set noshowmatch
let loaded_matchparen = 1
set ttyfast
set backspace=indent,eol,start
set smartcase
" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

syntax enable
"set gfn=Ubuntu\ Mono\ 13
"set gfn=Consolas\ 11
set gfn=Fira\ Mono\ Medium\ 11
set nu
set relativenumber
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown,ctp set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType javascript setl sw=2 sts=2 et
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php,ctp set omnifunc=phpcomplete#CompletePHP
"autocmd FileType vim set omnifunc=syntaxcomplete#Complete

autocmd BufEnter * silent! lcd %:p:h

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

if has('gui_running')
    "colorscheme solarized
    "set background=dark
    "set background=light
    "colorscheme zenburn
    "colorscheme herald
    "colorscheme mustang
    colorscheme railscasts
    "set lines=43 columns=140
    set lines=999 columns=999
    set mousehide
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set ghr=0
else
    "colorscheme monokai
    colorscheme seoul256
    "let g:seoul256_background = 235
    set background=dark
    let g:solarized_termcolors=256
    "hi TabLineFill ctermfg=LightGreen ctermbg=NONE
    "hi TabLine ctermfg=Grey ctermbg=NONE
    "hi TabLineSel ctermfg=White ctermbg=NONE
endif

set colorcolumn=80 
highlight ColorColumn ctermbg=235 guibg=#2c2d27
"let &colorcolumn=join(range(81,999),",")

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
set ttyscroll=3                 " Speedup scrolling
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

map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>

nnoremap ,c :let @+ = expand("%:p").":".line('.')<cr>
nnoremap ,h :tabprevious<CR>
nnoremap ,l :tabnext<CR>
nnoremap ,d :NERDTreeToggle<CR>
nnoremap ,e :tabnew<CR>
nnoremap ,n :NERDTreeFind<CR>
"nnoremap ,t :TagbarToggle<CR>
nnoremap ,p :TagbarToggle<CR>
nnoremap ,f :CtrlSF 
nnoremap ,,f :CtrlSFToggle<CR>
vmap     ,f <Plug>CtrlSFVwordExec
"nnoremap <F5> :GundoToggle<CR>
nmap s <Plug>(easymotion-overwin-f)
nnoremap ,r :YcmCompleter GoToReferences<CR>
nmap ; :Buffers<CR>
nmap ,t :GFiles<CR>
nmap ,r :Tags<CR>
nmap <SPACE> :noh<CR>

nnoremap ,ga :Git add %:p<CR><CR>
nnoremap ,gs :Gstatus<CR>
nnoremap ,gc :Gcommit<CR>
nnoremap ,gp :Gpush<CR>
nnoremap ,gb :Gblame<CR>
nnoremap ,gd :Gdiff<CR>

nnoremap ,w :ImportJSWord<CR>

nnoremap ,pc :CtrlPClearAllCaches<CR>

" ,cd to change to current file dir & print pwd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
