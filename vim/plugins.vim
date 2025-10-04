set nocompatible
filetype off

call plug#begin()

" tim pope's sensible defaults
Plug 'tpope/vim-sensible'

Plug 'tpope/vim-fugitive'
Plug 'whiteinge/diffconflicts'

Plug 'tpope/vim-markdown'

" tim pope's essentials:
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rsi'

Plug 'tpope/vim-unimpaired'

" gc{motion} for toggle comments
Plug 'numToStr/Comment.nvim'

" enables to search from visual selection (useful for weird strings)
Plug 'nelstrom/vim-visual-star-search'

Plug 'Glench/Vim-Jinja2-Syntax'

" :Rename to rename file in current buffer
Plug 'danro/rename.vim'

" exchange with cx (motion or selection)
Plug 'tommcdo/vim-exchange'

" expand/shrink current visual selection with v/^v
Plug 'terryma/vim-expand-region'

"Plug 'bling/vim-airline'
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'

Plug 'wellle/targets.vim'

" linter for English prose, see :Writegood<TAB...> commands
Plug 'davidbeckingsale/writegood.vim'

Plug 'ekalinin/Dockerfile.vim'

Plug 'embear/vim-localvimrc'

Plug 'MattesGroeger/vim-bookmarks'

Plug 'mbbill/undotree'

Plug 'lewis6991/gitsigns.nvim'

"colorschemes:
Plug 'tomasr/molokai'
Plug 'jacoborus/tender.vim'

Plug 'chr4/nginx.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'hashivim/vim-terraform'
Plug 'andymass/vim-matchup'

" TAB completes everything
Plug 'ervandew/supertab'

Plug 'dhruvasagar/vim-table-mode'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

Plug 'SirVer/ultisnips'

Plug 'mechatroner/rainbow_csv'

Plug 'github/copilot.vim'

" :Goyo to focus on writing
Plug 'junegunn/goyo.vim'

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

Plug 'knsh14/vim-github-link'

Plug 'ranelpadon/python-copy-reference.vim'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

Plug 'voldikss/vim-floaterm'

call plug#end()
