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

if exists("loaded_scvim") || &cp
   finish
endif
let loaded_scvim = 1

" ========================================================================================
" VARIABLES
let s:bundlePath = expand('<sfile>:p:h:h')

if exists("g:sclangKillOnExit")
	let s:sclangKillOnExit = g:sclangKillOnExit
else
	let s:sclangKillOnExit = 1
endif

if exists("g:sclangTerm")
	let s:sclangTerm = g:sclangTerm
elseif system('uname') =~ 'Linux'
	let s:sclangTerm = "x-terminal-emulator -e $SHELL -ic"
else
	let s:sclangTerm = "open -a Terminal.app"
endif

if exists("g:sclangPipeApp")
	let s:sclangPipeApp	= g:sclangPipeApp
else
	let s:sclangPipeApp	=  s:bundlePath . "/bin/start_pipe"
endif

if exists("g:sclangDispatcher")
	let s:sclangDispatcher = g:sclangDispatcher
else
	let s:sclangDispatcher = s:bundlePath . "/bin/sc_dispatcher"
endif

if !exists("loaded_kill_sclang")
	if s:sclangKillOnExit
		au VimLeavePre * call SClangKillIfStarted()
	endif
	let loaded_kill_sclang = 1
endif

if exists("g:sclangWindowOrientation")
	let s:sclangWindowOrientation = g:sclangWindowOrientation
else
	if executable("tmux")
		let s:sclangWindowOrientation = "h"
	endif
	if executable("screen")
		let s:sclangWindowOrientation = "v"
	endif
endif

if exists("g:sclangWindowSize")
	let s:sclangWindowSize = g:sclangWindowSize
else
	if executable("tmux")
		let s:sclangWindowSize = 50
	endif
	if executable("screen")
		let s:sclangWindowSize = 140
	endif
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
	let l:text = substitute(l:text, '\$', '\\$', 'g')
	let l:text = '"' . l:text . '"'

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

function SClang_line()
  " Wrapper to be able to call `SClang_send()` without calling `FlashLine()`
  call SClang_send()

  let currentline = line('.')
  call FlashLine(currentline)
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
	call FlashRegion(blkstart[0], blkend[0])
endfunction

" ========================================================================================

let s:sclangStarted = 0

function SClangStart(...)
	if $TERM[0:5] == "screen"
		if executable("tmux")
			if a:0 == 0 
				call system("tmux split-window -" . s:sclangWindowOrientation . " -p " . s:sclangWindowSize . " ; tmux send-keys " . s:sclangPipeApp . " Enter ; tmux select-pane -l")
			endif
			if a:0 == 1 
				call system("tmux split-window -" . a:1 . " -p 20 ; tmux send-keys " . s:sclangPipeApp . " Enter ; tmux lelect-pane -l")
			endif
			if a:0 == 2 
				call system("tmux split-window -" . a:1 . " -p " . a:2 . " ; tmux send-keys " . s:sclangPipeApp . " Enter ; tmux select-pane -l")
			endif
			let s:sclangStarted = 1
		else
			echo "Sorry, something went wrong..."
		endif
		if executable("screen")
			if a:0 == 0
				let b:screenName = system("echo -n $STY")
				if s:sclangWindowOrientation == "h"
					call system("screen -S " . b:screenName . " -X split")
				endif
				if s:sclangWindowOrientation == "v"
					call system("screen -S " . b:screenName . " -X split -v")
				endif
				call system("screen -S " . b:screenName . " -X eval focus screen focus")
				call system("screen -S " . b:screenName . " -X at 1# exec " . s:sclangPipeApp)
				call system("screen -S " . b:screenName . " -X resize " . s:sclangWindowSize)
			endif
			if a:0 == 1
				if a:1 == "h"
					let b:screenName = system("echo -n $STY")
					call system("screen -S " . b:screenName . " -X eval split focus screen focus")
				endif
				if a:1 == "v"
					let b:screenName = system("echo -n $STY")
					call system("screen -S " . b:screenName . " -X split -v")
					call system("screen -S " . b:screenName . " -X eval focus screen focus")
				endif
				call system("screen -S " . b:screenName . " -X at 1# exec " . s:sclangPipeApp)
			endif
			if a:0 == 2
				if a:1 == "h"
					let b:screenName = system("echo -n $STY")
					call system("screen -S " . b:screenName . " -X split")
				endif
				if a:1 == "v"
					let b:screenName = system("echo -n $STY")
					call system("screen -S " . b:screenName . " -X split -v")
				endif
				call system("screen -S " . b:screenName . " -X eval focus screen focus")
				call system("screen -S " . b:screenName . " -X at 1# exec " . s:sclangPipeApp)
				call system("screen -S " . b:screenName . " -X resize " . a:2)
			endif
			call system("screen -S " . b:screenName . " -X bindkey -k k5 ")
			let s:sclangStarted = 1
		else
			echo "Sorry, something went wrong..."
		endif
	else
		call system(s:sclangTerm . " " . s:sclangPipeApp . "&")
		let s:sclangStarted = 1
	endif
endfunction

function SClangKill()
  call system(s:sclangDispatcher . " -q")
endfunction

function SClangKillIfStarted()
  if s:sclangStarted == 1
    call SClangKill()
  endif
endfunction

function SClangRecompile()
  echo s:sclangDispatcher
  call system(s:sclangDispatcher . " -k")
  call system(s:sclangDispatcher . " -s ''")
  redraw!
endfunction

function SClangHardstop()
  call SendToSCSilent('thisProcess.hardStop()')
endfunction

" Introspection and Help Files

function SCdef(subject)
  call SendToSCSilent('SCVim.openClass("' . a:subject . '");')
endfun

function SChelp(subject)
  call SendToSCSilent('HelpBrowser.openHelpFor("' . a:subject . '");')
endfun

function SCreference(subject)
  call SendToSCSilent('SCVim.methodReferences("' . a:subject . '");')
endfun

function SCimplementation(subject)
  call SendToSCSilent('SCVim.methodTemplates("' . a:subject . '");')
endfun

function SCfindArgs()
  let l:subject = getline(line("."))
  call SendToSC('Help.methodArgs("' . l:subject . '");')
endfun

function SCfindArgsFromSelection()
  let l:subject = s:get_visual_selection()
  call SendToSC('Help.methodArgs("' . l:subject . '");')
endfun

function SCtags()
  call SendToSC("SCVim.generateTagsFile();")
endfun

function! s:get_visual_selection()
  " http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

" ========================================================================================

" Compatibility
highlight Evaluated term=reverse cterm=reverse guibg=Grey

function FlashLine(line)
  let pattern = '\%' . a:line . 'l'
  call Flash(pattern)
endfunction

function FlashRegion(start, end)
  let first = a:start - 1
  let last  = a:end + 1
  let pattern  = ''
  let pattern .= '\%>' . first . 'l'
  let pattern .= '\%<' . last . 'l'
  let pattern .= '.'

  call Flash(pattern)
endfunction

function Flash(pattern)
  " Highlight the pattern (line or region) for 150ms if `scFlash` is enabled
  if !exists('g:scFlash') | return | endif

  call matchadd('Evaluated', a:pattern)
  redraw

  " timers were introduced in vim-8.0
  if has('timers')
    call timer_start(200, 'ClearFlash')
  else
    sleep 200m
    call ClearFlash()
  endif
endfunction

function ClearFlash(...)
  call clearmatches()
endfunction

"custom commands (SChelp,SCdef,SClangfree)
com -nargs=0 SClangHardstop call SClangHardstop()
com -nargs=0 SClangStart call SClangStart()
com -nargs=0 SClangKill call SClangKill()
com -nargs=0 SClangRecompile call SClangRecompile()
com -nargs=0 SCtags call SCtags()
com -nargs=0 SChelp call SChelp('')

" end supercollider.vim
