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
set mouse=a

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

"Utility
Plug 'windwp/nvim-autopairs'
Plug 'neovim/nvim-lspconfig'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'numtostr/FTerm.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ms-jpq/coq_nvim', { 'branch': 'coq', 'do': ':COQdeps' }

"Languages
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'ionide/Ionide-vim', {
    \ 'do':  'make fsautocomplete',
\}

call plug#end()

filetype plugin indent on

" }}}

" Visual {{{

" ColorScheme
colorscheme yat

" Ui
let g:neovide_cursor_antialiasing=v:true
let g:neovide_cursor_vfx_mode = "sonicboom"
set guifont=Fira\ Code:h12

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
    char = "┆",
    buftype_exclude = {"terminal"},
    filetype_exclude = {'scheme', 'lisp'},
}

-- Galaxy Line
require("status-line")

-- Buffer Line
require("buffer-line")

EOF

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

-- Fterm
require('FTerm').setup({
    border = 'rounded',
    dimensions  = {
        height = 0.7,
        width = 0.7,
    },
})

local ft_opts = { noremap = true, silent = true }

remap('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>', ft_opts)
remap('t', '<Esc>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', ft_opts)

-- Nvim-Lua tree
require('nvim-tree').setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}

EOF

" Telescope Keybindings
nnoremap <C-f> :Telescope find_files theme=get_dropdown<CR>

" Tree Keybindings
nnoremap <C-n>     :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

"Temp
hi NvimTreeFolderName       guifg=#a1a09d
hi NvimTreeEmptyFolderName  guifg=#a1a09d
hi NvimTreeOpenedFolderName guifg=#a6adef
hi VertSplit guifg=#525863

" Wilder
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
\})

call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      \ 'highlights': {
      \   'border': 'Normal',
      \ },
      \ 'border': 'rounded',
\})))

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

-- C#
lspconfig.omnisharp.setup {
    cmd = { "omnisharp", "--languageserver" , "--hostPID", tostring(pid) };
}

-- F# (Ionide-vim auto setup)

-- Python
lspconfig.pyright.setup{}

-- Go
lspconfig.gopls.setup{}

-- Rust
lspconfig.rust_analyzer.setup {
    cmd = { "rustup", "run", "nightly", "rust-analyzer" }
}

-- Typescript
lspconfig.tsserver.setup {
    cmd = { "typescript-language-server", "--stdio" };
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" };
    init_options = {
        hostInfo = "neovim";
    };
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

vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
vim.lsp.handlers['textDocument/codeAction']  = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references']  = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition']  = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler

EOF

" Coq_Nvim

let g:coq_settings = {
    \ 'auto_start': 'shut-up',
    \ 'display': {
        \ 'preview': {
            \'border': ["╭", "─", "╮", "│", "╯", "─", "╰", "│"]
        \}
    \}
\}
lua require('coq')

" }}}

