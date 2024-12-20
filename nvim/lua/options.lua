require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
-- from kenzo!!!!
-- Focus telescope one layer deeper
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files cwd=~/.config/nvim<CR>', { noremap = true, silent = true })
vim.cmd([[
    hi YankyPut guibg=Yellow
    hi YankyYanked guibg=Orange

]])
vim.o.sessionoptions = vim.o.sessionoptions .. ",localoptions"
vim.g.nvim_tree_respect_buf_cwd = 1


