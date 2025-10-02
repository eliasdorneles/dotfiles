-- disable startup message
vim.opt.shortmess:append("I")

vim.opt.number = true

-- Prefer spaces over TABs, expand TABs by default
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = {
    tab = "▸ ",
    trail = "·",
    nbsp = "_"
}

-- Keep undo history across sessions
vim.opt.undolevels = 1000
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.fn.system("mkdir -p " .. vim.opt.undodir:get()[1]) -- we need get()[1] because undodir is a list

-- setup swap files dir per user
local swap_dir = vim.fn.expand("$HOME") .. "/.swap-" .. vim.env.USER .. "-vim"
vim.fn.system("mkdir -p " .. swap_dir)
vim.opt.directory = swap_dir

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved
vim.opt.signcolumn = "yes"

-- Disable folding
vim.opt.foldenable = false

-- Grails configuration
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.gsp",
    callback = function()
        vim.bo.filetype = "jsp"
    end
})

-- Highlight trailing whitespace in red
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*",
    callback = function()
        vim.cmd([[syntax match annoyingwhitespace '\s\+$']])
        vim.cmd([[highlight annoyingwhitespace ctermbg=red]])
    end
})

-- Add hyphen to word characters in CSS/SCSS/Sass files for better word completion
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"css", "scss", "sass"},
    callback = function()
        vim.bo.iskeyword = vim.bo.iskeyword .. ",-"
    end
})

-- Set tabstop to 2 spaces for YAML and JS files
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"yaml", "js"},
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.shiftwidth = 2
    end
})

-- Set filetype for strace dump files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.strace",
    callback = function()
        vim.bo.filetype = "strace"
    end
})

-- Highlight 'self' keyword in Python files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.cmd([[syntax match keyword '\<self\>']])
    end
})

-- Highlight 'in' and 'not_in' keywords in Odin files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "odin",
    callback = function()
        vim.cmd([[syntax match Statement ' in ']])
        vim.cmd([[syntax match Statement ' not_in ']])
        vim.cmd([[syntax match Statement '\<fallthrough\>']])
        vim.cmd([[syntax match Statement '\<context\>']])
    end
})

-- Set filetype for Turtle RDF files
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.ttl",
    callback = function()
        vim.bo.filetype = "turtle"
    end
})

-- Generate help tags for personal documentation
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = vim.fn.expand("~/.vim/doc/*.txt"),
    callback = function()
        vim.cmd("helptags ~/.vim/doc")
    end
})

-- restore last cursor position, copied from :help restore-cursor
vim.cmd([[
    augroup RestoreCursor
      autocmd!
      autocmd BufReadPre * autocmd FileType <buffer> ++once
        \ let s:line = line("'\"")
        \ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
        \      && index(['xxd', 'gitrebase'], &filetype) == -1
        \ |   execute "normal! g`\""
        \ | endif
    augroup END
]])

-- Set colorscheme
local colorscheme = "molokai"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.cmd("colorscheme default")
    vim.opt.background = "dark"
end

-- Set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
