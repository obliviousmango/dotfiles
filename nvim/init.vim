" ===========================================================================
"   Plug settings
" ===========================================================================

call plug#begin('~/.vim/plugged')

Plug 'rakr/vim-one'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'nvim-lua/completion-nvim'
Plug 'liuchengxu/vim-which-key'       
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" LSP
"Plug 'neovim/nvim-lspconfig'             " out of the box LSP configs for common langs
"Plug 'glepnir/lspsaga.nvim'              " code action plugin
"Plug 'nvim-lua/lsp-status.nvim'          " provides statusline information for LSP
"Plug 'hrsh7th/nvim-compe'                " completion engine
"Plug 'onsails/lspkind-nvim'              " add vscode-style icons to completion menu
"Plug 'nathunsmitty/nvim-ale-diagnostic'  " route lsp diagnostics to ALE


call plug#end()

let g:Hexokinase_highlighters = [ 'virtual' ]
"lua require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}


" ===========================================================================
"   LSP settings
" ===========================================================================

"
"set completeopt=menu,menuone,noselect
"
"call luaeval('require("lspservers")')
"
"" nnoremap <silent> gh :Lspsaga lsp_finder<CR>
"" nnoremap <silent>K :Lspsaga hover_doc<CR>
"
"nnoremap <silent><space>la :Lspsaga code_action<CR>
"vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
"
"nnoremap <silent> <space>l0  <cmd>lua vim.lsp.buf.document_symbol()<CR>
"nnoremap <silent> <space>ld  <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> <space>li  :LspInfo<CR>
"nnoremap <silent> <space>lh  <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> <space>lD  <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <silent> <space>ln  <cmd>lua vim.lsp.buf.rename()<CR>
"nnoremap <silent> <space>lr  <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap <silent> <space>lt  <cmd>lua vim.lsp.buf.type_definition()<CR>
"nnoremap <silent> <space>lw  <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" ===========================================================================
"   GUI settings
" ===========================================================================

"if (empty($TMUX))
"  if (has("nvim"))
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"  endif
"  if (has("termguicolors"))
"    set termguicolors
"  endif
"endif

set termguicolors
set background=dark " for the dark version
" set background=light " for the light version
colorscheme one


" ===========================================================================
"   Editor settings
" ===========================================================================

" General
set lazyredraw		" don't update the display while executing macros<Paste>
set synmaxcol=500
set laststatus=0	" always have a statusline
set relativenumber    " Relative line numbersset 
set number		" Show line numbers
set linebreak		" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=80	" Line wrap (number of cols)
set showmatch		" Highlight matching brace
set spell		" Enable spell-checking
set belloff=all		" no bell (no beeping)
:set clipboard=unnamedplus
 
set hlsearch		" Highlight all search results
set smartcase		" Enable smart-case search set ignorecase		" Always case-insensitive
set incsearch		" Searches for strings incrementally
 
set autoindent		" Auto-indent new lines
set shiftwidth=4	" Number of auto-indent spaces
set smartindent		" Enable smart-indent
set smarttab		" Enable smart-tabs
set softtabstop=2	" Number of spaces per Tab
 
set ruler		" Show row and column ruler information
 
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
 
set mouse=a 

set wrap		" Soft wrap 
set showbreak=««	" Show indicator

" Colors & Syntax Highlighting 
"silent! colorscheme delek

" Enable syntax highlighting by default
syntax on

" ===========================================================================
"  Keys 
" ===========================================================================

" Map leader to space

noremap <C-n> :noh<cr>

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

