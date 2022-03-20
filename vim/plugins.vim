set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" tim pope's sensible defaults
Bundle "tpope/vim-sensible"

Bundle "godlygeek/tabular"

" JS stuff
Bundle "pangloss/vim-javascript"
" Bundle "isRuslan/vim-es6"

Bundle "tpope/vim-fugitive"
Bundle "whiteinge/diffconflicts"

Bundle "tpope/vim-markdown"

" tim pope's essentials:
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-rsi"

Bundle "tpope/vim-unimpaired"

" gc{motion} for toggle comments
Bundle "tomtom/tcomment_vim"

" Ctrl-P, Ctrl-P, Ctrl-P, Ctrl-P!
Bundle "ctrlpvim/ctrlp.vim"

" enables to search from visual selection (useful for weird strings)
Bundle "nelstrom/vim-visual-star-search"

" quick html writing with: TAGNAME<ctrl-space>
Bundle "mattn/emmet-vim"

Bundle "Glench/Vim-Jinja2-Syntax"

Bundle "preservim/tagbar"

" :Rename to rename file in current buffer
Bundle "danro/rename.vim"

" :Scratch to open scratch window
Bundle "mtth/scratch.vim"

" exchange with cx (motion or selection)
Bundle "tommcdo/vim-exchange"

" expand region
Bundle "terryma/vim-expand-region"

Bundle "sjl/clam.vim"
Bundle 'terryma/vim-multiple-cursors'

Bundle 'bling/vim-airline'

Bundle 'editorconfig/editorconfig-vim'

Bundle 'kana/vim-textobj-user'
Bundle 'bps/vim-textobj-python'

" linter for English prose, see :Writegood<TAB...> commands
Bundle 'davidbeckingsale/writegood.vim'

Bundle 'ekalinin/Dockerfile.vim'

Bundle 'prabirshrestha/vim-lsp'

Bundle 'embear/vim-localvimrc'

Bundle 'MattesGroeger/vim-bookmarks'

Bundle 'mbbill/undotree'

Bundle 'airblade/vim-gitgutter'

"colorschemes:
Plugin 'tomasr/molokai'
Plugin 'jacoborus/tender.vim'

Bundle 'chr4/nginx.vim'

Bundle 'elixir-lang/vim-elixir'

Bundle 'tfnico/vim-gradle'

"TODO: disaibling this to check if it is still useful
" Bundle 'sheerun/vim-polyglot'

Bundle 'w0rp/ale'

Bundle 'wellle/targets.vim'

" TODO: consider finding a lsp-based replacement for this
Bundle 'prettier/vim-prettier'

Bundle 'hashivim/vim-terraform'
Bundle 'andymass/vim-matchup'

Bundle 'https://gitlab.com/gi1242/vim-emoji-ab'

" TAB completes everything
Bundle "ervandew/supertab"

Bundle 'dhruvasagar/vim-table-mode'
Bundle 'vimwiki/vimwiki'

Bundle 'skywind3000/asyncrun.vim'
Bundle 'jremmen/vim-ripgrep'

Bundle "SirVer/ultisnips"
