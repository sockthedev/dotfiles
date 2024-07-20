return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function(opts)
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
        signs_staged_enable = false,
      }
      vim.keymap.set(
        'n',
        '<leader>gs',
        ':Gitsigns toggle_signs<cr>',
        { noremap = true, silent = true, desc = '[s]igns' }
      )
      vim.keymap.set(
        'n',
        '<leader>gl',
        ':Gitsigns toggle_current_line_blame<cr>',
        { noremap = true, silent = true, desc = '[l]ine blame' }
      )
      vim.keymap.set(
        'n',
        '<leader>gh',
        ':Gitsigns stage_hunk<cr>',
        { noremap = true, silent = true, desc = 'Stage [h]unk' }
      )
    end,
  },

  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>go', ':Git<cr>', { noremap = true, silent = true, desc = '[o]pen' })
      vim.keymap.set('n', '<leader>gb', ':Git blame<cr>', { noremap = true, silent = true, desc = '[b]lame' })
    end,
  },
}
