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

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

" This plugin adds extra text objects, e.g. for separators like comma, semicolon, etc.
" See :help targets
Plug 'wellle/targets.vim'

Plug 'ekalinin/Dockerfile.vim'

Plug 'embear/vim-localvimrc'

Plug 'MattesGroeger/vim-bookmarks'

Plug 'mbbill/undotree'

Plug 'lewis6991/gitsigns.nvim'

"colorschemes:
Plug 'tomasr/molokai'

Plug 'chr4/nginx.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'hashivim/vim-terraform'
Plug 'andymass/vim-matchup'

" TAB completes everything
Plug 'ervandew/supertab'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': 'v0.2.1' }

Plug 'SirVer/ultisnips'

Plug 'mechatroner/rainbow_csv'

Plug 'github/copilot.vim'

Plug 'https://codeberg.org/ziglang/zig.vim'

Plug 'niklasl/vim-rdf'

Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }

Plug 'mfussenegger/nvim-dap'

Plug 'nvim-neotest/nvim-nio' " transitional dependency of nvim-dap-ui
Plug 'rcarriga/nvim-dap-ui'

" requires debugpy installed
Plug 'mfussenegger/nvim-dap-python'

Plug 'knsh14/vim-github-link'

" This plugin allows to copy reference of current symbol in various formats
" Current mappings:
" <leader>y. copy as dotted path, e.g. mymodule.submodule.Class.method
" <leader>yt copy as pytest path, e.g. mymodule/submodule.py::Class::method
" <leader>yi copy as import path, e.g. from mymodule.submodule import Class
Plug 'ranelpadon/python-copy-reference.vim'

" This plugin provides floating terminal, currently mapped to:
" <F7> to toggle, <F6> to open new and <f8> to cycle through open terminals
Plug 'voldikss/vim-floaterm'

call plug#end()
