" Load up supercollider plugin on opening a supercollider file (*.sc, *.scd)
" These are mostly the original files from the former .scvimrc
" Put your customizations into your own .vimrc

" ====================================
" Start the plugin

" set up the plugin
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd runtime ftplugin/supercollider.vim
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd runtime indent/sc_indent.vim
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd let &iskeyword="@,48-57,_,192-255"

" set this via EXPORT ... if you want to change it
if exists($SCVIM_TAGFILE)
  let s:sclangTagsFile = $SCVIM_TAGFILE
else
  let s:sclangTagsFile = "~/.sctags"
endif

au FileType supercollider execute "set tags+=".s:sclangTagsFile

"  matchit
au Filetype supercollider let b:match_skip = 's:scComment\|scString\|scSymbol'
au Filetype supercollider let b:match_words = '(:),[:],{:}'

" key bindings

au Filetype supercollider nnoremap <buffer> <F5> :call SClang_block()<CR>
au Filetype supercollider inoremap <buffer> <F5> :call SClang_block()<CR>a
au Filetype supercollider vnoremap <buffer> <F5> :call SClang_send()<CR>

au Filetype supercollider vnoremap <buffer> <F6> :call SClang_send()<CR>
au Filetype supercollider nnoremap <buffer> <F6> :call SClang_send()<CR>
au Filetype supercollider inoremap <buffer> <F6> :call SClang_send()<CR>a

au Filetype supercollider nnoremap <buffer> <F12> :call SClangHardstop()<CR>

au Filetype supercollider nnoremap <leader>sk :SClangRecompile<CR>
au Filetype supercollider nnoremap <buffer>K :call SChelp(expand('<cword>'))<CR>
au Filetype supercollider inoremap <C-Tab> :call SCfindArgs()<CR>a
au Filetype supercollider nnoremap <C-Tab> :call SCfindArgs()<CR>
au Filetype supercollider vnoremap <C-Tab> :call SCfindArgsFromSelection()<CR>

" DEPRECATED
au Filetype supercollider nnoremap <leader>sd yiw :call SChelp(""")<CR>
au Filetype supercollider nnoremap <leader>sj yiw :call SCdef(""")<CR>
au Filetype supercollider nnoremap <leader>si yiw :call SCimplementation(""")<CR>
au Filetype supercollider nnoremap <leader>sr yiw :call SCreference(""")<CR>

