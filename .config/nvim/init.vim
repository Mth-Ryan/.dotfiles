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
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Yggdroot/indentLine'

"Utility
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

"Languages
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'ionide/Ionide-vim', {
      \ 'do':  'make fsautocomplete',
      \}

call plug#end()

filetype plugin indent on

" }}}

" Colors {{{

colorscheme yat

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

" TreeSitter {{{

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  ignore_install = { 
      "rust",
      "go",
      "swift",
      "html"
      },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

" }}} 

" Indent Guides {{{

let g:indentLine_enabled = 0
let g:indentLine_char = '┊'
let g:indentLine_first_char = '┊'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_color_gui = '#303036'

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

" C#
au FileType cs :IndentLinesEnable

" Python
au FileType python :IndentLinesEnable

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

EOF

autocmd BufEnter * lua require'completion'.on_attach()

imap <silent> <C-Space> <Plug>(completion_trigger)

set completeopt=menuone,noinsert,noselect

set shortmess+=c

let g:completion_enable_snippet = 'UltiSnips'
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" }}}

" LightLine {{{

let g:lightline = {}

" Theme
let s:bg0 = "#0B0C0E"
let s:bg1 = "#151518"
let s:bg2 = "#222226"
let s:fg0 = "#D4D2CF"
let s:fg1 = "#818284"
let s:fg2 = "#65676a"
let s:alt = "#fd9149"

let s:p = {'normal': {}, 'inactive': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:fg0, s:bg1 ], [ s:fg1, s:bg2 ] ]
let s:p.normal.middle   = [ [ s:fg2, s:bg0 ] ]
let s:p.normal.right    = [ [ s:fg1, s:bg1 ], [ s:fg1, s:bg2 ] ]

let s:p.insert  = s:p.normal
let s:p.replace = s:p.normal
let s:p.visual  = s:p.normal

let s:p.inactive.left   = [ [ s:bg2, s:bg0 ], [ s:bg2, s:bg0 ] ]
let s:p.inactive.middle = [ [ s:bg2, s:bg0 ] ]
let s:p.inactive.right  = [ [ s:bg2, s:bg0 ], [ s:bg2, s:bg0 ] ]

let s:p.tabline.left    = [ [ s:fg0, s:bg0 ] ]
let s:p.tabline.tabsel  = [ [ s:bg0, s:alt ] ]
let s:p.tabline.middle  = [ [ s:bg2, s:bg0 ] ]
let s:p.tabline.right   = [ [ s:fg2, s:bg1 ] ]


let g:lightline#colorscheme#my_theme#palette = lightline#colorscheme#fill(s:p)

" Components
function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? '' : ''
endfunction

function! LightlineLineinfo()
    return '並' . line('.') . ':' . virtcol('.')
endfunction

function! LightlinePercent()
    let s:percent = line('.') * 100 / line('$')
    return ' ' . s:percent 
endfunction

function! LightlineFugitive()
    let s:head = fugitive#head()
    return s:head ? ' ' . s:head : ''
endfunction

let g:lightline.component_function = {
            \ 'fugitive': 'LightlineFugitive',
            \ 'readonly': 'LightlineReadonly',
            \ 'lineinfo': 'LightlineLineinfo',
            \ 'percent': 'LightlinePercent'
            \ }

" Geral Config

let g:lightline.colorscheme = "my_theme"

let g:lightline.separator    = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

let g:lightline.active = { 
            \ 'left': [ [ 'mode', 'paste' ], 
            \           [ 'readonly', 'filename', 'modified' ],
            \           [ 'fugitive' ] ],
            \
            \ 'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'filetype' ] ]
            \ }

let g:lightline.inactive = {
            \ 'left':  [  ],
            \ 'right': [  ]
            \ }

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

