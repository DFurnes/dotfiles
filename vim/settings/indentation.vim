" Indentation / Tab settings
" --------------------------
set expandtab
set tabstop=2
set shiftwidth=2
set backspace=2
set autoindent
set smartindent
set nocindent

" use tabs in makefiles 
au FileType make setlocal noexpandtab
