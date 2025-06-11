vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- disable startup message
vim.opt.shortmess:append("I")

-- split by default to the right and below
vim.opt.splitbelow = true
vim.opt.splitright = true

-- setup swap files dir per user
local swap_dir = vim.fn.expand("$HOME") .. "/.swap-" .. vim.env.USER .. "-vim"
vim.fn.system("mkdir -p " .. swap_dir)
vim.opt.directory = swap_dir

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved
vim.opt.signcolumn = "yes"

-- starts with mouse in vim mode
vim.opt.mouse = "a"

vim.opt.scrolloff = 2
vim.opt.modeline = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- when tab-completing, complete the longest and display menu w/ options
vim.opt.wildmode = "longest:full"

vim.opt.foldenable = false
vim.opt.showcmd = true

vim.opt.clipboard = "unnamed"
vim.opt.number = true