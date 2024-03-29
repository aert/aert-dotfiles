call plug#begin()

"### system ###################################################################
Plug 'tpope/vim-dispatch'
Plug 'junegunn/vim-easy-align'

" distraction free ............................................................
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
let g:limelight_conceal_ctermfg = 'black'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

Plug 'dhruvasagar/vim-zoom'

" Plug 'luochen1990/rainbow'
" let g:rainbow_active = 1      " use :RainbowToggle

" Plug 'vim-scripts/AnsiEsc.vim'
"
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'

" Editor config ...............................................................
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

Plug 'folke/which-key.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'jdhao/better-escape.vim'

" LSP .........................................................................
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Telescope ...................................................................
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'simrat39/symbols-outline.nvim'

" snippets ********************************************************************

" ultisnips ...................................................................
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"
let g:UltiSnipsListSnippets = "" "List possible snippets based on current file

let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.vim/UltiSnips']

Plug 'fhill2/telescope-ultisnips.nvim'

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
\   'sh': [ 'shellcheck' ],
\}
 let g:ale_fixers = {
 \   'ruby': [ 'rubocop' ],
 \   'javascript': [ 'prettier', 'eslint' ],
 \   'scss': [ 'prettier' ],
 \   'go': [ 'gofmt' ],
 \   'sh': [ 'shfmt' ],
 \}
let g:ale_linters_explicit = 1


" completion
" Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
" Plug 'hrsh7th/cmp-path'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" auto-pairs ..................................................................
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsShortcutToggle = ''

" match html tags .............................................................
Plug 'andymass/vim-matchup'

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
Plug 'nvim-tree/nvim-tree.lua'

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
set statusline+=%{zoom#statusline()}
set statusline+=%*
set statusline+=%{nvim_treesitter#statusline()}
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

" Plug 'jnurmine/Zenburn'

" Plug 'EdenEast/nightfox.nvim'
" Plug 'wuelnerdotexe/vim-enfocado'

"### languages ################################################################

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
