vim.cmd('set nu')

-- mini.nvim config:
require('mini.pairs').setup()
require('mini.files').setup()


-- CopilotChat settings:
require("CopilotChat").setup {
    debug = true,
    show_help = "yes",
}
