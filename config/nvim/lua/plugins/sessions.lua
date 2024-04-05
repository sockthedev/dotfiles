return {
  -- session management
  {
    'folke/persistence.nvim',
    config = function()
      require('persistence').setup { options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help' } }

      vim.keymap.set('n', '<leader>pl', "<cmd>lua require('persistence').load()<cr>", { desc = 'Restore Session' })

      vim.keymap.set(
        'n',
        '<leader>pd',
        "<cmd>lua require('persistence').stop()<cr>",
        { desc = "Don't Save Current Session" }
      )
    end,
  },
}
