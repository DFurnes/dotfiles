" Swap, backup, and undo
" ----------------------
set backupdir^=~/.vim/backups//
set undodir=~/.vim/undodir

" disable swap file
set noswapfile

set undofile " enables peristent undo (keeps history on file reload)
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
