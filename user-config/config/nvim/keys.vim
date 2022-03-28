" ### MY KEY MAPPINGS
" ###################

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

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
nnoremap <leader>t <cmd>Telescope lsp_document_symbols<CR>
nnoremap <leader>T <cmd>Telescope lsp_workspace_symbols<CR>
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
nnoremap <leader>gg :Neogit<CR>
" nnoremap <leader>gs <cmd>Telescope git_status<CR>
" nnoremap <leader>gc :BCommits<CR>
nnoremap <leader>gc <cmd>Telescope git_bcommits<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gb :GBrowse<CR>
nnoremap <leader>gm :Git blame<CR>
nnoremap <leader>gB <cmd>Telescope git_branches<CR>
" nnoremap <leader>gl :Commits<CR>
nnoremap <leader>gl <cmd>Telescope git_commits<CR>

" Use <c-space> to trigger completion.
nmap <silent> gd <cmd>Telescope lsp_definitions<CR>
nmap <silent> gy <cmd>Telescope lsp_type_definitions<CR>
nmap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nmap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nmap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <cmd>lua vim.diagnostic.goto_prev()<CR>
nmap <silent> ]g <cmd>lua vim.diagnostic.goto_next()<CR>

nnoremap <leader><TAB> :SymbolsOutline<CR>
vmap <silent>Z <cmd>Telescope lsp_range_code_actions<CR>
nmap <silent>Z <cmd>lua vim.lsp.buf.code_action()<CR>

nmap <leader>mt <cmd>Telescope treesitter<CR>
nmap <leader>ss <cmd>Telescope grep_string<CR>

nmap <leader>ll :CocFzfList<CR>
nmap <leader>ld <cmd>Telescope diagnostics<CR>
nmap <leader>lt <cmd>Telescope lsp_type_definitions<CR>
nmap <leader>lr <cmd>Telescope lsp_references<CR>
nmap <leader>li <cmd>Telescope lsp_implementations<CR>
nmap <leader>la <cmd>lua vim.lsp.buf.code_action()<CR>
nmap <leader>lr <cmd>lua vim.lsp.buf.rename()<CR>
nmap <leader>lf <Plug>(coc-fix-current)

" nmap <leader>p :call CocAction('format')<CR>
nmap <leader>p :Neoformat<CR>

nmap <leader>q :bunload<CR>

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize +25"<CR>
nnoremap <silent> <Leader>< :exe "vertical resize -25"<CR>

nnoremap <leader>mh :SidewaysLeft<cr>
nnoremap <leader>ml :SidewaysRight<cr>

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

inoremap <silent> <C-j> <C-O>:Telescope ultisnips<CR>

" ,cd to change to current file dir & print pwd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

