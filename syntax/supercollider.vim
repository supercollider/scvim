" Copyright 2007 Alex Norman
" This file is part of SCVIM.
"
" SCVIM is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" SCVIM is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with SCVIM.  If not, see <http://www.gnu.org/licenses/>.
"
" Vim syntax file
" Language:	supercollider	
" Maintainer: Stephen Lumenta <stephen.lumenta@gmail.com>
" Version:	0.2
" Last change:	2012-03-31

syn clear

syn match	scAoperator	"{"
syn match	scAoperator	"}"

"syn	match	scVariable	"\%(var.*\)\@<=\(\l\w*\)" "lowercase followed by wordchar
syn	match	scGlobvariable	"\~\l\w*" "~ followed by lowercase followed by wordchar
syn	match scVar "\s*var\s"
syn	match scVar "\s*classvar\s"
syn	match scArg "\s*arg\s"

" symbols, strings, etc
"syn match	scSymbol "\(\w\\\)\@<!\'.\{-}\'" "\{-} is a non greedy version of *
"syn match	scSymbol "\(\w\|\\\)\@<!\'.\{-}\(\\\)\@<!\'" "\{-} is a non greedy version of *

syn match	scSymbol "\v(\w|\\)@<!\'.{-}(\\)@<!\'" "\{-} is a non greedy version of *
"syn match	scSymbol "\$\@<!\\\w\w*"
syn match	scSymbol "\v\$@<!\\\w\w*"
syn match	scSymbol "\\\\"
syn match	scSymbol "\w\+:"

syn match	scChar	"\$\w"
syn match	scChar	"\$\\\\"
syn match	scChar	"\$\\\w"

syn match scInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[xX]\x\+\%(_\x\+\)*\>"								display
syn match scInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0[dD]\)\=\%(0\|[1-9]\d*\%(_\d\+\)*\)\>"						display
syn match scInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[oO]\=\o\+\%(_\o\+\)*\>"								display
syn match scInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[bB][01]\+\%(_[01]\+\)*\>"								display
syn match scFloat	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\.\d\+\%(_\d\+\)*\>"					display
syn match scFloat	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\%(\.\d\+\%(_\d\+\)*\)\=\%([eE][-+]\=\d\+\%(_\d\+\)*\)\>"	display

"syn match	scString "\".\{-}\""
"syn region	scString start=+\v\\@<!"+ end=+\v\\@<!"+ 
syn region  scString start=+"+ skip=+\\\\\|\\"+ end=+"+

"syn match	scClass "\u\w*"	"upper case followed by any wordchar

syn keyword	scSpecialval nil true false inf this

"syn keyword	repeat do for while

"syn region	literalarray start="\#\[" end="\]"
"need to figure out how to make it match the mattching braket

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rate

"syn match scFun "\.\@<=\a\w*"

syn match scArate "\v\.@<=ar(\w)@!"
syn match scKrate "\v\.@<=kr(\w)@!"

" TODO we hard code the paths for now
runtime! syntax/supercollider_objects.vim
runtime! syntax/supercollider_operators.vim

" comments
syn match	  scLineComment	"\/\/.*" 
syn region	scComment	start="/\*" end="\*/" 


hi def link scObject Identifier
hi def link scLang Identifier
hi def link scBinaryoperator Special
hi def link scUnaryoperator Special
hi def link scAoperator Statement
hi def link scArate Statement
hi def link scKrate Statement
hi def link scSymbol Constant
hi def link scString String
hi def link scChar String
hi def link scInteger Number
hi def link scFloat Number
hi def link scSpecialval Constant
hi def link scGlobVariable Define
hi def link scComment     Comment
hi def link scLineComment Comment
hi def link scVar Type
hi def link scArg Type

let b:current_syntax = "supercollider"
