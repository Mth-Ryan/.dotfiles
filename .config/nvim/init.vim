"  _   _                 _           
" | \ | | ___  _____   _(_)_ __ ___  
" |  \| |/ _ \/ _ \ \ / / | '_ ` _ \ 
" | |\  |  __/ (_) \ V /| | | | | | |
" |_| \_|\___|\___/ \_/ |_|_| |_| |_|

" File:    init.vim
" Author:  Mateus Ryan <mthryan@protonmail.com>
" Licence: MIT
" Require: Neovim >= 0.5

" Initial Setup {{{

syntax enable
set nu!
set termguicolors
set tabstop=4
set shiftwidth=4
set expandtab
set encoding=utf-8

" }}}

" Plugins {{{

let s:pluginsPath = '~/.config/nvim/plugged'

call plug#begin(s:pluginsPath)

"Visual
Plug 'Mth-Ryan/yat'  "colors
Plug 'norcalli/nvim-colorizer.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'yamatsum/nvim-cursorline'
Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}

"Utility
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'

"Languages
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'ionide/Ionide-vim', {
      \ 'do':  'make fsautocomplete',
      \}

call plug#end()

filetype plugin indent on

" }}}

" Visual {{{

" ColorScheme
colorscheme yat

lua << EOF

-- Colorizer

require 'colorizer'.setup(
    {'*';},
    {
        RRGGBBAA = true;
        rgb_fn = true;
        hsl_fn = true;
    }
)

-- TreeSitter

require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    ignore_install = { 
        "rust",
        "go",
        "html"
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Indent Guides 

require("indent_blankline").setup {
    char = "┊",
    buftype_exclude = {"terminal"}
}

-- Galaxy Line
require("status-line")

EOF

" Color Ajust --TEMP--
" TODO: Add NvimTree colors on Yat

hi! NvimTreeRootFolder       guifg=#81A1C1
hi! NvimTreeSymlink          guifg=#4d5566
hi! NvimTreeFolderName       guifg=#4d5566
hi! NvimTreeFolderIcon       guifg=#4d5566
hi! NvimTreeEmptyFolderName  guifg=#4d5566
hi! NvimTreeOpenedFolderName guifg=#4d5566
hi! NvimTreeOpenedFile       guifg=#4d5566
hi! NvimTreeSpecialFile      guifg=#4d5566
hi! NvimTreeImageFile        guifg=#4d5566
hi! NvimTreeMarkdownFile     guifg=#4d5566
hi! NvimTreeIndentMarker     guifg=#4d5566
hi! NvimTreeGitDirty         guifg=#4d5566
hi! NvimTreeGitStaged        guifg=#4d5566
hi! NvimTreeGitMerge         guifg=#4d5566
hi! NvimTreeGitRenamed       guifg=#4d5566
hi! NvimTreeGitNew           guifg=#4d5566
hi! NvimTreeGitDeleted       guifg=#4d5566
hi! NvimTreeExecFile         guifg=#4d5566

" }}}

" Languages {{{


" VimScript
au FileType vim setlocal foldmethod=marker

" Go
au FileType go nnoremap <F5> :GoBuild<CR>
au FileType go nnoremap <F6> :GoRun<CR>

let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_build_greenraints      = 1
let g:go_highlight_chan_whitespace_error  = 0
let g:go_highlight_extra_types            = 1
let g:go_highlight_fields                 = 1
let g:go_highlight_format_strings         = 1
let g:go_highlight_function_calls         = 1
let g:go_highlight_function_parameters    = 1
let g:go_highlight_functions              = 1
let g:go_highlight_generate_tags          = 1
let g:go_highlight_operators              = 1
let g:go_highlight_space_tab_error        = 0
let g:go_highlight_string_spellcheck      = 1
let g:go_highlight_types                  = 1
let g:go_highlight_variable_assignments   = 1
let g:go_highlight_variable_declarations  = 1

" Rust
au FileType rust nnoremap <F5> :Cargo build<CR>
au FileType rust nnoremap <F6> :Cargo run<CR>
au FileType rust :IndentLinesEnable

" F#
let g:fsharp#fsi_keymap = "custom"
let g:fsharp#fsi_keymap_send   = "<C-e>"
let g:fsharp#fsi_keymap_toggle = "<C-@>"
au FileType fsharp nnoremap <F6> :FsiShow<CR>

" }}}

" LSP Config {{{

lua << EOF

local lspconfig = require'lspconfig'

local home = os.getenv("HOME")
local pid = vim.fn.getpid()

local omnisharp_bin = home .. "/.local/share/omnisharp/run"

-- C#
lspconfig.omnisharp.setup {
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
}

-- F#
-- Ionide-vim auto setup

-- Python
lspconfig.pyright.setup{}

-- Go
lspconfig.gopls.setup{}

-- Rust
lspconfig.rust_analyzer.setup {
    cmd = { "rustup", "run", "nightly", "rust-analyzer" }
}

-- C/C++
lspconfig.ccls.setup {
    init_options = {
        compilationDatabaseDirectory = "/tmp";
        index = { threads = 0; };
        clang = {
            excludeArgs = { "-frounding-math"} ;
        };
    }
}

-- Nvim-lsputils

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

EOF

autocmd BufEnter * lua require'completion'.on_attach()

imap <silent> <C-Space> <Plug>(completion_trigger)

set completeopt=menuone,noinsert,noselect

set shortmess+=c

let g:completion_enable_snippet = 'UltiSnips'
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" }}}

" NvimTree {{{

nnoremap <C-n> :NvimTreeToggle<CR>

let g:nvim_tree_side = 'left'
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_gitignore = 1

let g:nvim_tree_width = 25

let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 0,
    \ }

let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "",
    \   'staged': "",
    \   'unmerged': "",
    \   'renamed': "",
    \   'untracked': "",
    \   'deleted': "",
    \   'ignored': ""
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

" }}}
