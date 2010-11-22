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

"required for matching
" au Filetype supercollider,supercollider_help let b:match_skip = 's:scComment\|scString\|scSymbol'
" au Filetype supercollider,supercollider_help let b:match_words = '(:),[:],{:}'

" key bindings

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

au Filetype supercollider,supercollider_help nmap <leader>k :SClangRestart<CR>


" au Filetype supercollider,supercollider_help nmap <buffer> <F7> :call SClang_TempoClock_clear()<CR>
" au Filetype supercollider,supercollider_help imap <buffer> <F7> :call SClang_TempoClock_clear()<CR>a
" au Filetype supercollider,supercollider_help nmap <buffer> <F8> :call SClang_free("s")<CR>
" au Filetype supercollider,supercollider_help imap <buffer> <F8> :call SClang_free("s")<CR>a
au Filetype supercollider,supercollider_help nmap <buffer> <F12> :call SClang_thisProcess_stop()<CR>
au Filetype supercollider,supercollider_help imap <buffer> <F12> :call SClang_thisProcess_stop()<CR>a
