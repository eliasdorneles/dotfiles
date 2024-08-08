vim.cmd('set nu')

-- mini.nvim config:
require('mini.pairs').setup()
require('mini.files').setup()


-- CopilotChat settings:
require("CopilotChat").setup {
    debug = true,
    show_help = "yes",
}

-- nvim-dap settings
require("dap-python").setup("python")

-- nvim dap mappings
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<M-b>', function() require('dap').toggle_breakpoint() end)

local dap, dapui = require("dap"), require("dapui")
dapui.setup()

-- open Dap UI automatically when debug starts (e.g. after <F5>)
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

-- close Dap UI with :DapCloseUI
vim.api.nvim_create_user_command("DapCloseUI", function()
    require("dapui").close()
end, {})

-- use <Alt-e> to eval expressions
vim.keymap.set({ 'n', 'v' }, '<M-e>', function() require('dapui').eval() end)
