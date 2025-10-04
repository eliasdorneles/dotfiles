-- mini.nvim config:
-- require('mini.pairs').setup()
if pcall(require, 'mini.files') then
    require('mini.files').setup()
end

-- load plugins
require("lualine").setup()
require("Comment").setup()

-- Undotree settings
vim.g.undotree_WindowLayout = 4

-- Bookmark settings
vim.g.bookmark_manage_per_buffer = 1

-- Localvimrc settings
vim.g.localvimrc_whitelist = {
    vim.fs.joinpath(os.getenv("HOME"), "/code/.*"),
}

-- Floaterm settings and keymaps
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.g.floaterm_keymap_toggle = '<F7>'
vim.g.floaterm_keymap_new = '<leader>to'
vim.g.floaterm_keymap_prev   = '<leader>tp'
vim.g.floaterm_keymap_next   = '<leader>tn'

-- Copilot configuration
vim.g.copilot_filetypes = {
    ['*'] = false,
    gitcommit = true,
    python = true,
    javascript = true,
    Dockerfile = true,
    vue = true,
    js = true,
    sh = true,
    html = true,
    json = true,
    make = true,
    vim = true,
    conf = true,
    c = true,
    zig = true,
    cpp = true,
    sql = true,
    yaml = true,
}

-- nvim-dap settings
if pcall(require, 'dap-python') then
    require("dap-python").setup("python")
    require("plugins.dap-setup")
end

require("nvim-tree").setup()
