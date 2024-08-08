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
" Plug 'mtth/scratch.vim'

" exchange with cx (motion or selection)
Plug 'tommcdo/vim-exchange'

" expand/shrink current visual selection with v/^v
Plug 'terryma/vim-expand-region'

Plug 'bling/vim-airline'

Plug 'editorconfig/editorconfig-vim'

Plug 'wellle/targets.vim'

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
Plug 'morhetz/gruvbox'

Plug 'chr4/nginx.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'hashivim/vim-terraform'
Plug 'andymass/vim-matchup'

" Plug 'https://gitlab.com/gi1242/vim-emoji-ab'

" TAB completes everything
Plug 'ervandew/supertab'

Plug 'dhruvasagar/vim-table-mode'

Plug 'skywind3000/asyncrun.vim'
Plug 'jremmen/vim-ripgrep'

" TODO: why is this breaking?
" Plug 'SirVer/ultisnips'

Plug 'mechatroner/rainbow_csv'

Plug 'github/copilot.vim'

Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }

" :Goyo to focus on writing
Plug 'junegunn/goyo.vim'

Plug 'elixir-editors/vim-elixir'

" using this as coc-zls seems broken for now... =/
Plug 'ziglang/zig.vim'

Plug 'niklasl/vim-rdf'

Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }

Plug 'mfussenegger/nvim-dap'

" nvim-nio is dependency of nvim-dap-ui
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'

" requires debugpy installed
Plug 'mfussenegger/nvim-dap-python'

call plug#end()
