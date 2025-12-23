require("lazy").setup({
  {'ConradIrwin/vim-bracketed-paste'}, --  iterm2 paste support
  {'HerringtonDarkholme/yats.vim'}, --  TypeScript syntax
  {'airblade/vim-gitgutter'}, --  git gutter
  {'christoomey/vim-tmux-navigator'},
  {'docunext/closetag.vim'}, --  auto-</tag>
  {'editorconfig/editorconfig-vim'},
  {'fatih/vim-go'},
  {'godlygeek/tabular'}, --  note: must come before vim-markdown!
  {'hashivim/vim-terraform'}, --  Terraform!
  {'jiangmiao/auto-pairs'}, --  add matching quote, parens, brackets
  {'jparise/vim-graphql'}, --  graphql syntax
  {'junegunn/fzf'}, --  fuzzy-find
  {'junegunn/fzf.vim'}, --  fuzzy-find, plus
  {'junegunn/goyo.vim'}, --  markdown: no distraction mode
  {'mattn/emmet-vim'}, --  emmet!
  {'pangloss/vim-javascript'}, --  adds updates not included in vim-polyglot
  {'plasticboy/vim-markdown'}, --  adds updates not included in vim-polyglot
  {'prettier/vim-prettier'},
  {'rakr/vim-one'}, --  color scheme
  {'reedes/vim-pencil'}, --  markdown
  {'scrooloose/nerdtree'}, --  tree view
  -- {'sheerun/vim-polyglot'}, --  syntax highlighting
  {'sjl/gundo.vim'}, --  graphical undo!
  {'tpope/vim-commentary'}, --  gcc, gcap
  {'tpope/vim-eunuch'}, --  :Delete, :Rename, :SudoWrite, etc.
  {'tpope/vim-fugitive'}, --  git helpers like :Gblame and :Gdiff
  {'tpope/vim-rhubarb'}, --  github helpers
  {'tpope/vim-surround'}, --  change parens
  {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }}, -- airline, but lazy
  -- {'vim-airline/vim-airline', lazy = false},
  -- {'vim-airline/vim-airline-themes'},
  -- {'vim-scripts/AfterColors.vim'}, --  allow customizing syntax highlighting
  {'w0rp/ale'}, --  linting
}, {
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
})
