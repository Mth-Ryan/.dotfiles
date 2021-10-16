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
Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}
Plug 'akinsho/nvim-bufferline.lua'
Plug 'frazrepo/vim-rainbow'

"Utility
Plug 'windwp/nvim-autopairs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

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
hi Normal      guibg=NONE
hi NonText     guibg=NONE
hi EndOfBuffer guibg=NONE

lua << EOF

-- Colorizer

require('colorizer').setup(
    {'*';},
    {
        RRGGBBAA = true;
        rgb_fn = true;
        hsl_fn = true;
    }
)

-- TreeSitter

require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Indent Guides 

require("indent_blankline").setup {
    char = "┊",
    buftype_exclude = {"terminal"},
    filetype_exclude = {'scheme', 'lisp'},
}

-- Galaxy Line
require("status-line")

-- Buffer Line
require("buffer-line")

EOF

au FileType scheme,lisp call rainbow#load()
let g:rainbow_guifgs = ['#D4D2CF',
                       \'#BF5151',
                       \'#fd9149',
                       \'#f0c674',
                       \'#bfd066',
                       \'#9BC5AF']

" }}}

" Utils {{{

lua << EOF

-- Autopairs
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

_G.MUtils= {}

vim.g.completion_confirm_key = ""

MUtils.completion_confirm=function()
    if vim.fn.pumvisible() ~= 0  then
        if vim.fn.complete_info()["selected"] ~= -1 then
            require'completion'.confirmCompletion()
            return npairs.esc("<c-y>")
        else
            vim.api.nvim_select_popupmenu_item(0 , false , false ,{})
            require'completion'.confirmCompletion()
            return npairs.esc("<c-n><c-y>")
        end
    else
        return npairs.autopairs_cr()
    end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
npairs.setup{}

-- Telescope
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        prompt_prefix = 'λ ',
        selection_caret = '❯ ',
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        colors_devicons = true,

        file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        mappings = {
            i = {
                ['<C-x>'] = false,
                ['<C-q>'] = actions.send_to_qflist,
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
}

EOF

" Telescope Keybindings
nnoremap <C-f> :Telescope find_files theme=get_dropdown<CR>

" }}}

" Languages {{{


" VimScript
au FileType vim setlocal foldmethod=marker

" Go
au FileType go nnoremap <F5> :GoBuild<CR>
au FileType go nnoremap <F6> :GoRun<CR>

" Rust
au FileType rust nnoremap <F5> :Cargo build<CR>
au FileType rust nnoremap <F6> :Cargo run<CR>

" F#
let g:fsharp#fsi_keymap = "custom"
let g:fsharp#fsi_keymap_send   = "<C-e>"
let g:fsharp#fsi_keymap_toggle = "<C-@>"
au FileType fsharp nnoremap <F6> :FsiShow<CR>

" }}}

" LSP {{{

lua << EOF

local lspconfig = require('lspconfig')

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
