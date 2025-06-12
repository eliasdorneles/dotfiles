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

vim.cmd([[
source ~/.vim/coc.vim
source ~/.vim/mappings.vim
]])
