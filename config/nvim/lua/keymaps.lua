-- Turn off search highlight
vim.keymap.set('n', '<leader>q', '<CMD>nohlsearch<CR>')
vim.keymap.set('n', '<Esc>', '<CMD>nohlsearch<CR>')

-- These diagnostic keymaps are created unconditionally when Nvim starts:
-- `]d` jumps to the next diagnostic in the buffer. |]d-default|
-- [d` jumps to the previous diagnostic in the buffer. |[d-default|
-- ]D` jumps to the last diagnostic in the buffer. |]D-default|
-- [D` jumps to the first diagnostic in the buffer. |[D-default|
-- <C-w>d` shows diagnostic at cursor in a floating window. |CTRL-W_d-default|
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, { desc = 'Open diagnostics quickfix list' })

-- Switch between source/header
vim.api.nvim_create_user_command('A', 'ClangdSwitchSourceHeader', {})

-- Make Oil behave like vim-vinegar
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>t', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fr', builtin.resume, {})
-- Use Ctrl-q to send the result in the quickfix window

-- clipboard=autoselect is not implemented yet
vim.keymap.set('v', '<LeftRelease>', '"*ygv', { noremap = true, silent = true })
vim.keymap.set('v', '<2-LeftRelease>', '"*ygv', { noremap = true, silent = true })
