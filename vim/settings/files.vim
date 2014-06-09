" Opening/closing files
" ---------------------
" Remember last location in file (except git commit prompt)
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
   \| exe "normal! g`\"" | endif

" automatically read a file that has changed on disk
set autoread

" <ctrl>-b to open nerdtree
map <C-b> :NERDTreeToggle<CR>
