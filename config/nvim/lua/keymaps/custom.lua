local map = vim.keymap.set

-- Tab navigation
map("n", "<S-H>", "gT", { desc = "Previous tab" })
map("n", "<S-L>", "gt", { desc = "Next tab" })

-- Expand region plugin mappings
map("v", "v", "<Plug>(expand_region_expand)", { desc = "Expand region" })
map("v", "<C-v>", "<Plug>(expand_region_shrink)", { desc = "Shrink region" })

-- File path expansion in command mode
map("c", "%%", function()
    return vim.fn.getcmdtype() == ":" and vim.fn.expand("%:h") .. "/" or "%%"
end, { expr = true, desc = "Expand current file directory" })

-- Visual select last edited/pasted text
map("n", "gV", "`[v`]", { desc = "Select last edited/pasted text" })

-- Common typos
local cabbrev = function(abbrev, expansion)
    vim.cmd("cabbrev " .. abbrev .. " " .. expansion)
end
cabbrev("W", "w")
cabbrev("Q", "q")
cabbrev("Wq", "wq")
cabbrev("wQ", "wq")
cabbrev("WQ", "wq")
cabbrev("Qa", "qa")
cabbrev("QA", "qa")

-- Folding
map("n", "<leader>l", "za", { desc = "Toggle fold" })
map("n", "<leader>f", function()
    vim.opt.foldenable = not vim.opt.foldenable:get()
end, { desc = "Toggle folding" })

-- Save with Ctrl+S
map("n", "<C-S>", function()
    if vim.bo.modified then
        if vim.fn.empty(vim.fn.bufname("%")) == 1 then
            vim.cmd("browse confirm write")
        else
            vim.cmd("confirm write")
        end
    end
end, { desc = "Save file" })
map("i", "<C-S>", "<Esc>:<C-u>SaveCurrentFile<CR>a", { desc = "Save file" })

-- Exit with Ctrl+Q
map("n", "<C-Q>", ":qa<CR>", { desc = "Exit Neovim" })

-- Quick no-regex search
map("n", "<C-f>", "/\\V", { desc = "Quick no-regex search" })

-- Alternative escape keys
map("i", "<C-c>", "<esc>", { desc = "Alternative escape" })
map("n", "<C-3>", "<esc>", { desc = "Alternative escape" })

-- Go to previous file
map("n", "<leader><space>", "<c-^>", { desc = "Go to previous file" })

-- Disable highlight search on Enter
map("n", "<CR>", ":nohlsearch<CR><CR>", { desc = "Clear search highlight" })

-- Clipboard operations
map("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map("n", "<leader>P", '"+P', { desc = "Paste from system clipboard" })

-- Telescope mappings
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<C-g>", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })

-- Gitsigns mappings
local gitsigns = {
    stage_hunk = "Stage hunk",
    next_hunk = "Next hunk",
    prev_hunk = "Previous hunk",
    reset_hunk = "Reset hunk",
    preview_hunk = "Preview hunk",
    stage_buffer = "Stage buffer",
    reset_buffer = "Reset buffer",
    blame_line = "Blame line"
}

for action, desc in pairs(gitsigns) do
    map("n", "<C-h>" .. action:sub(1, 1), "<cmd>Gitsigns " .. action .. "<cr>", { desc = desc })
    map("n", "<leader>h" .. action:sub(1, 1), "<cmd>Gitsigns " .. action .. "<cr>", { desc = desc })
end

