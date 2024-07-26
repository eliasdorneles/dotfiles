vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
]])

vim.cmd([[
source ~/.vim/plugins.vim
source ~/.vim/settings.vim
]])

-- settings in lua:
require('settings')

vim.cmd([[
source ~/.vim/mappings.vim
]])
