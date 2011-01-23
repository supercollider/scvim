" Load up supercollider plugin on opening a supercollider file (*.sc, *.scd)
" These are mostly the original files from the former .scvimrc
" Put your customizations into your own .vimrc

" ====================================
" Start the plugin

" set up the plugin
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd runtime ftplugin/supercollider.vim
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd let &iskeyword="@,48-57,_,192-255" 
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd runtime indent/sc_indent.vim

" default tab settings
au FileType supercollider,supercollider_help setlocal shiftwidth=4 tabstop=4 noexpandtab

" required for matching
au Filetype supercollider,supercollider_help let b:match_skip = 's:scComment\|scString\|scSymbol'
au Filetype supercollider,supercollider_help let b:match_words = '(:),[:],{:}'

" key bindings

au Filetype supercollider,supercollider_help nmap <buffer> <F5> :call SClang_block()<CR>
au Filetype supercollider,supercollider_help imap <buffer> <F5> :call SClang_block()<CR>a
au Filetype supercollider,supercollider_help vmap <buffer> <F5> :call SClang_send()<CR>

au Filetype supercollider,supercollider_help vmap <buffer> <F6> :call SClang_send()<CR>
au Filetype supercollider,supercollider_help nmap <buffer> <F6> :call SClang_send()<CR>
au Filetype supercollider,supercollider_help imap <buffer> <F6> :call SClang_send()<CR>a

au Filetype supercollider,supercollider_help nmap <buffer> <F12> :call SClang_thisProcess_stop()<CR>

au Filetype supercollider,supercollider_help nmap <leader>sk :SClangRestart<CR>
au Filetype supercollider,supercollider_help nmap <leader>sd yiw :call SChelp(""")<CR>
au Filetype supercollider,supercollider_help nmap <leader>sj yiw :call SCdef(""")<CR>
au Filetype supercollider,supercollider_help nmap <leader>si yiw :call SCimplementation(""")<CR>
au Filetype supercollider,supercollider_help nmap <leader>sr yiw :call SCreference(""")<CR>
