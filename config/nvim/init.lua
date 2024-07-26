vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
]])


vim.cmd([[
source ~/.vim/plugins.vim
source ~/.vim/settings.vim
source ~/.vim/mappings.vim
]])
