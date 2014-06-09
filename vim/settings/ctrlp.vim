" mappings
map <C-p> :CtrlP<cr>
map <C-t> :CtrlPBufTag<cr>


" Use The Silver Searcher if installed
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" ignores for ctrl-p
set wildignore+=*/tmp/*,*/vendor/*,*/dist/*,*/node_modules/*,*/html/*,*/.sass_cache/*,*.so,*.swp,*.zip     " Linux/MacOSX

