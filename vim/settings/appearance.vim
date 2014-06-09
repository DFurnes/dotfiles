" Appearance & color scheme
" -------------------------

set term=screen-256color
set t_Co=256
set background=dark 
colorscheme base16-default

" fix background display issue in tmux
set t_ut=

" use mouse in terminal vim
set mouse=a

" line numbers
set ruler " show line numbers
set relativenumber " relative line numbers
set number " shows current line as absolute line number (Vim 7.4+)
set cul " highlights current line

" keep 5 lines above/below the cursor when scrolling
set scrolloff=5

" don't be annoying
set noerrorbells
set novisualbell

" show powerline all the time
set laststatus=2

" gui options
set guifont=Menlo:h12

if has("gui_running")
  set guioptions-=T
  set guioptions-=L
  set guioptions-=R
endif
