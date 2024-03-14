return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('harpoon').setup {
      tabline = false,
      tabline_prefix = ' ',
      tabline_suffix = '  ',
    }

    vim.keymap.set('n', '<C-M-j>', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = 'Toggle' })
    vim.keymap.set('n', '<C-M-k>', "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = 'Add file' })

    vim.keymap.set('n', '<C-M-l>', "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = 'Go next' })
    vim.keymap.set('n', '<C-M-h>', "<cmd>lua require('harpoon.ui').nav_prev()<cr>", { desc = 'Go prev' })
  end,
}
