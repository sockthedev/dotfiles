return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require 'gitsigns'
      gitsigns.setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        signcolumn = false,
        signs_staged_enable = true,
      }
      vim.keymap.set(
        'n',
        '<leader>gs',
        ':Gitsigns toggle_signs<cr>',
        { noremap = true, silent = true, desc = '[s]igns' }
      )
      vim.keymap.set('n', '<leader>gb', ':Gitsigns blame<cr>', { noremap = true, silent = true, desc = '[b]lame' })
    end,
  },

  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('diffview').setup {}

      vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<cr>', { desc = '[d]iffview' })
      vim.keymap.set('n', '<leader>gD', ':DiffviewClose<cr>', { desc = '[D] close diffview' })
      vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory<cr>', { desc = 'file [h]istory' })
      vim.keymap.set('v', '<leader>gh', ":'<,'>DiffviewFileHistory<cr>", { desc = 'file range [h]istory' })
    end,
  },
}
