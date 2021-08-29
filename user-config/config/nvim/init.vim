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

"-- Vim-Plug ---------------------------------------------------------------{{{

call plug#begin('~/.vim/bundle')

"### system ###################################################################
Plug 'tpope/vim-dispatch'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
" Plug 'yuttie/comfortable-motion.vim'
" Plug 'luochen1990/rainbow'
" Plug 'vim-scripts/AnsiEsc.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'editorconfig/editorconfig-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'folke/which-key.nvim'

Plug 'jdhao/better-escape.vim'

" Telescope {{{
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'fannheyward/telescope-coc.nvim'
" }}}

" Plug 'pearofducks/ansible-vim'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" code analysis
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
Plug 'dense-analysis/ale'
" Plug 'davidhalter/jedi-vim', { 'for' : ['python'] }
" completion
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'mattn/emmet-vim'
" format
Plug 'sbdchd/neoformat'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'html'] }
" git
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
" motion
Plug 'easymotion/vim-easymotion'
" navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Plug 'ludovicchabant/vim-gutentags'
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'voldikss/vim-floaterm'
" tests
" Plug 'janko-m/vim-test'
" themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'Pocco81/Catppuccino.nvim'
" Plug 'mhinz/vim-janah'
" Plug 'sainnhe/everforest'

"### languages ################################################################
" go - must be before vim-poliglot
" Plug 'fatih/vim-go', { 'for' : ['go', 'markdown'], 'do': ':GoUpdateBinaries' }
" dart
Plug 'dart-lang/dart-vim-plugin', { 'for' : ['dart'] }
" css
Plug 'ap/vim-css-color', { 'for' : ['css', 'less', 'scss'] }
Plug 'hail2u/vim-css3-syntax', { 'for' : ['css', 'less', 'scss'] }
" all
Plug 'sheerun/vim-polyglot'
" javascript
" Plug 'galooshi/vim-import-js', { 'for': ['javascript', 'typescript', 'graphql'] }
Plug 'mtscout6/syntastic-local-eslint.vim', { 'for': ['javascript', 'typescript', 'graphql'] }
" Plug 'jparise/vim-graphql', { 'for': ['javascript', 'typescript', 'graphql'] }
" rails
Plug 'tpope/vim-rails', { 'for' : ['ruby'] }
Plug 'tpope/vim-bundler', { 'for' : ['ruby'] }
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'tpope/vim-endwise'
" others
Plug 'ledger/vim-ledger', { 'for' : ['ledger'] }

call plug#end()

"-- Vim-Plug ---------------------------------------------------------------" Fzf }}}

"##############################################################################
"### Bundle Configs ###########################################################
"##############################################################################

" Editor config {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']
" Editor config }}}

" LSC {{{
let g:lsc_auto_map = v:true
" LSC }}}

" Deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#builtin_objects = 1
let g:deoplete#sources#go#unimported_packages = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
" Deoplete }}}

" AutoPairs {{{
let g:AutoPairsShortcutToggle = ''
" AutoPairs }}}

" LanguageClient {{{
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['pyls'],
    \ 'ruby': ['solargraph', 'stdio'],
    \ 'go': ['gopls'],
    \ }
" LanguageClient }}}

" status line / airline {{{
set statusline+=%#warningmsg#
set statusline+=%*
" set statusline+=%{gutentags#statusline()}

let g:airline#extensions#ale#enabled = 1
let g:airline_statusline_ontop=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
set laststatus=2
" status line / airline }}}

" ALE {{{
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_open_list = 0
let g:ale_list_window_size = 3
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
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
let g:rainbow_active = 1      " use :RainbowToggle
" Rainbow }}}

" Goyo / LimeLight {{{
let g:limelight_conceal_ctermfg = 'black'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" Goyo / LimeLight }}}

" vim test {{{
let test#strategy = "floaterm"
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
let g:gitgutter_sign_added = '║'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '─'
" let g:gitgutter_sign_removed_first_line = '^^'
" let g:gitgutter_sign_modified_removed = 'ww'
" Vim Gutter }}}

" javascript-libraries-syntax {{{
let g:used_javascript_libs = 'jquery,underscore,react,requirejs'
" javascript-libraries-syntax }}}

" vim-jsx {{{
let g:jsx_ext_required = 1
" vim-jsx }}}

" NvimTree {{{
let g:nvim_tree_side = 'right'
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '.idea' ]
let g:nvim_tree_hide_dotfiles = 1
let g:nvim_tree_gitignore = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_width = 50
let g:nvim_tree_follow = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1, 'Dockerfile': 1, 'Gemfile': 1, 'package.json': 1 }
" NvimTree }}}

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
let g:fzf_preview_window = ''
let g:fzf_tags_command = 'ctags -R'

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
let g:ctrlsf_auto_close = {
    \ "normal" : 1,
    \ "compact": 1
    \}
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
let g:ctrlsf_mapping = {
    \ "split"   : "i",
    \ "vsplit"  : "s",
    \ "tab"     : "t",
    \ }
let g:ctrlsf_ignore_dir = ["node_modules", "coverage", "dist", "vendor", "target", "build", "tags", "bower_components"]
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
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_ruby = ['rubocop']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_python = ['black']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_sass = ['prettier']
let g:neoformat_enabled_scss = ['prettier']
let g:neoformat_enabled_less = ['prettier']
" augroup fmt
  " autocmd!
  " autocmd BufWritePost * undojoin | Neoformat
" augroup END
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

" vim-floaterm {{{
let g:floaterm_wintype = 'vsplit'
" let g:floaterm_width = 0.9
" let g:floaterm_winblend = 20
" let g:floaterm_position = 'bottomright'
" let g:floaterm_height = 1
" let g:floaterm_height = 0.95
" vim-floaterm }}}

" Dart {{{
let g:dart_format_on_save = 1
let g:lsc_enable_diagnostics = v:false
" }}}

" DBUI {{{
let g:db_ui_table_helpers = {
\   'postgresql': {
\     'List': 'select * from "{table}" order by id desc LIMIT 200'
\   }
\ }
" }}}

" TreeSitter {{{

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99

" }}}

" which-key {{{

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" }}}

" EasyMotion {{{
let g:EasyMotion_do_mapping = 0
" }}}

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
" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

syntax enable
"set gfn=Ubuntu\ Mono\ 13
"set gfn=Consolas\ 11
set gfn=Operator\ Mono\ Medium\ 11
set nu
" set nonumber
" set relativenumber

autocmd BufEnter * silent! lcd %:p:h

" disable syntax hl on big files
au BufReadPost * if getfsize(bufname("%")) > 102400 | set syntax= | endif

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

if (has("termguicolors"))
  set termguicolors
endif

" set background=light
" let g:airline_theme = 'solarized_flood'

colorscheme catppuccino
" -- janah
" colorscheme janah
" let g:airline_theme = 'minimalist'
" -- everforest
" let g:everforest_transparent_background = 1
" let g:everforest_enable_italic = 1
" colorscheme everforest
" -- palenight
" let g:airline_theme = 'palenight'
" let g:palenight_terminal_italics = 1
" colorscheme palenight
" -- gruvbox
" let g:gruvbox_italic=1
" let g:gruvbox_transparent_bg=1
" let g:gruvbox_contrast_light='soft'
" let g:gruvbox_contrast_dark='soft'
" colorscheme gruvbox
" autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE
" -- edge
" set background=light
" let g:airline_theme = 'edge'
" let g:edge_enable_italic = 1
" colorscheme edge

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

set nocursorline
set colorcolumn=80
" highlight ColorColumn ctermbg=235 guibg=#2c2d27
" highlight StatusLine ctermbg=235 guibg=#2c2d27
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
" nnoremap <SPACE> <Nop>
" let mapleader = "\<Space>"
let mapleader = "\,"

" italics
"hi Comment gui=italic cterm=italic
"hi htmlArg gui=italic cterm=italic
"let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

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
    :call fzf#run(fzf#wrap({'source': 'git --no-pager log --name-only -10 --decorate=short --pretty=format: | awk "!x[\$0]++" | awk "NF"', 'dir': directory}))
  else
    :History
  endif
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

map <C-n> :ALENextWrap<CR>
map <C-p> :ALEPreviousWrap<CR>
nnoremap t :<c-u>rightbelow vertical stjump <c-r><c-w><cr>
nnoremap T <c-w>T

nnoremap <leader>yl :let @+ = expand("%:p").":".line('.')<cr>

nnoremap <leader>d :NvimTreeToggle<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

nnoremap <leader>f :CtrlSF 
nnoremap <leader>F :CtrlSFToggle<CR>
vmap <leader>f <Plug>CtrlSFVwordExec
nnoremap <leader>a :GitAg!<CR>
vmap <leader>a <Esc>:GitAg! <C-R>=<SID>getVisualSelection()<CR><CR>
nnoremap <leader><SPACE> :Buffers<CR>
" nnoremap <leader><SPACE> <cmd>Telescope buffers<CR>
nmap <leader><Esc> :noh<CR>
" nnoremap <leader>t :CocFzfList outline<CR>
" nnoremap <leader>T :CocList symbols<CR>
nnoremap <leader>t <cmd>Telescope coc document_symbols<CR>
nnoremap <leader>T <cmd>Telescope coc workspace_symbols<CR>
" nmap ; :call LanguageClient#textDocument_documentSymbol()<CR>
vmap <leader>t <Esc>:CocFzfList outline <C-R>=<SID>getVisualSelection()<CR><CR>
vmap <leader>T <Esc>:CocFzfList symbols <C-R>=<SID>getVisualSelection()<CR><CR>
nmap ; :GFiles<CR>
nmap <leader>sl :BLines<CR>
vmap <leader>sl <Esc>:BLines <C-R>=<SID>getVisualSelection()<CR><CR>
nmap <leader>k :call FZFHistory()<CR>
nnoremap <leader>e :tabnew<CR>
" nmap <leader><TAB> :TlistToggle<CR>
" nmap <TAB> :TagbarToggle<CR>

nmap s <Plug>(easymotion-overwin-f)

nnoremap <leader>gS :Gwrite<CR>
nnoremap <leader>gs :GFiles?<CR>
" nnoremap <leader>gs <cmd>Telescope git_status<CR>
" nnoremap <leader>gc :BCommits<CR>
nnoremap <leader>gc <cmd>Telescope git_bcommits<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gb :Gbrowse<CR>
nnoremap <leader>gB <cmd>Telescope git_branches<CR>
" nnoremap <leader>gl :Commits<CR>
nnoremap <leader>gl <cmd>Telescope git_commits<CR>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh() 
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <leader>rn <Plug>(coc-rename)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <leader><TAB> :CocFzfList diagnostics<CR>
" nnoremap <leader>A :CocFzfList actions<CR>
" vnoremap <leader>A :CocFzfList actions<CR>
" vmap <leader>A <Plug>(coc-codeaction-selected)
" nmap <leader>A <Plug>(coc-codeaction)
vmap <silent>Z <Plug>(coc-codeaction-selected)
nmap <silent>Z <Plug>(coc-codeaction)

nmap <leader>mt <cmd>Telescope treesitter<CR>
nmap <leader>ss <cmd>Telescope grep_string<CR>

nmap <leader>ll :CocFzfList<CR>
nmap <leader>ld <cmd>Telescope coc diagnostics<CR>
nmap <leader>lt <cmd>Telescope coc type_definitions<CR>
nmap <leader>lr <cmd>Telescope coc references<CR>
nmap <leader>li <cmd>Telescope coc implementations<CR>
nmap <leader>la <cmd>Telescope coc line_code_actions<CR>
nnoremap <leader>lk :call <SID>show_documentation()<CR>
nmap <leader>lr <Plug>(coc-rename)
nmap <leader>lf <Plug>(coc-fix-current)

nmap <leader>p :call CocAction('format')<CR>

" nmap <leader>p :Neoformat<CR>
nmap <leader>q :q<CR>

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize +25"<CR>
nnoremap <silent> <Leader>< :exe "vertical resize -25"<CR>

" FileType specific
" au FileType ruby nmap <leader>p :RuboCop -a<CR>
au FileType ruby nmap <leader>p :ALEFix<CR>
au FileType dart nmap <leader>p :DartFmt<CR>

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>rd <Plug>(rust-doc)

" nnoremap <leader>w :ImportJSWord<CR>
tnoremap <silent> <C-i><SPACE> <C-\><C-n>
tnoremap <silent> <C-h> <C-\><C-n><C-w>h
vnoremap <silent> <C-i>s :FloatermSend<CR>
nnoremap <silent> <C-i>t :FloatermToggle<CR>
nnoremap <silent> <C-i>c :FloatermNew<CR>
tnoremap <silent> <C-i>t <C-\><C-n>:FloatermToggle<CR>
nnoremap <silent> <C-i>n :FloatermNext<CR>
tnoremap <silent> <C-i>n <C-\><C-n>:FloatermNext<CR>
nnoremap <silent> <C-i>p :FloatermPrev<CR>
tnoremap <silent> <C-i>p <C-\><C-n>:FloatermPrev<CR>
tnoremap <silent> <C-i>k <C-\><C-n>:FloatermKill<CR>

" ,cd to change to current file dir & print pwd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
