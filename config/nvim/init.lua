-- disable netrw, we'll use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
]])

vim.cmd([[
source ~/.vim/plugins.vim
]])

-- settings in lua:
require('core.settings')
require('plugins.setup')
require('keymaps.custom')

vim.cmd([[
source ~/.vim/coc.vim
source ~/.vim/mappings.vim
]])
