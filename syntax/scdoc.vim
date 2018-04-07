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
" Language: scdoc (SuperCollider help file markup)

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

setlocal iskeyword=a-z,A-Z,48-57,_

syn case ignore

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" header tags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: highlighting of remainder of lines?
syn match scdocTitle /\<title::/
syn match scdocCategories /\<categories::/
syn match scdocRelated /\<related::/
syn match scdocSummary /\<summary::/
syn match scdocRedirect /\<redirect::/

" deprecated
syn match scdocClass /\<class::/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" section tags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: intelligent highlighting?
syn match scdocSection /\<section::/
syn match scdocDescription /\<description::/
syn match scdocClassmethods /\<classmethods::/
syn match scdocInstancemethods /\<instancemethods::/
syn match scdocExamples /\<examples::/
syn match scdocSubsection /\<subsection::/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" method tags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" TODO: intelligent highlighting
syn match scdocMethod /\<method::/
syn match scdocPrivate /\<private::/
syn match scdocCopymethod /\<copymethod::/
syn match scdocArgument /\<argument::/
syn match scdocReturns /\<returns::/
syn match scdocDiscussion /\<discussion::/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" modal tags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syn region scdocStrong matchgroup=scdocSimpleTag start=/\<strong::/ skip=/\\::/ end=/::/
syn region scdocEmphasis matchgroup=scdocSimpleTag start=/\<emphasis::/ skip=/\\::/ end=/::/
syn region scdocSoft matchgroup=scdocSimpleTag start=/\<soft::/ skip=/\\::/ end=/::/
syn region scdocLink matchgroup=scdocSimpleTag start=/\<link::/ skip=/\\::/ end=/::/
syn region scdocAnchor matchgroup=scdocSimpleTag start=/\<anchor::/ skip=/\\::/ end=/::/
syn region scdocImage matchgroup=scdocSimpleTag start=/\<image::/ skip=/\\::/ end=/::/

" teletype and code have inline and block forms
" NOTE: make sure oneline version is last so it has priority!
syn region scdocTeletype matchgroup=scdocSimpleTag start=/\<teletype::/ end=/^::/
syn region scdocTeletype oneline matchgroup=scdocSimpleTag start=/\<teletype::/ skip=/\\::/ end=/::/

" code (see :syn-include)
" keepend needed to avoid :: being matched as supercollider code
syn include @SCCode syntax/supercollider.vim
syn region scdocCode keepend matchgroup=scdocSimpleTag start=/\<code::/ end=/^::/ contains=@SCCode
syn region scdocCode oneline keepend matchgroup=scdocSimpleTag start=/\<code::/ skip=/\\::/ end=/::/ contains=@SCCode

" notes and warnings
syn cluster SCDocModalTag contains=
            \scdocStrong,
            \scdocEmphasis,
            \scdocSoft,
            \scdocLink,
            \scdocAnchor,
            \scdocImage,
            \scdocCode,
            \scdocTeletype

syn region scdocNote matchgroup=scdocSimpleTag start=/\<note::/ skip=/\\::/ end=/::/ contains=@SCDocModalTag
syn region scdocWarning matchgroup=scdocSimpleTag start=/\<warning::/ skip=/\\::/ end=/::/ contains=@SCDocModalTag
syn region scdocFootnote matchgroup=scdocSimpleTag start=/\<footnote::/ skip=/\\::/ end=/::/ contains=@SCDocModalTag

" lists and tables
syn match scdocBullet /#\@<!##/ contained
syn match scdocColumnSep /|\@<!||/ contained

syn region scdocTable matchgroup=scdocSimpleTag
            \ start=/\<Table::/ skip=/\\::/ end=/::/ contains=@SCDocModalTag,scdocBullet,scdocColumnSep

syn region scdocDefinitionList matchgroup=scdocSimpleTag
            \ start=/\<DefinitionList::/ skip=/\\::/ end=/::/ contains=@SCDocModalTag,scdocBullet,scdocColumnSep

syn region scdocList matchgroup=scdocSimpleTag
            \ start=/\<List::/ skip=/\\::/ end=/::/ contains=@SCDocModalTag,scdocBullet

syn region scdocNumberedList matchgroup=scdocSimpleTag
            \ start=/\<NumberedList::/ skip=/\\::/ end=/::/ contains=@SCDocModalTag,scdocBullet

syn region scdocTree matchgroup=scdocSimpleTag
            \ start=/\<Tree::/ skip=/\\::/ end=/::/ contains=@SCDocModalTag,scdocBullet

syn case match

"""""""""""""""""""""""""""""""""""""""""
" linkage

hi def link scdocTitle Constant
hi def link scdocCategories Constant
hi def link scdocRelated Constant
hi def link scdocSummary Constant
hi def link scdocRedirect Constant
hi def link scdocClass Constant

hi def link scdocSection Identifier
hi def link scdocDescription Identifier
hi def link scdocClassmethods Identifier
hi def link scdocInstancemethods Identifier
hi def link scdocExamples Identifier

hi def link scdocSubsection Type

hi def link scdocMethod Statement
hi def link scdocPrivate Statement
hi def link scdocCopymethod Statement
hi def link scdocArgument Statement
hi def link scdocReturns Statement
hi def link scdocDiscussion Statement

hi scdocStrong cterm=bold
hi scdocEmphasis cterm=italic
hi def link scdocSoft Comment
hi def link scdocLink Underlined
hi def link scdocAnchor Underlined
hi def link scdocImage Underlined
hi def link scdocTeletype Statement

hi def link scdocNote String
hi def link scdocWarning Todo
hi def link scdocFootnote Comment

hi def link scdocSimpleTag Special

hi def link scdocColumnSep PreProc
hi def link scdocBullet PreProc

let b:current_syntax = "schelp"
