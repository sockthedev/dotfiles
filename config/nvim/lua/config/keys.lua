-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Remap j/k to handle wrapped lines
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('v', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('v', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Create splits
vim.keymap.set('n', '<C-w>\\', '<cmd>vsplit<cr>', { silent = true, desc = 'Vertical split' })
vim.keymap.set('n', '\\', '<cmd>vsplit<cr>', { silent = true, desc = 'Vertical split' })
vim.keymap.set('n', "<C-w>'", '<cmd>split<cr>', { silent = true, desc = 'Horizontal split' })
vim.keymap.set('n', "'", '<cmd>split<cr>', { silent = true, desc = 'Horizontal split' })
vim.keymap.set('n', '<C-w>=', '<cmd>wincmd =<cr>', { silent = true, desc = 'Make all splits equal size' })

-- Insert empty lines without going into insert mode
vim.keymap.set('n', '<A-O>', 'O<Esc>', { desc = 'Insert empty line above' })
vim.keymap.set('n', '<A-o>', 'o<Esc>', { desc = 'Insert empty line below' })

-- Move Lines
vim.keymap.set('n', '<A-j>', ':m .+1<cr>==', { desc = 'Move down' })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<cr>==gi', { desc = 'Move down' })
vim.keymap.set('n', '<A-k>', ':m .-2<cr>==', { desc = 'Move up' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<cr>==gi', { desc = 'Move up' })

-- Create new file
vim.keymap.set('n', '<C-n>', '<cmd>enew<cr>', { silent = true, desc = 'New File' })

-- Save file
vim.keymap.set({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- Better indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Do not yank with x
vim.keymap.set('n', 'x', '"_x', { silent = true })

-- Select all
vim.keymap.set('n', '<leader>a', 'gg<S-v>G', { desc = 'Select All', noremap = true, silent = true })

-- Disable the default <C-a> mapping in visual mode, which would cause numbers to increment
vim.keymap.set('v', '<C-a>', '<Nop>', { desc = 'Noop', noremap = true, silent = true })

-- Toggle relative line numbers
function ToggleRelativeLineNumber()
  if vim.wo.relativenumber == true then
    vim.wo.relativenumber = false
    vim.wo.number = true -- Ensure absolute line numbers are enabled when relative is disabled
  else
    vim.wo.relativenumber = true
    vim.wo.number = true -- Keep absolute line number for the current line
  end
end
vim.keymap.set(
  'n',
  '<leader>cr',
  '<cmd>lua ToggleRelativeLineNumber()<cr>',
  { desc = 'Toggle [r]elative line numbers' }
)
