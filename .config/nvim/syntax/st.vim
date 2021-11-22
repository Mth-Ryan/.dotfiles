" vim: set foldmethod=marker

" Syntax file for Smalltalk
" Author: Mateus Ryan <mthryan@protonmail.com>
" Licence: Mit

if exists("b:current_syntax")
    finish
endif

" Keywords {{{

syn keyword stKeyword self super
syn keyword stBoolean true false
syn keyword stNil     nil

syn cluster stCode add=stBoolean,stNil

" }}} End Keywords

" Objects {{{

syn match stNormal "\<[a-zA-Z][a-zA-Z0-9_]*"
syn match stObject "\<[A-Z][a-zA-Z0-9_]*"

syn cluster stCode add=stNormal,stObject

" }}} End Objects

" Mensages {{{

syn match stBinaryMensage "\<[a-zA-Z][a-zA-Z0-9_]*:"

syn cluster stCode add=stBinaryMensage

" }}} End Mensages

" Numbers {{{

syn match stInteger "\<\d\d*"
syn match stInteger "\<[16]\+r[a-fA-F0-9]*"
syn match stFloat   "\<\d\+\.\d*"

syn cluster stCode add=stInteger,stFloat

" }}} End Numbers

" Conditional {{{

syn match stConditional "\<ifTrue:"
syn match stConditional "\<ifFalse:"

syn cluster stCode add=stConditional

" }}} End Conditional

" Repeat {{{

syn match stRepeat "\<whileTrue:"
syn match stRepeat "\<whileFalse:"
syn match stRepeat "\<timesRepeat:"
syn match stRepeat "\<do:"
syn match stRepeat "\<to:"
syn match stRepeat "\<by:"

syn cluster stCode add=stRepeat

" }}} End Repeat

" Operators {{{

syn match stOperator "*"
syn match stOperator "/"
syn match stOperator "+"
syn match stOperator "-"
syn match stOperator "\~"
syn match stOperator "="
syn match stOperator "%"
syn match stOperator "@"
syn match stOperator "?"
syn match stOperator "<"
syn match stOperator ">"
syn match stOperator "<="
syn match stOperator ">="
syn match stOperator ":="
syn match stOperator "|"
syn match stOperator "\~="
syn match stOperator "\<and:"
syn match stOperator "\<eqv:"
syn match stOperator "\<or:"
syn match stOperator "\<xor:"
syn match stOperator "\<not\>"

syn cluster stCode add=stOperator

" }}} End Operators

" Special {{{

syn match stKeyword "\^"
syn match stKeyword "\<subclass:"

syn cluster stCode add=stKeyword

" }}} End Special

" Regions {{{

syn region stComment
    \ matchgroup=stComment
    \ start=/"/ skip=/""/ end=/"/

syn region stString
    \ matchgroup=stString
    \ start=/'/ skip=/''/ end=/'/

syn cluster stCode add=stComment,stString

syn region stCodeBlock
    \ matchgroup=stCodeBlock
    \ start=/[/ skip=/[]/ end=/]/
    \ contains=stCode
    \ contained transparent


" }}} End Regions

" Links {{{

hi def link stNormal        Normal
hi def link stKeyword       keyword
hi def link stBoolean       Constant
hi def link stComment       Comment
hi def link stString        String
hi def link stNil           Constant
hi def link stInteger       Number
hi def link stFloat         Float
hi def link stObject        Type
hi def link stBinaryMensage Function
hi def link stRepeat        Repeat
hi def link stConditional   Conditional
hi def link stOperator      Operator

" }}} End Links

let b:current_syntax = "st"
