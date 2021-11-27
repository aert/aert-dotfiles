call plug#begin('~/.vim/bundle')

"### system ###################################################################
Plug 'tpope/vim-dispatch'

" distraction free ............................................................
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
let g:limelight_conceal_ctermfg = 'black'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Plug 'luochen1990/rainbow'
" let g:rainbow_active = 1      " use :RainbowToggle

" Plug 'vim-scripts/AnsiEsc.vim'
"
Plug 'tpope/vim-surround'

Plug 'tpope/vim-abolish'

" Editor config ...............................................................
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

Plug 'folke/which-key.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'jdhao/better-escape.vim'

" Telescope ...................................................................
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'fannheyward/telescope-coc.nvim'

" snippets ********************************************************************

" ultisnips ...................................................................
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.vim/UltiSnips']

" vim-snippets ................................................................
Plug 'honza/vim-snippets'

" code analysis ***************************************************************

" lsc .........................................................................
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
let g:lsc_auto_map = v:true

" ale .........................................................................
Plug 'dense-analysis/ale'
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


" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

" auto-pairs ..................................................................
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsShortcutToggle = ''

" nerdcommenter ...............................................................
Plug 'preservim/nerdcommenter'
let g:NERDSpaceDelims = 1

" emmet .......................................................................
Plug 'mattn/emmet-vim'
autocmd FileType html,css,javascript.jsx EmmetInstall
let g:user_emmet_leader_key='<C-X>'
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

" selection ...................................................................

Plug 'terryma/vim-expand-region'

" format **********************************************************************

" neoformat ...................................................................
Plug 'sbdchd/neoformat'
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_ruby = ['rubocop']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_python = ['black']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_sass = ['prettier']
let g:neoformat_enabled_scss = ['prettier']
let g:neoformat_enabled_less = ['prettier']

" prettier ....................................................................
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'html'] }

" git *************************************************************************

" fugitive ....................................................................
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-rhubarb'
autocmd QuickFixCmdPost *grep* cwindow

Plug 'TimUntersberger/neogit'

" gitsigns ....................................................................
Plug 'lewis6991/gitsigns.nvim'

" easymotion ..................................................................
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0

" navigation ******************************************************************

" fzf .........................................................................
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_preview_window = ''
let g:fzf_tags_command = 'ctags -R'

command! -bang -nargs=* GitAg
  \ call fzf#vim#ag(<q-args>, {'dir': systemlist('git rev-parse --show-toplevel')[0]}, <bang>0)

command! -bang -nargs=* GitAgFiles
  \ call fzf#run(fzf#wrap(
       \ {'source': 'ag -i -U -g '.shellescape(<q-args>),
       \  'dir': systemlist('git rev-parse --show-toplevel')[0]})
       \, <bang>0)

" ctrlsf ......................................................................
Plug 'dyng/ctrlsf.vim'
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

Plug 'kyazdani42/nvim-web-devicons' " for file icons

" nvim-tree ...................................................................
Plug 'kyazdani42/nvim-tree.lua'
let g:nvim_tree_quit_on_open = 1
" let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '.idea' ]
let g:nvim_tree_gitignore = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1, 'Dockerfile': 1, 'Gemfile': 1, 'package.json': 1 }

" Plug 'ludovicchabant/vim-gutentags'
" let g:gutentags_cache_dir = '~/.cache/gutentags'

Plug 'arithran/vim-delete-hidden-buffers'

" floaterm ....................................................................
Plug 'voldikss/vim-floaterm'
let g:floaterm_wintype = 'vsplit'

Plug 'AndrewRadev/sideways.vim'

" tests
" Plug 'janko-m/vim-test'
" let test#strategy = "floaterm"

" airline .....................................................................
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%{nvim_treesitter#statusline(80)}
set laststatus=2
let g:airline#extensions#ale#enabled = 1
let g:airline_statusline_ontop=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1

" colorscheme .................................................................
" Plug 'Pocco81/Catppuccino.nvim'
" Plug 'mhinz/vim-janah'
" colorscheme janah
"
" Plug 'yashguptaz/calvera-dark.nvim'
" let g:calvera_italic_comments = 1
" let g:calvera_italic_keywords = 1
" let g:calvera_italic_functions = 1

" Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Plug 'NLKNguyen/papercolor-theme'

Plug 'jnurmine/Zenburn'

Plug 'EdenEast/nightfox.nvim'

"### languages ################################################################

" go - must be before vim-poliglot ............................................
" Plug 'fatih/vim-go', { 'for' : ['go', 'markdown'], 'do': ':GoUpdateBinaries' }
" let g:go_list_type = "quickfix"
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_types = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_format_strings = 1
" let g:go_highlight_extra_types = 1
" "let g:go_auto_type_info = 1
" let g:go_addtags_transform = "camelCase"
" let g:go_term_enabled = 1
" " let g:go_auto_sameids = 1
" let g:go_fmt_command = "goimports"
" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'
" let g:go_def_mapping_enabled = 0

" dart ........................................................................
Plug 'dart-lang/dart-vim-plugin', { 'for' : ['dart'] }
let g:dart_format_on_save = 1
let g:lsc_enable_diagnostics = v:false

" css
Plug 'ap/vim-css-color', { 'for' : ['css', 'less', 'scss'] }
Plug 'hail2u/vim-css3-syntax', { 'for' : ['css', 'less', 'scss'] }
" all
Plug 'sheerun/vim-polyglot'
" javascript
Plug 'mtscout6/syntastic-local-eslint.vim', { 'for': ['javascript', 'typescript', 'graphql'] }
" rails
Plug 'tpope/vim-rails', { 'for' : ['ruby'] }
Plug 'tpope/vim-bundler', { 'for' : ['ruby'] }

" dadbod ......................................................................
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'
let g:db_ui_table_helpers = {
\   'postgresql': {
\     'List': 'select * from "{table}" order by id desc LIMIT 200'
\   }
\ }

" others ......................................................................
Plug 'ledger/vim-ledger', { 'for' : ['ledger'] }

call plug#end()
