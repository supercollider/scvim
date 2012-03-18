" SuperCollider/Vim interaction scripts
" Copyright 2007 Alex Norman
" 
" modified 2010 stephen lumenta
" Don't worry about the pipes in here. This is all taken care of inside of the
" ruby script
"
"
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
 

" source the syntax file as it can change
" so $SCVIM_DIR/syntax/supercollider.vim
runtime! syntax/supercollider.vim

" ========================================================================================

if exists("loaded_scvim") || &cp
   finish
endif
let loaded_scvim = 1

"first if SCVIM_CACHE_DIR is defined, use that,
"otherwise use ~/.scvim
if exists("$SCVIM_CACHE_DIR") 
	let s:scvim_cache_dir = $SCVIM_CACHE_DIR
else
	let s:scvim_cache_dir = $HOME . "/.scvim"
	let $SCVIM_CACHE_DIR = s:scvim_cache_dir
endif

"add the cache dir to 
set runtimepath+=$SCVIM_CACHE_DIR

if exists("g:sclangKillOnExit")
	let s:sclangKillOnExit = g:sclangKillOnExit
else
	let s:sclangKillOnExit = 0
endif

if exists("g:sclangTerm")
	let s:sclangTerm = g:sclangTerm
else
	let s:sclangTerm = "open -a Terminal.app"
endif

if exists("g:sclangPipeApp")
	let s:sclangPipeApp	= g:sclangPipeApp
else
	let s:sclangPipeApp	= "~/.vim/bundle/supercollider/bin/start_pipe"
endif

if exists("g:sclangDispatcher")
	let s:sclangDispatcher = g:sclangDispatcher
else
	let s:sclangDispatcher = "~/.vim/bundle/supercollider/bin/sc_dispatcher"
endif

if !exists("loaded_kill_sclang")
	if s:sclangKillOnExit
		au VimLeave * call SClangKill()
	endif
	let loaded_kill_sclang = 1
endif

" ========================================================================================

function! FindOuterMostBlock()
	"search backwards for parens dont wrap
	let l:search_expression_up = "call searchpair('(', '', ')', 'bW'," .
		\"'synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scComment\" || " .
		\"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scString\" || " .
		\"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scSymbol\"')"
	"search forward for parens, don't wrap
	let l:search_expression_down = "call searchpair('(', '', ')', 'W'," .
		\"'synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scComment\" || " .
		\"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scString\" || " .
		\"synIDattr(synID(line(\".\"), col(\".\"), 0), \"name\") =~? \"scSymbol\"')"

	"save our current cursor position
	let l:returnline = line(".")
	let l:returncol = col(".")
	
	"if we're on an opening paren then we should actually go to the closing one to start the search
	"if buf[l:returnline][l:returncol-1,1] == "("
	if strpart(getline(line(".")),col(".") - 1,1) == "("
		exe l:search_expression_down
	endif

	let l:origline = line(".")
	let l:origcol = col(".")

	"these numbers will define our range, first init them to illegal values
	let l:range_e = [-1, -1]
	let l:range_s = [-1, -1]

	"this is the last line in our search
	let l:lastline = line(".")
	let l:lastcol = col(".")

	exe l:search_expression_up

	while line(".") != l:lastline || (line(".") == l:lastline && col(".") != l:lastcol)
		"keep track of the last line/col we were on
		let l:lastline = line(".")
		let l:lastcol = col(".")
		"go to the matching paren
		exe l:search_expression_down

		"if there isn't a match print an error
		if l:lastline == line(".") && l:lastcol == col(".")
			call cursor(l:returnline,l:returncol)
			throw "UnmachedParen at line:" . l:lastline . ", col: " . l:lastcol
		endif

		"if this is equal to or later than our original cursor position
		if line(".") > l:origline || (line(".") == l:origline && col(".") >= l:origcol)
			let l:range_e = [line("."), col(".")]
			"go back to opening paren
			exe l:search_expression_up
			let l:range_s = [line("."), col(".")]
		else
			"go back to opening paren
			exe l:search_expression_up
		endif
		"find next paren (if there is one)
		exe l:search_expression_up
	endwhile

	"restore the settings
	call cursor(l:returnline,l:returncol)

	if l:range_s[0] == -1 || l:range_s[1] == -1
		throw "OutsideOfParens"
	endif
	
	"return the ranges
	 return [l:range_s, l:range_e]
endfunction

" ========================================================================================


function SCFormatText(text)
	let l:text = substitute(a:text, '\', '\\\\', 'g')
	let l:text = substitute(l:text, '"', '\\"', 'g')
	let l:text = substitute(l:text, '`', '\\`', 'g')
  let l:text = '"' . l:text .'"'

  return l:text
endfunction

function SendToSC(text)
  let l:text = SCFormatText(a:text)

  call system(s:sclangDispatcher . " -i " . l:text)
  redraw!
endfunction

function SendToSCSilent(text)
  let l:text = SCFormatText(a:text)

  call system(s:sclangDispatcher . " -s " . l:text)
  redraw!
endfunction

" a variable to hold the buffer content
let s:cmdBuf = ""

function SClang_send()
  let currentline = line(".")
  let s:cmdBuf = s:cmdBuf . getline(currentline) . "\n"
  
  if(a:lastline == currentline)
    call SendToSC(s:cmdBuf)

    " clear the buffer again
    let s:cmdBuf = ""
  endif
endfunction

function SClang_block()
	let [blkstart,blkend] = FindOuterMostBlock()
	"blkstart[0],blkend[0] call SClang_send()
	"these next lines are just a hack, how can i do the above??
	let cmd = blkstart[0] . "," . blkend[0] . " call SClang_send()"
	let l:origline = line(".")
	let l:origcol = col(".")
	exe cmd
	call cursor(l:origline,l:origcol)
endfunction

" ========================================================================================

function SClangStart()
  call system(s:sclangTerm . " " . s:sclangPipeApp)
endfunction

function SClangKill()
  call system(s:sclangDispatcher . " -q")
endfunction

function SClangRestart()
  echo s:sclangDispatcher
  call system(s:sclangDispatcher . " -k")
  call system(s:sclangDispatcher . " -s ''")
  redraw!
endfunction

function SClang_thisProcess_stop()
	call system(s:sclangDispatcher . ' -s thisProcess.stop;')
	redraw!
endfunction

function SClang_free(server)
	call SendToSC('s.freeAll;')
	redraw!
endfunction

function SClang_TempoClock_clear()
	call SendToSC('TempoClock.default.clear;')
	redraw!
endfunction

" Introspection and Help Files

function SCdef(subject)
  call SendToSCSilent('SCVim.openClass("' . a:subject . '");')
endfun

function SChelp(subject)
  call SendToSCSilent('SCVim.findHelp("' . a:subject . '");')
endfun

function SCreference(subject)
  call SendToSCSilent('SCVim.methodReferences("' . a:subject . '");')
endfun

function SCimplementation(subject)
  call SendToSCSilent('SCVim.methodTemplates("' . a:subject . '");')
endfun

function SCfindMethods(subject)
  call SendToSCSilent('SCVim.displayMethods("' . a:subject . '");')
endfun

"custom commands (SChelp,SCdef,SClangfree)
com -nargs=1 SClangfree call SClang_free("<args>")
com -nargs=0 SClangStart call SClangStart()
com -nargs=0 SClangKill call SClangKill()
com -nargs=0 SClangRestart call SClangRestart()

" end supercollider.vim
