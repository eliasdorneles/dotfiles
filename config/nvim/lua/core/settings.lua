-- disable startup message
vim.opt.shortmess:append("I")

-- setup swap files dir per user
local swap_dir = vim.fn.expand("$HOME") .. "/.swap-" .. vim.env.USER .. "-vim"
vim.fn.system("mkdir -p " .. swap_dir)
vim.opt.directory = swap_dir

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved
vim.opt.signcolumn = "yes"

vim.opt.foldenable = false