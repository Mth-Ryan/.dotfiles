"  _   _                 _           
" | \ | | ___  _____   _(_)_ __ ___  
" |  \| |/ _ \/ _ \ \ / / | '_ ` _ \ 
" | |\  |  __/ (_) \ V /| | | | | | |
" |_| \_|\___|\___/ \_/ |_|_| |_| |_|

" File:    init.vim
" Author:  Mateus Ryan <mthryan@protonmail.com>
" Licence: MIT
" Require: Neovim >= 0.5

syntax enable
set nu!
set termguicolors
set tabstop=4
set shiftwidth=4
set expandtab
set encoding=utf-8
set mouse=a
let g:neovide_cursor_antialiasing=v:true
let g:neovide_cursor_vfx_mode = "sonicboom"
set guifont=FiraCode\ Nerd\ Font\ Mono:h12

lua << EOF

local plugins   = require('plugins')
local visual    = require('visual')
local utilities = require('utilities')
local lsp       = require('lsp')

-- Plugins
plugins.get_packer()
plugins.setup()

-- Visual
visual.colorscheme('yat')
visual.enable_colorizer()
visual.enable_treesitter()
visual.enable_indent_blankline()
visual.enable_bufferline()
visual.enable_galaxyline()

-- Utility
utilities.enable_autopairs()
utilities.enable_telescope()
utilities.enable_fterm()
utilities.enable_lua_tree()
utilities.enable_wilder()

-- Lsp
lsp.utils_setup()
lsp.enable_omnisharp()
lsp.enable_pyright()
lsp.enable_gopls()
lsp.enable_rust_analyzer()
lsp.enable_tsserver()
-- lsp.enable_ccls()
lsp.enable_clangd()
lsp.enable_sourcekit()
lsp.enable_hls()

-- Completition
utilities.enable_coq()

EOF

filetype plugin indent on

"Temp
hi NvimTreeFolderName       guifg=#a1a09d
hi NvimTreeEmptyFolderName  guifg=#a1a09d
hi NvimTreeOpenedFolderName guifg=#a6adef
hi VertSplit                guifg=#525863

