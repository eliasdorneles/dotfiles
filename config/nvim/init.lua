vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
]])

vim.cmd([[
source ~/.vim/plugins.vim
source ~/.vim/settings.vim
source ~/.vim/coc.vim
]])

-- settings in lua:
require('core.settings')
require('plugins.setup')

vim.cmd([[
source ~/.vim/mappings.vim
]])
