"__   __    _   
"\ \ / /_ _| |_ 
" \ V / _` | __|
"  | | (_| | |_ 
"  |_|\__,_|\__|
                                                         
" File:        yat.vim
" Author:      Mateus Ryan <mthryan@protonmail.com>
" Description: Yes, another theme
" Licence:     MIT

hi clear

if exists("syntax on")
syntax reset
endif

set t_Co=256
let g:colors_name = "yat"

" Colors {{{

let s:bg       = "#0B0C0E"
let s:fg       = "#D4D2CF"
let s:fg2      = "#c3c1be"
let s:fg3      = "#b2b0ae"
let s:fg4      = "#a1a09d"
let s:bg2      = "#151518"
let s:bg3      = "#222226"
let s:bg4      = "#303036"
let s:orange   = "#fd9149"
let s:purple   = "#A682B0"
let s:red      = "#BF5151"
let s:gray     = "#65676a"
let s:green    = "#bfd066"
let s:blue     = "#7CA5BF"
let s:cyan     = "#9BC5AF"
let s:error    = "#c13535"
let s:warn     = "#f0c674"

" }}}

" UI {{{

exe 'hi Normal       guifg='s:fg'       guibg='s:bg
exe 'hi NonText      guifg='s:bg4'      guibg='s:bg
exe 'hi EndOfBuffer  guifg='s:bg4'      guibg='s:bg
exe 'hi Cursor       guifg='s:bg'       guibg='s:fg
exe 'hi CursorLine                      guibg='s:bg2       
exe 'hi CursorLineNr guifg='s:green'    guibg='s:bg
exe 'hi CursorColumn                    guibg='s:bg4       
exe 'hi ColorColumn                     guibg='s:bg4       
exe 'hi LineNr       guifg='s:bg4'      guibg=NONE'
exe 'hi SignColumn                      guibg=NONE'
exe 'hi VertSplit    guifg='s:bg'       guibg='s:bg4
exe 'hi MatchParen   guifg='s:error'                      gui=underline'
exe 'hi StatusLine   guifg='s:fg2'      guibg='s:bg3'     gui=bold'
exe 'hi Pmenu        guifg='s:fg'       guibg='s:bg2
exe 'hi PmenuSel     guifg='s:bg'       guibg='s:blue
exe 'hi IncSearch    guifg='s:bg2'      guibg='s:fg
exe 'hi Search       guifg='s:error'    guibg='s:bg'      gui=bold,underline'
exe 'hi Directory    guifg='s:red
exe 'hi Folded       guifg='s:fg4'      guibg='s:bg
exe 'hi WildMenu     guifg='s:green'    guibg='s:bg

exe 'hi DiffAdd      guifg=#fafafa      guibg=#123d0f     gui=bold'
exe 'hi DiffDelete   guibg='s:bg4                         
exe 'hi DiffChange   guibg=#151b3c      guifg=#fafafa'    
exe 'hi DiffText     guifg=#ffffff      guibg=#ff0000     gui=bold'
exe 'hi ErrorMsg     guifg='s:error'    guibg='s:bg'      gui=bold'
exe 'hi WarningMsg   guifg='s:warn'     guibg='s:bg
exe 'hi Label        guifg='s:fg        
exe 'hi Title        guifg='s:fg
exe 'hi SpecialKey   guifg='s:fg2'      guibg='s:bg4
exe 'hi Todo         guifg='s:cyan'     guibg='s:bg'      gui=bold'
exe 'hi Underlined   gui=underline'

exe 'hi LspDiagnosticsDefaultError           guifg='s:error
exe 'hi LspDiagnosticsVirtualTextError       guifg='s:error
exe 'hi LspDiagnosticsUnderlineError         guifg='s:error
exe 'hi LspDiagnosticsFloatingError          guifg='s:error
exe 'hi LspDiagnosticsSignError              guifg='s:error
exe 'hi LspDiagnosticsDefaultWarning         guifg='s:warn
exe 'hi LspDiagnosticsVirtualTextWarning     guifg='s:warn
exe 'hi LspDiagnosticsUnderlineWarning       guifg='s:warn
exe 'hi LspDiagnosticsFloatingWarning        guifg='s:warn
exe 'hi LspDiagnosticsSignWarning            guifg='s:warn
exe 'hi LspDiagnosticsDefaultInformation     guifg='s:blue
exe 'hi LspDiagnosticsVirtualTextInformation guifg='s:blue
exe 'hi LspDiagnosticsUnderlineInformation   guifg='s:blue
exe 'hi LspDiagnosticsFloatingInformation    guifg='s:blue
exe 'hi LspDiagnosticsSignInformation        guifg='s:blue
exe 'hi LspDiagnosticsDefaultHint            guifg='s:purple
exe 'hi LspDiagnosticsVirtualTextHint        guifg='s:purple
exe 'hi LspDiagnosticsUnderlineHint          guifg='s:purple
exe 'hi LspDiagnosticsFloatingHint           guifg='s:purple
exe 'hi LspDiagnosticsSignHint               guifg='s:purple

exe 'sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsDefaultError'
exe 'sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsDefaultWarning'
exe 'sign define LspDiagnosticsSignInformation text=כֿ texthl=LspDiagnosticsDefaultInformation'
exe 'sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsDefaultHint'

" }}}

" Syntax {{{

exe 'hi Comment      guifg='s:gray
exe 'hi Character    guifg='s:red
exe 'hi Conditional  guifg='s:red
exe 'hi Repeat       guifg='s:red
exe 'hi Constant     guifg='s:red
exe 'hi Float        guifg='s:cyan
exe 'hi Number       guifg='s:cyan
exe 'hi Boolean      guifg='s:cyan
exe 'hi Function     guifg='s:fg
exe 'hi Special      guifg='s:fg
exe 'hi Identifier   guifg='s:fg'      gui=italic'
exe 'hi Keyword      guifg='s:orange
exe 'hi Statement    guifg='s:orange'  gui=NONE'
exe 'hi Tag          guifg='s:orange
exe 'hi PreProc      guifg='s:purple
exe 'hi Define       guifg='s:purple
exe 'hi Operator     guifg='s:purple
exe 'hi StorageClass guifg='s:purple'  gui=italic'
exe 'hi String       guifg='s:green
exe 'hi Type         guifg='s:blue'    gui=NONE'

" }}}

" Terminal Mode {{{

let g:terminal_color_0  = s:bg
let g:terminal_color_1  = s:warn
let g:terminal_color_2  = s:orange
let g:terminal_color_3  = s:bg4
let g:terminal_color_4  = s:fg
let g:terminal_color_5  = s:purple
let g:terminal_color_6  = s:fg3
let g:terminal_color_7  = s:green
let g:terminal_color_8  = s:bg4
let g:terminal_color_9  = s:error
let g:terminal_color_10 = s:fg2
let g:terminal_color_11 = s:fg
let g:terminal_color_12 = s:blue
let g:terminal_color_13 = s:red
let g:terminal_color_14 = s:fg4
let g:terminal_color_15 = s:gray

" }}}

" Specific languages {{{

" Html Highlighting
hi! link htmlTagName Character

" Markdown Highlighting
exe 'hi mkdCode guifg='s:purple

" }}}
