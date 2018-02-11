" Requirements
" ============
"
" * pip install rst2ctags
" * apt-get install ack-grep
"

" ### Vim-Plug
" ###########

let npm_bin=system('npm bin')
let $PATH=$PATH . ":" . npm_bin
set shell=zsh
let g:python3_host_prog = '~/.pyenv/versions/3.6.3/bin/python'

call plug#begin('~/.vim/bundle')

"### system ###################################################################
Plug 'tpope/vim-dispatch'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
" code analysis
Plug 'scrooloose/syntastic'
Plug 'davidhalter/jedi-vim'
" completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --js-completer' }
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/emmet-vim'
" format
Plug 'sbdchd/neoformat'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown'] }
" git
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
" motion
Plug 'easymotion/vim-easymotion'
"Plug 'gcmt/taboo.vim'
" navigation
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'arithran/vim-delete-hidden-buffers'
" tests
Plug 'janko-m/vim-test'
" themes
Plug 'croaker/mustang-vim'
Plug 'sickill/vim-monokai'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-janah'
"### languages ################################################################
Plug 'sheerun/vim-polyglot'
" css
Plug 'ap/vim-css-color'
Plug 'hail2u/vim-css3-syntax', { 'for' : ['css', 'less', 'scss'] }
" go
Plug 'fatih/vim-go', { 'for' : ['go', 'markdown'] }
" javascript
Plug 'galooshi/vim-import-js'
Plug 'mtscout6/syntastic-local-eslint.vim'
" rails
Plug 'tpope/vim-rails', { 'for' : ['ruby'] }
Plug 'tpope/vim-bundler', { 'for' : ['ruby'] }
Plug 'ngmy/vim-rubocop', { 'for' : ['ruby'] }
Plug 'tpope/vim-endwise'
" rust
"Bundle 'rust-lang/rust.vim'

call plug#end()

"##############################################################################
"### Bundle Configs ###########################################################
"##############################################################################

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "atomic"
set laststatus=2 


autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" vim test
let test#strategy = "dispatch"

" Go Vim
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" Emmet
autocmd FileType html,css,javascript.jsx EmmetInstall
let g:user_emmet_leader_key='<C-X>'

" Taboo
set guioptions-=e
"let g:taboo_tab_format = ' %N-%f%m '

" javascript-libraries-syntax
let g:used_javascript_libs = 'jquery,underscore,react,requirejs'

" "vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size=1

" NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.pyc$', '\.bak$', 'node_modules']
let g:NERDTreeWinPos = "right"
let NERDTreeQuitOnOpen=1

" TAGBAR
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_left = 1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_indent = 1
let g:tagbar_expand = 1
let g:tagbar_autopreview = 1

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

" Fzf
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

command! -bang -nargs=* GitAg
  \ call fzf#vim#ag(<q-args>, {'dir': systemlist('git rev-parse --show-toplevel')[0]}, <bang>0)

command! -bang -nargs=* GitAgFiles
  \ call fzf#run(fzf#wrap(
       \ {'source': 'ag -i -g '.shellescape(<q-args>), 
       \  'dir': systemlist('git rev-parse --show-toplevel')[0]})
       \, <bang>0)

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
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" ### My Personal Config
" ######################

set clipboard=unnamedplus

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
    colorscheme solarized
    "set background=dark
    set background=light
    "colorscheme zenburn
    "colorscheme herald
    "colorscheme mustang
    "colorscheme janah
    "set lines=43 columns=140
    set lines=999 columns=999
    set mousehide
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set ghr=0
else
    set background=dark
    colorscheme janah
    "colorscheme solarized
    "set background=light
    "let g:solarized_termcolors=256
endif

set colorcolumn=80 
highlight ColorColumn ctermbg=235 guibg=#2c2d27
"let &colorcolumn=join(range(81,999),",")

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

" close buffer when tab is closed
"set nohidden
set hidden

set wrapmargin=0
set textwidth=0

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

" ### MY KEY MAPPINGS
" ###################

function! s:getVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)

    if len(lines) == 0
        return ""
    endif

    let lines[-1] = lines[-1][:column_end - (&selection == "inclusive" ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]

    return join(lines, "\n")
endfunction

map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>

nnoremap ,c :let @+ = expand("%:p").":".line('.')<cr>
"nnoremap ,h :bprevious<CR>
nnoremap ,d :NERDTreeToggle<CR>
"nnoremap ,e :tabnew<CR>
nnoremap ,n :NERDTreeFind<CR>
"nnoremap ,t :TagbarToggle<CR>
nnoremap ,f :CtrlSF 
nnoremap ,,f :CtrlSFToggle<CR>
vmap     ,f <Plug>CtrlSFVwordExec
"nnoremap <F5> :GundoToggle<CR>
nnoremap ,l :Lines<CR>
nnoremap ,a :GitAg!<CR>
vmap ,a <Esc>:GitAg! <C-R>=<SID>getVisualSelection()<CR><CR>
nnoremap ,b :Buffers<CR>
nmap ; :BLines<CR>
vmap ; <Esc>:BLines <C-R>=<SID>getVisualSelection()<CR><CR>
nmap ,t :GFiles<CR>
vmap ,t <Esc>:GitAgFiles! <C-R>=<SID>getVisualSelection()<CR><CR>
nmap ,r :Tags<CR>
nmap ,k :History<CR>
nmap <SPACE> :noh<CR>
nnoremap ,e :tabnew<CR>

nmap s <Plug>(easymotion-overwin-f)

nnoremap ,ga :Gwrite<CR>
nnoremap ,gs :Gstatus<CR>
nnoremap ,gc :Gcommit<CR>
nnoremap ,gp :Gpush<CR>
nnoremap ,gd :Gdiff<CR>
nnoremap ,gb :Gbrowse<CR>

nnoremap ,w :ImportJSWord<CR>

" ,cd to change to current file dir & print pwd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
