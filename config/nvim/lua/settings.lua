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
vim.keymap.set('n', '<Leader>bb', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>BB', function() require('dap').set_breakpoint() end)

-- open nvim-dap-ui automatically when start dap
local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

-- vim.keymap.set('n', '<Leader>bs', function() require('dap').repl.open() end)
-- vim.keymap.set('n', '<Leader>bl', function() require('dap').run_last() end)
--
-- vim.keymap.set({ 'n', 'v' }, '<Leader>bk', function()
--     require('dap.ui.widgets').hover()
-- end)
--
-- vim.keymap.set({ 'n', 'v' }, '<Leader>bp', function()
--     require('dap.ui.widgets').preview()
-- end)
--
-- vim.keymap.set('n', '<Leader>bf', function()
--     local widgets = require('dap.ui.widgets')
--     widgets.centered_float(widgets.frames)
-- end)
--
-- -- show variables in global and local scopes
-- vim.keymap.set('n', '<Leader>bv', function()
--     local widgets = require('dap.ui.widgets')
--     widgets.centered_float(widgets.scopes)
-- end)
--
-- -- use just q to close the mini widgets
-- vim.cmd([[
-- autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>
-- ]])
