-- [[ Basic Autocommands ]]
--  See :help lua-guide-autocommands

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, { command = 'checktime' })

-- Ensure that no symbols are concealed in markdown files, and that spelling is enabled for them
-- local markdown_augroup = vim.api.nvim_create_augroup('markdown', { clear = true })
-- vim.api.nvim_create_autocmd('FileType', {
--   group = markdown_augroup,
--   pattern = 'markdown',
--   callback = function()
--     vim.opt_local.spell = true
--     vim.opt_local.spelllang = { 'en_us', 'en_gb' }
--     vim.opt_local.conceallevel = 0
--   end,
-- })
