return {
  -- session management
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = { options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help' } },
    config = function()
      require('persistence').setup {}

      vim.keymap.set('n', '<leader>qs', "<cmd>lua require('persistence').load()<cr>", { desc = 'Restore Session' })
      vim.keymap.set(
        'n',
        '<leader>ql',
        "<cmd>lua require('persistence').load({ last = true })<cr>",
        { desc = 'Restore Last Session' }
      )
      vim.keymap.set(
        'n',
        '<leader>qd',
        "<cmd>lua require('persistence').stop()<cr>",
        { desc = "Don't Save Current Session" }
      )
    end,
  },
}
