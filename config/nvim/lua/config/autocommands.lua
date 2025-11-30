-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, { command = 'checktime' })

-- Enter insert mode when opening a terminal
-- vim.api.nvim_create_autocmd('TermOpen', {
--   desc = 'Enter insert mode when opening a terminal',
--   group = vim.api.nvim_create_augroup('terminal-insert-mode', { clear = true }),
--   callback = function()
--     vim.cmd('startinsert')
--   end,
-- })
