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
