" Requirements
" ============
"
" * pip install rst2ctags
" * apt-get install ack-grep
"

let npm_bin=system('npm bin')
let $PATH=$PATH . ":" . npm_bin
set shell=zsh
let g:python3_host_prog = $HOME . '/.pyenv/versions/3.6.3/bin/python'

"-- Vim-Plug ---------------------------------------------------------------{{{

call plug#begin('~/.vim/bundle')

"### system ###################################################################
Plug 'tpope/vim-dispatch'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'luochen1990/rainbow'
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'editorconfig/editorconfig-vim'

Plug 'pearofducks/ansible-vim'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" code analysis
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'w0rp/ale'
Plug 'davidhalter/jedi-vim'
" completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/emmet-vim'
" format
Plug 'sbdchd/neoformat'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'html'] }
Plug 'junegunn/vim-easy-align'
" git
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
" motion
Plug 'easymotion/vim-easymotion'
" navigation
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'scrooloose/nerdtree'
Plug 'ludovicchabant/vim-gutentags'
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'vim-scripts/taglist.vim'
Plug 'majutsushi/tagbar'
" tests
Plug 'janko-m/vim-test'
" themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'edkolev/tmuxline.vim'
Plug 'mhinz/vim-janah'
" Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'vim-scripts/TagHighlight'

"### languages ################################################################
" go - must be before vim-poliglot
" Plug 'fatih/vim-go', { 'for' : ['go', 'markdown'], 'do': ':GoUpdateBinaries' }
" all
Plug 'sheerun/vim-polyglot'
" css
Plug 'ap/vim-css-color'
Plug 'hail2u/vim-css3-syntax', { 'for' : ['css', 'less', 'scss'] }
" javascript
Plug 'galooshi/vim-import-js', { 'for': ['javascript', 'typescript', 'graphql'] }
Plug 'mtscout6/syntastic-local-eslint.vim', { 'for': ['javascript', 'typescript', 'graphql'] }
Plug 'jparise/vim-graphql', { 'for': ['javascript', 'typescript', 'graphql'] }
" rails
Plug 'tpope/vim-rails', { 'for' : ['ruby'] }
Plug 'tpope/vim-bundler', { 'for' : ['ruby'] }
Plug 'ngmy/vim-rubocop', { 'for' : ['ruby'] }
Plug 'tpope/vim-endwise'
" rust
Plug 'rust-lang/rust.vim', { 'for' : ['rust', 'toml'] }
Plug 'racer-rust/vim-racer', { 'for' : ['rust', 'toml'] }

call plug#end()

"-- Vim-Plug ---------------------------------------------------------------" Fzf }}}

"##############################################################################
"### Bundle Configs ###########################################################
"##############################################################################

" Editor config {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']
" Editor config }}}

" Deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#builtin_objects = 1
let g:deoplete#sources#go#unimported_packages = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
" Deoplete }}}

" LanguageClient {{{
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['solargraph', 'stdio'],
    \ 'go': ['gopls'],
    \ }
" LanguageClient }}}

" status line / airline {{{
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%{gutentags#statusline()}

let g:airline#extensions#ale#enabled = 1
let g:airline_statusline_ontop=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
set laststatus=2 
" status line / airline }}}

" ALE {{{
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 1
let g:ale_list_window_size = 5
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop', 'solargraph'],
\   'python': ['prospector'],
\   'go': ['gopls'],
\}
 let g:ale_fixers = {
 \   'ruby': [ 'rubocop' ],
 \   'javascript': [ 'prettier', 'eslint' ],
 \   'scss': [ 'prettier' ],
 \   'go': [ 'gofmt' ],
 \}
let g:ale_linters_explicit = 1
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
" ALE }}}

" UtilSnips {{{
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.vim/UltiSnips']
" UtilSnips }}}

" Rainbow {{{
let g:rainbow_active = 0      " use :RainbowToggle
" Rainbow }}}

" Goyo / LimeLight {{{
let g:limelight_conceal_ctermfg = 'black'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" Goyo / LimeLight }}}

" vim test {{{
let test#strategy = "dispatch"
" vim test }}}

" Emmet {{{
autocmd FileType html,css,javascript.jsx EmmetInstall
let g:user_emmet_leader_key='<C-X>'
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
" Emmet }}}

" Vim Gutter {{{
set updatetime=100
let g:gitgutter_sign_added = '❖'
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_removed = '✘'
" let g:gitgutter_sign_removed_first_line = '^^'
" let g:gitgutter_sign_modified_removed = 'ww'
" Vim Gutter }}}

" javascript-libraries-syntax {{{
let g:used_javascript_libs = 'jquery,underscore,react,requirejs'
" javascript-libraries-syntax }}}

" vim-jsx {{{
let g:jsx_ext_required = 1
" vim-jsx }}}

" NerdTree {{{
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.pyc$', '\.bak$', 'node_modules']
let g:NERDTreeWinPos = "right"
let NERDTreeQuitOnOpen=1
" NerdTree }}}

" Taglist {{{
let Tlist_Show_One_File = 1
let Tlist_Close_On_Select = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Compact_Format = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Display_Tag_Scope = 0
let Tlist_Display_Prototype = 0
let Tlist_WinWidth = 40
let Tlist_Sort_Type = "order"
let tlist_javascript_settings = 'javascript;x:a-controller;y:a-filter;f:a-factory;z:a-service;d:a-directive;m:a-module;r:a-route;s:a-scope;A:Arrays;C:Classes;E:Exports;F:Functions;G:Generators;I:Imports;M:Methods;O:Objects;P:Properties;T:Tags;V:Variables'
let tlist_ruby_settings = 'ruby;m:modules;c:classes;C:constants;b:attributes;h:associations;n:named_scopes;e:exposures;a:aasm_events;d:describes;F:methods singleton;f:methods;t:tests'
let tlist_markdown_settings = 'markdown;1:h1;2:h2;3:h3;4:h4'
let tlist_rust_settings = 'rust;f:function definitions;T:type definitions;g:enumeration names;s:structure names;m:module names;c:static constants;t:traits;i:trait implementations;d:macro definitions'
" Taglist }}}

" TagBar {{{
let g:tagbar_left = 1
let g:tagbar_autoclose = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_type_ruby = {
            \ 'kinds' : [
                \ 'c:classes',
                \ 'f:methods',
                \ 'm:modules',
                \ 'F:singleton methods',
                \ 'C:constants',
                \ 'h:associations',
                \ 'n:named_scopes',
                \ 'e:exposures',
                \ 'a:aasm_events',
                \ 'd:describes',
                \ 't:tests'
            \ ],
      \ }
" TagBar }}}

" NerdCommenter {{{
let g:NERDSpaceDelims = 1
" NerdCommenter }}}

" Fugitive {{{
autocmd QuickFixCmdPost *grep* cwindow
" Fugitive }}}

" Python.vim {{{
let python_highlight_all = 1 
" Python.vim }}}

" GutenTags {{{
let g:gutentags_cache_dir = '~/.cache/gutentags'
" GutenTags }}}

" Surround - Django {{{
let b:surround_{char2nr("v")} = "{{ \r }}"
let b:surround_{char2nr("{")} = "{{ \r }}"
let b:surround_{char2nr("%")} = "{% \r %}"
let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"
" Surround - Django }}}

" YCM {{{
" Settings from https://code.djangoproject.com/wiki/UsingVimWithDjango
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_auto_trigger = 1
" YCM }}}

" Fzf {{{
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
       \ {'source': 'ag -i -U -g '.shellescape(<q-args>), 
       \  'dir': systemlist('git rev-parse --show-toplevel')[0]})
       \, <bang>0)
" Fzf }}}

" CtrlSF {{{
let g:ctrlsf_default_root='project'
let g:ctrlsf_auto_close = 1
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_mapping = {
    \ "split"   : "i",
    \ "vsplit"  : "s",
    \ "tab"     : "t",
    \ }
let g:ctrlsf_ignore_dir = ["node_modules", "coverage", "dist", "vendor", "target", "build", "vendor", "tags"]
" CtrlSF }}}

" vim-go {{{
let g:go_list_type = "quickfix"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_extra_types = 1
"let g:go_auto_type_info = 1
let g:go_addtags_transform = "camelCase"
let g:go_term_enabled = 1
" let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_def_mapping_enabled = 0
" vim-go }}}

" NeoFormat {{{
"let g:neoformat_enabled_javascript = ['prettier']
"let g:neoformat_enabled_ruby = ['rubocop']
let g:neoformat_enabled_html = []
let g:neoformat_enabled_javascript = []
let g:neoformat_enabled_ruby = []
let g:neoformat_enabled_python = ['black']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_sass = ['prettier']
let g:neoformat_enabled_scss = ['prettier']
let g:neoformat_enabled_less = ['prettier']
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
" NeoFormat }}}

" JEDI  {{{
let g:jedi#goto_command = "<leader>rd"
let g:jedi#goto_assignments_command = "<leader>rg"
let g:jedi#use_splits_not_buffers = "right"
let g:jedi#usages_command = "<leader>ru"
" JEDI  }}}

" ansible-vim  {{{
let g:ansible_name_highlight = 'd'
let g:ansible_extra_keywords_highlight = 1
" ansible-vim  }}}

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

" Foldmethod
set foldmethod=marker
set foldlevel=99
set foldlevel=0

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
set gfn=Operator\ Mono\ Medium\ 11
set nu
set relativenumber

autocmd BufEnter * silent! lcd %:p:h

" disable syntax hl on big files
au BufReadPost * if getfsize(bufname("%")) > 102400 | set syntax= | endif

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

colorscheme janah
"let g:dracula_colorterm = 0
"let g:airline_theme='dracula'
"colorscheme dracula
" set background=light
" colorscheme solarized

if has('gui_running')
    set lines=999 columns=999
    set mousehide
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set ghr=0
else
    "let g:solarized_termtrans=1
endif

set colorcolumn=80 
"highlight ColorColumn ctermbg=235 guibg=#2c2d27
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

" don't close buffer when tab is closed
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

" italics
"hi Comment gui=italic cterm=italic
"hi htmlArg gui=italic cterm=italic
"let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"set termguicolors

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

function! FZFHistory()
  let directory = substitute(system("git rev-parse --show-toplevel"), '\n$', '', '')
  if !v:shell_error
    :call fzf#run(fzf#wrap({'source': 'git --no-pager log --name-only -100 --decorate=short --pretty=format:', 'dir': directory}))
  else
    :History
  endif
endfunction

map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
map <C-0> 10zl
map <C-9> 10zh
nnoremap t :<c-u>rightbelow vertical stjump <c-r><c-w><cr>
nnoremap T <c-w>T

nnoremap ,c :let @+ = expand("%:p").":".line('.')<cr>
nnoremap ,d :NERDTreeToggle<CR>
nnoremap ,n :NERDTreeFind<CR>
nnoremap ,f :CtrlSF 
nnoremap ,,f :CtrlSFToggle<CR>
vmap     ,f <Plug>CtrlSFVwordExec
nnoremap ,a :GitAg!<CR>
vmap ,a <Esc>:GitAg! <C-R>=<SID>getVisualSelection()<CR><CR>
" nnoremap ,b :Buffers<CR>
nnoremap à :Buffers<CR>
nmap ; :BTags<CR>
vmap ; <Esc>:BTags <C-R>=<SID>getVisualSelection()<CR><CR>
" nmap ,t :GFiles<CR>
nmap ù :GFiles<CR>
vmap ,t <Esc>:GitAgFiles! <C-R>=<SID>getVisualSelection()<CR><CR>
nmap ,r :Tags<CR>
vmap ,r <Esc>:Tags <C-R>=<SID>getVisualSelection()<CR><CR>
" nmap ,l :BLines<CR>
" vmap ,l <Esc>:BLines <C-R>=<SID>getVisualSelection()<CR><CR>
nmap ! :BLines<CR>
vmap ! <Esc>:BLines <C-R>=<SID>getVisualSelection()<CR><CR>
nmap ,k :call FZFHistory()<CR>
nmap <SPACE> :noh<CR>
nnoremap ,e :tabnew<CR>
nmap ,<TAB> :TlistToggle<CR>
nmap <TAB> :TagbarToggle<CR>

nmap s <Plug>(easymotion-overwin-f)

nnoremap ,gv :GV!<CR>
nnoremap ,ga :Gwrite<CR>
" nnoremap ,gs :Gstatus<CR>
nnoremap ,gs :GFiles?<CR>
" nnoremap ,gc :Gcommit<CR>
nnoremap ,gc :BCommits<CR>
nnoremap ,gp :Gpush<CR>
nnoremap ,gd :Gdiff<CR>
nnoremap ,gb :Gbrowse<CR>
" nnoremap ,gl :Glog<CR><CR>
nnoremap ,gl :Commits<CR>

nnoremap <silent> K :call LanguageClient_contextMenu()<CR>
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap ,,r :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> gd :ALEGoToDefinitionInVSplit<CR>


" FileType specific
au FileType ruby nmap ,p :RuboCop -a<CR>

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>rd <Plug>(rust-doc)

nnoremap ,w :ImportJSWord<CR>

" ,cd to change to current file dir & print pwd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
