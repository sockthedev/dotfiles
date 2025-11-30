-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
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

-- Navigate splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to bottom split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to top split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right split' })
vim.keymap.set('n', '<C-\\>', '<C-w>p', { desc = 'Go to previous split' })

-- Resize splits
vim.keymap.set('n', '<C-A-h>', '<cmd>vertical resize -2<CR>', { desc = 'Resize left' })
vim.keymap.set('n', '<C-A-j>', '<cmd>resize +2<CR>', { desc = 'Resize down' })
vim.keymap.set('n', '<C-A-k>', '<cmd>resize -2<CR>', { desc = 'Resize up' })
vim.keymap.set('n', '<C-A-l>', '<cmd>vertical resize +2<CR>', { desc = 'Resize right' })

-- Insert empty lines without going into insert mode
vim.keymap.set('n', '<C-S-o>', 'o<Esc>', { desc = 'Insert empty line below' })

-- Move Lines
vim.keymap.set('n', '<C-S-j>', ':m .+1<cr>==', { desc = 'Move down' })
vim.keymap.set('v', '<C-S-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
vim.keymap.set('i', '<C-S-j>', '<Esc>:m .+1<cr>==gi', { desc = 'Move down' })
vim.keymap.set('n', '<C-S-k>', ':m .-2<cr>==', { desc = 'Move up' })
vim.keymap.set('v', '<C-S-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })
vim.keymap.set('i', '<C-S-k>', '<Esc>:m .-2<cr>==gi', { desc = 'Move up' })

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
vim.keymap.set('n', '<C-a>', 'gg<S-v>G', { desc = 'Select All', noremap = true, silent = true })

-- Disable the default <C-a> mapping in visual mode, which would cause numbers to increment
vim.keymap.set('v', '<C-a>', '<Nop>', { desc = 'Noop', noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>eq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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

-- Use leader x to close the current tab
vim.keymap.set('n', '<leader>x', '<cmd>tabclose<cr>', { desc = '[x] close tab' })

-- Use leader , for prev tab, and . for next tab
vim.keymap.set('n', '<leader>[', '<cmd>tabprevious<cr>', { desc = 'Prev tab' })
vim.keymap.set('n', '<leader>]', '<cmd>tabnext<cr>', { desc = 'Next tab' })
