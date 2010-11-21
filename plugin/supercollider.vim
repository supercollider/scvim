" Load up supercollider plugin on opening a supercollider file (*.sc, *.scd)
" These are mostly the original files from the former .scvimrc


" ====================================
" Settings

" let g:sclangKillOnExit = 1

"the following has worked with osx
" let g:sclangTerm = "open -a Terminal.app"
" let g:sclangPipeApp = "../bin/start_pipe"

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


" ====================================
" Start the plugin

" set up the plugin
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd runtime ftplugin/supercollider.vim
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd let &iskeyword="@,48-57,_,192-255" 
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd runtime indent/sc_indent.vim

"required for matching
au Filetype supercollider,supercollider_help let b:match_skip = 's:scComment\|scString\|scSymbol'
au Filetype supercollider,supercollider_help let b:match_words = '(:),[:],{:}'

" key bindings
au Filetype supercollider,supercollider_help nmap <buffer> <C-c><C-h> yiw :call SChelp(""")<CR>
au Filetype supercollider,supercollider_help nmap <buffer> <C-c>: yiw :call SCdef(""")<CR>
au Filetype supercollider,supercollider_help nmap <buffer> <C-c><C-d> :call SClang_block()<CR>
au Filetype supercollider,supercollider_help vmap <buffer> <C-c><C-d> :call SClang_send()<CR>
au Filetype supercollider,supercollider_help vmap <buffer> <C-c><C-c> :call SClang_send()<CR>
au Filetype supercollider,supercollider_help nmap <buffer> <C-c><C-c> :call SClang_send()<CR>
au Filetype supercollider,supercollider_help nmap <buffer> <C-c><C-k> :call SClang_thisProcess_stop()<CR>
au Filetype supercollider,supercollider_help nmap <buffer> <C-c><C-l> :call SClangRestart()<CR>a

au Filetype supercollider,supercollider_help set nowrap
au Filetype supercollider,supercollider_help set textwidth=0
"end of scvim (supercollider vim)
