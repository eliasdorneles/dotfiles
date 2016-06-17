set nocompatible
filetype off

set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" tim pope's sensible defaults
Bundle "tpope/vim-sensible"

" TAB completes everything
Bundle "ervandew/supertab"

Bundle "godlygeek/tabular"

" JS stuff
Bundle "pangloss/vim-javascript"

Bundle "tpope/vim-fugitive"
"Bundle "tpope/vim-git"
Bundle "tpope/vim-markdown"

" tim pope's essentials:
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-rsi"

Bundle "tpope/vim-unimpaired"

" gc{motion} for toggle comments
Bundle "tomtom/tcomment_vim"

" Ctrl-P, Ctrl-P, Ctrl-P, Ctrl-P!
Bundle "kien/ctrlp.vim"

Bundle "tpope/vim-capslock"
Bundle "scrooloose/syntastic"
Bundle "othree/html5.vim"
Bundle "fatih/vim-go"

Bundle "derekwyatt/vim-scala"

" enables to search from visual selection (useful for weird strings)
Bundle "nelstrom/vim-visual-star-search"

" pep8 utils
Bundle "hynek/vim-python-pep8-indent"
Bundle "nvie/vim-flake8"

Bundle "mattn/emmet-vim"

" snipmate and dependencies:
Bundle "tomtom/tlib_vim"
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "garbas/vim-snipmate"

Bundle "Glench/Vim-Jinja2-Syntax"

Bundle "jimenezrick/vimerl"

Bundle "majutsushi/tagbar"

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

Bundle "tomasr/molokai"

Bundle 'bling/vim-airline'

Bundle 'editorconfig/editorconfig-vim'

Bundle 'kana/vim-textobj-user'
Bundle 'bps/vim-textobj-python'

Bundle 'kchmck/vim-coffee-script'

Bundle 'tmhedberg/SimpylFold'

Bundle 'davidbeckingsale/writegood.vim'

Bundle 'ekalinin/Dockerfile.vim'
Bundle 'lambdatoast/elm.vim'

" Python completion and goto definition
Bundle 'davidhalter/jedi-vim'

Bundle 'python-rope/ropevim'

Bundle 'saltstack/salt-vim'

Bundle 'embear/vim-localvimrc'

Bundle 'MattesGroeger/vim-bookmarks'

Bundle 'mbbill/undotree'

Bundle 'airblade/vim-gitgutter'
