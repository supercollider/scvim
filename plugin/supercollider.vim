" Load up supercollider plugin on opening a supercollider file (*.sc, *.scd)
" These are mostly the original files from the former .scvimrc


"set this to 0 if you don't want to kill the terminal with sclangpipe running
"in it when you exit vim
let g:sclangKillOnExit = 1

"the following has worked with osx
let g:sclangTerm = "open -a /Applications/Utilities/Terminal.app"
let g:sclangPipeApp = "bin/sclangpipe_app"

"if setting is blank, this code checks for popular terminals:
if g:sclangTerm == ""
	" on debians (inc ubuntu) this 'alternatives' entry should point to the user's preferred term
	for termcmd in ["/etc/alternatives/x-terminal-emulator", "xterm", "urxvtcd", "rxvt"]
		if executable(termcmd)
			let g:sclangTerm = termcmd . " -e"
			break
		endif
	endfor
	if g:sclangTerm == ""
		echo "scvimrc warning: unable to detect terminal program, hoping xterm exists"
		let g:sclangTerm = "xterm -e"
	endif
endif

"this indicates the location to create a pipe for vim to communicate with
"sclang 
"defaults /tmp/sclang-pipe
"let g:sclangPipeLoc = "/tmp/sclang-pipe"

"this indicates a file where the process id for sclangpipe_app is stored
"default /tmp/sclangpipe_app-pid
"let g:sclangPipeAppPidLoc = "/tmp/sclangpipe_app-pid"

au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd let &iskeyword="@,48-57,_,192-255" | runtime ftplugin/supercollider.vim
" this is the indentation line, we use c indentation as a starter
" au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set noic cin noexpandtab
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd runtime indent/sc_indent.vim

"required for matching
au Filetype supercollider,supercollider_help let b:match_skip = 's:scComment\|scString\|scSymbol'
au Filetype supercollider,supercollider_help let b:match_words = '(:),[:],{:}'

"supercollider vim keybindings
"^R" gives contents of register "

" <C-c><C-c> 
"<C-c><C-c> <C-c><C-c> 

au Filetype supercollider,supercollider_help nmap <buffer> <C-c><C-h> yiw :call SChelp(""")<CR>
au Filetype supercollider,supercollider_help nmap <buffer> <C-c>: yiw :call SCdef(""")<CR>
au Filetype supercollider,supercollider_help nmap <buffer> <C-c><C-d> :call SClang_block()<CR>
au Filetype supercollider,supercollider_help imap <buffer> <C-c><C-d> :call SClang_block()<CR>a
au Filetype supercollider,supercollider_help vmap <buffer> <C-c><C-d> :call SClang_send()<CR>
au Filetype supercollider,supercollider_help vmap <buffer> <C-c><C-c> :call SClang_send()<CR>
au Filetype supercollider,supercollider_help nmap <buffer> <C-c><C-c> :call SClang_send()<CR>
au Filetype supercollider,supercollider_help imap <buffer> <C-c><C-c> :call SClang_send()<CR>a
au Filetype supercollider,supercollider_help nmap <buffer> <C-c><C-k> :call SClang_thisProcess_stop()<CR>
au Filetype supercollider,supercollider_help imap <buffer> <C-c><C-k> :call SClang_thisProcess_stop()<CR>a
au Filetype supercollider,supercollider_help nmap <buffer> <C-c><C-l> :call SClangRestart()<CR>a

au Filetype supercollider,supercollider_help set nowrap
au Filetype supercollider,supercollider_help set textwidth=0
"end of scvim (supercollider vim)
