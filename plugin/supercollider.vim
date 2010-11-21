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
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc runtime indent/sc_indent.vim

"required for matching
au Filetype supercollider,supercollider_help let b:match_skip = 's:scComment\|scString\|scSymbol'
au Filetype supercollider,supercollider_help let b:match_words = '(:),[:],{:}'

"supercollider vim keybindings
"^R" gives contents of register "

au Filetype supercollider,supercollider_help nmap <buffer> K yiw :call SChelp(""")<CR>
au Filetype supercollider,supercollider_help imap <buffer>  yiw :call SChelp(""")<CR>
au Filetype supercollider,supercollider_help nmap <buffer>  yiw :call SCdef(""")<CR>
au Filetype supercollider,supercollider_help imap <buffer>  yiw :call SCdef(""")<CR>
au Filetype supercollider,supercollider_help nmap <buffer> <F5> :call SClang_block()<CR>
au Filetype supercollider,supercollider_help imap <buffer> <F5> :call SClang_block()<CR>a
au Filetype supercollider,supercollider_help vmap <buffer> <F5> :call SClang_send()<CR>
au Filetype supercollider,supercollider_help vmap <buffer> <F6> :call SClang_send()<CR>
au Filetype supercollider,supercollider_help nmap <buffer> <F6> :call SClang_send()<CR>
au Filetype supercollider,supercollider_help imap <buffer> <F6> :call SClang_send()<CR>a
au Filetype supercollider,supercollider_help nmap <buffer> <F7> :call SClang_TempoClock_clear()<CR>
au Filetype supercollider,supercollider_help imap <buffer> <F7> :call SClang_TempoClock_clear()<CR>a
au Filetype supercollider,supercollider_help nmap <buffer> <F8> :call SClang_free("s")<CR>
au Filetype supercollider,supercollider_help imap <buffer> <F8> :call SClang_free("s")<CR>a
au Filetype supercollider,supercollider_help nmap <buffer> <F12> :call SClang_thisProcess_stop()<CR>
au Filetype supercollider,supercollider_help imap <buffer> <F12> :call SClang_thisProcess_stop()<CR>a

"end of scvim (supercollider vim)
