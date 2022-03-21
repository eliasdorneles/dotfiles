set nocompatible
filetype off

call plug#begin()

" tim pope's sensible defaults
Plug 'tpope/vim-sensible'

" left align stuff with :Tab /<search here>
" (use \zs after search expr to leave it left-side)
Plug 'godlygeek/tabular'

" JS stuff
Plug 'pangloss/vim-javascript'
" Plug 'isRuslan/vim-es6'

Plug 'tpope/vim-fugitive'
Plug 'whiteinge/diffconflicts'

Plug 'tpope/vim-markdown'

" tim pope's essentials:
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rsi'

Plug 'tpope/vim-unimpaired'

" gc{motion} for toggle comments
Plug 'tomtom/tcomment_vim'

" Ctrl-P, Ctrl-P, Ctrl-P, Ctrl-P!
Plug 'ctrlpvim/ctrlp.vim'

" enables to search from visual selection (useful for weird strings)
Plug 'nelstrom/vim-visual-star-search'

" quick html writing with: TAGNAME<ctrl-space>
Plug 'mattn/emmet-vim'

Plug 'Glench/Vim-Jinja2-Syntax'

Plug 'preservim/tagbar'

" :Rename to rename file in current buffer
Plug 'danro/rename.vim'

" :Scratch to open scratch window
Plug 'mtth/scratch.vim'

" exchange with cx (motion or selection)
Plug 'tommcdo/vim-exchange'

" expand/shrink current visual selection with v/^v
Plug 'terryma/vim-expand-region'

Plug 'bling/vim-airline'

Plug 'editorconfig/editorconfig-vim'

Plug 'kana/vim-textobj-user'

" adds Python text objects: af (around function), ac (around class)
" TODO: check why it breaks for arguments in multiple lines
Plug 'bps/vim-textobj-python'

" linter for English prose, see :Writegood<TAB...> commands
Plug 'davidbeckingsale/writegood.vim'

Plug 'ekalinin/Dockerfile.vim'

Plug 'embear/vim-localvimrc'

Plug 'MattesGroeger/vim-bookmarks'

Plug 'mbbill/undotree'

Plug 'airblade/vim-gitgutter'

"colorschemes:
Plug 'tomasr/molokai'
Plug 'jacoborus/tender.vim'

Plug 'chr4/nginx.vim'

"TODO: disaibling this to check if it is still useful
" Plug 'sheerun/vim-polyglot'

Plug 'w0rp/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'rhysd/vim-lsp-ale'

Plug 'wellle/targets.vim'

" TODO: consider finding a lsp-based replacement for this
Plug 'prettier/vim-prettier'

Plug 'hashivim/vim-terraform'
Plug 'andymass/vim-matchup'

Plug 'https://gitlab.com/gi1242/vim-emoji-ab'

" TAB completes everything
Plug 'ervandew/supertab'

Plug 'dhruvasagar/vim-table-mode'
Plug 'vimwiki/vimwiki'

Plug 'skywind3000/asyncrun.vim'
Plug 'jremmen/vim-ripgrep'

Plug 'SirVer/ultisnips'

call plug#end()
