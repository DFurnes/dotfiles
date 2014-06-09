" Filetypes & syntax highlighting
" ----------------------------------
syntax on
filetype off
filetype indent on
filetype plugin on
set encoding=utf-8

" json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" jbuilder syntax highlighting
au BufNewFile,BufRead Brewfile set ft=sh

" jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby


" syntax highlighting for Lo-dash template files (.tpl.html)
au BufRead,BufNewFile *.tpl.html set filetype=eruby.html

set showmatch " show matching brackets

" configure javascript libraries used for syntax highlighting
let g:used_javascript_libs = 'jquery,underscore,requirejs'

" syntax highlighting for *.md files
au BufRead,BufNewFile *.md set filetype=markdown

" turn-on distraction free writing mode for markdown files
" au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} call DistractionFreeWriting()

" function! DistractionFreeWriting()
"   set lines=40 columns=100           " size of the editable area
"   set noruler                        " don't show ruler
"   set fullscreen                     " go to fullscreen editing mode
"   set linebreak                      " break the lines on words
" endfunction
