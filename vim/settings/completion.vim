" Code Completion
" ---------------
set omnifunc=syntaxcomplete#Complete

let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" TernJS things
nmap <leader>d :TernDef
nmap <leader>f :TernDoc

" UltiSnips
let g:UltiSnipsExpandTrigger="<C-S>"
let g:UltiSnipsJumpForwardTrigger="<C-S>"
let g:UltiSnipsJumpBackwardTrigger="<C-D>"
