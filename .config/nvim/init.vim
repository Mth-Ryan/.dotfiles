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

call plug#begin('~/.config/nvim/plugged')

"Visual
Plug 'arzg/vim-colors-xcode'  "colors
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

"Utility
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Languages
Plug 'fatih/vim-go'           "Go
Plug 'keith/swift.vim'        "Swift
Plug 'rust-lang/rust.vim'     "Rust

call plug#end()

filetype plugin indent on

" }}}

" Colors {{{

colorscheme xcodedark

" Terminal Background color: #181B20

hi! Normal      guibg=NONE ctermbg=NONE
hi! NonText     guibg=NONE ctermbg=NONE
hi! EndOfBuffer guibg=NONE ctermbg=NONE
hi! Folded      guibg=NONE ctermbg=NONE
hi! Statement     gui=NONE   cterm=NONE
hi! foldcolumn  guibg=NONE
hi! VertSplit   guibg=NONE guifg=#53606e

hi! NvimTreeRootFolder       guifg=#53606e
hi! NvimTreeSymlink          guifg=#a3b1bf
hi! NvimTreeFolderName       guifg=#a3b1bf
hi! NvimTreeFolderIcon       guifg=#a3b1bf
hi! NvimTreeEmptyFolderName  guifg=#a3b1bf
hi! NvimTreeOpenedFolderName guifg=#a3b1bf
hi! NvimTreeExecFile         guifg=#dabaff
hi! NvimTreeOpenedFile       guifg=#a3b1bf
hi! NvimTreeSpecialFile      guifg=#a3b1bf
hi! NvimTreeImageFile        guifg=#a3b1bf
hi! NvimTreeMarkdownFile     guifg=#a3b1bf
hi! NvimTreeIndentMarker     guifg=#a3b1bf
hi! NvimTreeGitDirty         guifg=#a3b1bf
hi! NvimTreeGitStaged        guifg=#a3b1bf
hi! NvimTreeGitMerge         guifg=#a3b1bf
hi! NvimTreeGitRenamed       guifg=#a3b1bf
hi! NvimTreeGitNew           guifg=#a3b1bf
hi! NvimTreeGitDeleted       guifg=#a3b1bf

" }}}

" TreeSitter {{{

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  ignore_install = { "rust", "go", "swift" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

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


" }}}

" LightLine {{{

let g:lightline = {}

" Theme
let s:bg0 = "#181B20"
let s:bg1 = "#191F25"
let s:bg2 = "#232930"
let s:fg0 = "#D3D6D9"
let s:fg1 = "#848C95"
let s:fg2 = "#5C6773"
let s:alt = "#dabaff"

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

