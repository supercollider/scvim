" Load up supercollider plugin on opening a supercollider file (*.sc, *.scd)
" These are mostly the original files from the former .scvimrc
" Put your customizations into your own .vimrc

" ====================================
" Start the plugin

augroup scvim
  autocmd!
augroup END

" set this via EXPORT ... if you want to change it
if exists($SCVIM_TAGFILE)
  let s:sclangTagsFile = $SCVIM_TAGFILE
else
  let s:sclangTagsFile = "~/.sctags"
endif

au scvim FileType supercollider execute "set tags+=".s:sclangTagsFile

"  matchit
au scvim Filetype supercollider let b:match_skip = 's:scComment\|scString\|scSymbol'
au scvim Filetype supercollider let b:match_words = '(:),[:],{:}'

" key bindings
if !exists("g:scvim_no_mappings")
  au scvim Filetype supercollider nnoremap <buffer> <F5> :call SClang_block()<CR>
  au scvim Filetype supercollider inoremap <buffer> <F5> :call SClang_block()<CR>a
  au scvim Filetype supercollider vnoremap <buffer> <F5> :call SClang_line()<CR>

  au scvim Filetype supercollider vnoremap <buffer> <F6> :call SClang_line()<CR>
  au scvim Filetype supercollider nnoremap <buffer> <F6> :call SClang_line()<CR>
  au scvim Filetype supercollider inoremap <buffer> <F6> :call SClang_line()<CR>a

  au scvim Filetype supercollider nnoremap <buffer> <F12> :call SClangHardstop()<CR>

  au scvim Filetype supercollider nnoremap <buffer> K :call SChelp(expand('<cword>'))<CR>
  au scvim Filetype supercollider nnoremap <buffer> <leader>sk :SClangRecompile<CR>
  au scvim Filetype supercollider inoremap <buffer> <C-Tab> :call SCfindArgs()<CR>a
  au scvim Filetype supercollider nnoremap <buffer> <C-Tab> :call SCfindArgs()<CR>
  au scvim Filetype supercollider vnoremap <buffer> <C-Tab> :call SCfindArgsFromSelection()<CR>

  " DEPRECATED
  au scvim Filetype supercollider nnoremap <leader>sd yiw :call SChelp(""")<CR>
  au scvim Filetype supercollider nnoremap <leader>sj yiw :call SCdef(""")<CR>
  au scvim Filetype supercollider nnoremap <leader>si yiw :call SCimplementation(""")<CR>
  au scvim Filetype supercollider nnoremap <leader>sr yiw :call SCreference(""")<CR>
endif
