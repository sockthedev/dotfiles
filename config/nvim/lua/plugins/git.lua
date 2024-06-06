return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set(
        'n',
        '<leader>gf',
        '<cmd>tab Git<cr>',
        { noremap = true, silent = true, desc = 'Open Fugitive in Tab' }
      )
    end,
  },
}
